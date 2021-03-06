import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/calculator/calculator_dto.dart';
import 'package:should_have_bought_app/models/calculator/calculator_stock.dart';
import 'package:should_have_bought_app/models/calculator/result/calculator_stock_all.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/widgets/calculator/result/at_this_time_item.dart';

class TempWidget extends StatefulWidget {
  @override
  _TempWidgetState createState() => _TempWidgetState();
}

class _TempWidgetState extends State<TempWidget> with TickerProviderStateMixin {
  TabController _controller;
  AnimationController _animationControllerOn;
  AnimationController _animationControllerOff;

  Animation _colorTweenBackgroundOn;
  Animation _colorTweenBackgroundOff;

  Animation _colorTweenForegroundOn;
  Animation _colorTweenForegroundOff;

  int _currentIndex = 0;
  int _prevControllerIndex = 0;

  double _aniValue = 0.0;
  double _prevAniValue = 0.0;

  final List<String> _yearsText = [
    'DAY1',
    'WEEK1',
    'YEAR1',
    'YEAR10',
  ];

  final List<String> _texts = [
    '어제 살걸',
    '저번주에 살걸',
    '작년에 살걸',
    '10년전에 살걸',
  ];

  final Color _foregroundOn = Colors.white;
  final Color _foregroundOff = Colors.black;

  final Color _backgroundOn = mainColor;
  final Color _backgroundOff = Colors.grey[200];

  final ScrollController _scrollController = ScrollController();

  final List _keys = [];

  bool _buttonTap = false;

  @override
  void initState() {
    super.initState();
    for (var index = 0; index < _texts.length; index++) {
      _keys.add(GlobalKey());
    }
    _controller = TabController(vsync: this, length: _texts.length);
    _controller.animation.addListener(_handleTabAnimation);
    _controller.addListener(_handleTabChange);

    _animationControllerOff =
        AnimationController(vsync: this, duration: Duration(milliseconds: 75));
    _animationControllerOff.value = 1.0;

    _colorTweenBackgroundOff =
        ColorTween(begin: _backgroundOn, end: _backgroundOff)
            .animate(_animationControllerOff);
    _colorTweenForegroundOff =
        ColorTween(begin: _foregroundOn, end: _foregroundOff)
            .animate(_animationControllerOff);

    _animationControllerOn =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    _animationControllerOn.value = 1.0;

    _colorTweenBackgroundOn =
        ColorTween(begin: _backgroundOff, end: _backgroundOn)
            .animate(_animationControllerOn);
    _colorTweenForegroundOn =
        ColorTween(begin: _foregroundOff, end: _foregroundOn)
            .animate(_animationControllerOn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isLoading = false;
  @override
  void didChangeDependencies() {
    setState(() {
      isLoading = true;
    });
    Provider.of<CalculatorProvider>(context, listen: false)
        .getFourResult()
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
        builder: (context, calculatorProvider, child) {
      final _fourResult = calculatorProvider.calculationResultAll;
      return Column(
        children: <Widget>[
          Container(
            height: 150.0,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _yearsText.length,
              itemBuilder: (context, index) {
                return Container(
                  key: _keys[index],
                  child: ButtonTheme(
                    child: AnimatedBuilder(
                      animation: _colorTweenBackgroundOn,
                      builder: (context, child) => ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0.0),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(150.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            _getBackgroundColor(index),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _buttonTap = true;
                            _controller.animateTo(index);
                            _setCurrentIndex(index);
                            _scrollTo(index);
                          });
                        },
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150),
                            color: Colors.transparent,
                            border: Border.all(
                              color: _getBackgroundColor(index),
                              width: 3.0,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 150.0,
                            backgroundColor: Colors.white,
                            child: Image(
                              image:
                                  AssetImage('assets/images/normal_chick.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }

  _handleTabAnimation() {
    // gets the value of the animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
    _aniValue = _controller.animation.value;

    // if the button wasn't pressed, which means the user is swiping, and the amount swipped is less than 1 (this means that we're swiping through neighbor Tab Views)
    if (!_buttonTap && ((_aniValue - _prevAniValue).abs() < 1)) {
      // set the current tab index
      _setCurrentIndex(_aniValue.round());
    }

    // save the previous Animation Value
    _prevAniValue = _aniValue;
  }

  // runs when the displayed tab changes
  _handleTabChange() {
    // if a button was tapped, change the current index
    if (_buttonTap) _setCurrentIndex(_controller.index);

    // this resets the button tap
    if ((_controller.index == _prevControllerIndex) ||
        (_controller.index == _aniValue.round())) _buttonTap = false;

    // save the previous controller index
    _prevControllerIndex = _controller.index;
  }

  _setCurrentIndex(int index) {
    // if we're actually changing the index
    if (index != _currentIndex) {
      setState(() {
        // change the index
        _currentIndex = index;
      });

      // trigger the button animation
      _triggerAnimation();
      // scroll the TabBar to the correct position (if we have a scrollable bar)
      _scrollTo(index);
    }
  }

  _triggerAnimation() {
    // reset the animations so they're ready to go
    _animationControllerOn.reset();
    _animationControllerOff.reset();

    // run the animations!
    _animationControllerOn.forward();
    _animationControllerOff.forward();
  }

  _scrollTo(int index) {
    // get the screen width. This is used to check if we have an element off screen
    double screenWidth = MediaQuery.of(context).size.width;

    // get the button we want to scroll to
    RenderBox renderBox = _keys[index].currentContext.findRenderObject();
    // get its size
    double size = renderBox.size.width;
    // and position
    double position = renderBox.localToGlobal(Offset.zero).dx;

    // this is how much the button is away from the center of the screen and how much we must scroll to get it into place
    double offset = (position + size / 2) - screenWidth / 2;

    // if the button is to the left of the middle
    if (offset < 0) {
      // get the first button
      renderBox = _keys[0].currentContext.findRenderObject();
      // get the position of the first button of the TabBar
      position = renderBox.localToGlobal(Offset.zero).dx;

      // if the offset pulls the first button away from the left side, we limit that movement so the first button is stuck to the left side
      if (position > offset) offset = position;
    } else {
      // if the button is to the right of the middle
      // get the last button
      renderBox = _keys[_texts.length - 1].currentContext.findRenderObject();
      // get its position
      position = renderBox.localToGlobal(Offset.zero).dx;
      // and size
      size = renderBox.size.width;

      // if the last button doesn't reach the right side, use it's right side as the limit of the screen for the TabBar
      if (position + size < screenWidth) screenWidth = position + size;

      // if the offset pulls the last button away from the right side limit, we reduce that movement so the last button is stuck to the right side limit
      if (position + size - offset < screenWidth) {
        offset = position + size - screenWidth;
      }
    }

    // scroll the calculated ammount
    _scrollController.animateTo(offset + _scrollController.offset,
        duration: Duration(milliseconds: 150), curve: Curves.easeInOut);
  }

  _getBackgroundColor(int index) {
    if (index == _currentIndex) {
      // if it's active button
      return _colorTweenBackgroundOn.value;
    } else if (index == _prevControllerIndex) {
      // if it's the previous active button
      return _colorTweenBackgroundOff.value;
    } else {
      // if the button is inactive
      return _backgroundOff;
    }
  }

  _getForegroundColor(int index) {
    // the same as the above
    if (index == _currentIndex) {
      return _colorTweenForegroundOn.value;
    } else if (index == _prevControllerIndex) {
      return _colorTweenForegroundOff.value;
    } else {
      return _foregroundOff;
    }
  }

  _getForegroundFontWeight(int index) {
    if (index == _currentIndex) {
      return FontWeight.w700;
    } else {
      return FontWeight.w300;
    }
  }
}

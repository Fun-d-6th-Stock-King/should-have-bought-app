import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class CalculatorWidget extends StatefulWidget {
  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {

  final TextEditingController _controller = new TextEditingController();

  String _selectedDateValue = '10년 전';
  String _selectedCompanyValue = '삼성전자';
  int _selectedPriceValue = 100000;
  int value = 0;
  List<String> dates = ['어제', '저번주', '한달 전', '6개월 전', '1년 전', '5년 전', '10년 전'];
  List<String> company = [
    '삼성전자',
    '삼성SDI',
    '삼성전기',
    '삼성물산',
    '카카오',
    'LG 전자',
    'LG 디스플레이'
  ];

  void _showDatePicker(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        width: _screenSize.width,
        height: _screenSize.height * 0.3,
        child: CupertinoPicker(
          backgroundColor: Colors.white,
          itemExtent: 30,
          scrollController: FixedExtentScrollController(initialItem: 1),
          children: [for (String val in dates) Text(val)],
          onSelectedItemChanged: (value) {
            setState(() {
              _selectedDateValue = dates[value];
              print('_selectedDateValue : $_selectedDateValue');
            });
          },
        ),
      ),
    );
  }

  void _showComponyPicker(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        width: _screenSize.width,
        height: _screenSize.height * 0.3,
        child: CupertinoPicker(
          backgroundColor: Colors.white,
          itemExtent: 30,
          scrollController: FixedExtentScrollController(initialItem: 1),
          children: [for (String val in company) Text(val)],
          onSelectedItemChanged: (value) {
            setState(() {
              _selectedCompanyValue = company[value];
              print('_selectedCompanyValue : $_selectedCompanyValue');
            });
          },
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Center(
          child: Container(
            width: 320,
            height: 340,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFF1F1F1),
                  offset: Offset(2.0, 13.0),
                  blurRadius: 35.0,
                ),
              ],
            ),
            child: Column(
              children: [
                viewSelectedDates(context),
                viewSelectedCompany(context),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: viewSelectedPrice(context),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  width: 500,
                  child: Text(
                    '샀었더라면...?',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget viewSelectedDates(BuildContext context) {
    return Row(
      children: [
        CupertinoButton(
          child: Text(
            _selectedDateValue,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () => _showDatePicker(context),
        ),
        Text(
          '에',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w100,
          ),
        ),
      ],
    );
  }

  Widget viewSelectedCompany(BuildContext context) {
    return Row(
      children: [
        CupertinoButton(
          child: Text(
            _selectedCompanyValue,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () => _showComponyPicker(context),
        ),
        Text(
          '를',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w100,
          ),
        ),
      ],
    );
  }

  Widget viewSelectedPrice(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: TextField(
            textAlign: TextAlign.left,
            maxLength: 10,
            keyboardType: TextInputType.number,
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp('[0-9]')),
            ],
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
            cursorColor: Colors.grey,
            controller: _controller,
            decoration: InputDecoration(
              hintText: '100000',
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
              counterText: '',
            ),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: Text(
            '원',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
      ],
    );
  }
}

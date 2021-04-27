import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/calculator/calculator_dto.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/screens/main/calculator_result_screen.dart';
import 'package:should_have_bought_app/utils.dart';

import 'company_item.dart';

class CalculatorWidget extends StatefulWidget {
  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  TextEditingController _searchController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  String _selectedDateValue = 'YEAR10';
  Company _selectedCompany = Company(company: '삼성전자', code: '005930');
  int value = 0;
  List<String> dates = [
    'DAY1',
    'WEEK1',
    'MONTH1',
    'MONTH6',
    'YEAR1',
    'YEAR5',
    'YEAR10'
  ];
  List<String> prices = ['100000', '500000', '1000000', '5000000', '10000000'];
  List<String> company = [
    '삼성전자',
    '삼성SDI',
    '삼성전기',
    '삼성물산',
    '카카오',
    'LG 전자',
    'LG 디스플레이'
  ];
  Future futureGetCompanyList;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    futureGetCompanyList =
        Provider.of<CalculatorProvider>(context, listen: false).getCompanies();
    _priceController.text = numberWithComma('100000');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void SetCompanyValue(Company company) {
    setState(() {
      _selectedCompany = company;
    });
  }

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
          children: [for (String date in dates) Text(dateValue[date])],
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

  // void _showComponyPicker(BuildContext context) {
  //   final _screenSize = MediaQuery.of(context).size;
  //   showCupertinoModalPopup(
  //     context: context,
  //     builder: (_) => Container(
  //       width: _screenSize.width,
  //       height: _screenSize.height * 0.3,
  //       child: CupertinoPicker(
  //         backgroundColor: Colors.white,
  //         itemExtent: 30,
  //         scrollController: FixedExtentScrollController(initialItem: 1),
  //         children: [for (String val in company) Text(val)],
  //         onSelectedItemChanged: (value) {
  //           setState(() {
  //             _selectedCompanyValue = company[value];
  //             print('_selectedCompanyValue : $_selectedCompanyValue');
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
        child: Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 25, top: 12, bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [viewSelectedDates(context), randomValues(context)],
              ),
              viewSelectedCompany(context),
              viewSelectedPrice(context),
              // ToDo: 한글 금액
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    child: Text(
                      '샀었더라면..?',
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
              SizedBox(
                height: 50,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: CupertinoButton(
                  color: mainColor,
                  padding: EdgeInsets.all(0),
                  child: isLoading
                      ? FittedBox(
                          fit: BoxFit.cover,
                          child: Theme(
                              data: Theme.of(context)
                                  .copyWith(accentColor: defaultFontColor),
                              child: CircularProgressIndicator()),
                        )
                      : Text(
                          '지금 얼마?',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: defaultFontColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await Provider.of<CalculatorProvider>(context,
                            listen: false)
                        .getResult(CalculatorDto(
                                code: _selectedCompany.code,
                                investDate: _selectedDateValue,
                                investPrice:
                                    intToCurrency(_priceController.text))
                            .toMap())
                        .then((value) {
                      print(Provider.of<CalculatorProvider>(context,
                              listen: false)
                          .calculationResult);
                      Navigator.of(context)
                          .pushNamed(CalculatorResultScreen.routeId);
                    });
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget viewSelectedDates(BuildContext context) {
    return Row(
      children: [
        SelectedButton(context, dateValue[_selectedDateValue], _showDatePicker),
        Padding(
          padding: EdgeInsets.only(right: 10),
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
        SelectedButton(context, _selectedCompany.company, showCompaniesMenu),
        Padding(
          padding: EdgeInsets.only(right: 10),
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

  Widget SelectedButton(
      BuildContext context, String value, ValueChanged<BuildContext> showMenu) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey,
      ))),
      child: CupertinoButton(
        padding: EdgeInsets.all(0),
        child: Text(
          value,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () => showMenu(context),
      ),
    );
  }

  Widget viewSelectedPrice(BuildContext context) {
    return Row(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 300,
          ),
          child: IntrinsicWidth(
            child: TextField(
              textAlign: TextAlign.left,
              maxLength: 13,
              keyboardType: TextInputType.number,
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp('[0-9]')),
                CurrencyInputFormatter(maxDigits: 10)
              ],
              controller: _priceController,
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                isDense: true,
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
                counterText: '',
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 10),
        ),
        Text(
          '원',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w100,
          ),
        ),
      ],
    );
  }

  void showCompaniesMenu(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        )),
        builder: (ctx) {
          return AnimatedPadding(
              duration: Duration(milliseconds: 150),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: CompanyListBuilder(context));
        }).whenComplete(() {
      //SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  Widget CompanyListBuilder(BuildContext context) {
    return FutureBuilder(
        future: futureGetCompanyList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: 300,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 400,
                  maxHeight: 400,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      SizedBox(
                        height: 40,
                        child: Material(
                          elevation: 5.0,
                          shadowColor: Colors.black,
                          child: TextField(
                              onChanged: (value) {},
                              controller: _searchController,
                              decoration: InputDecoration(
                                  hintText: "Search",
                                  suffixIcon: Icon(Icons.search),
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.fromLTRB(
                                      10.0, 10.0, 20.0, 10.0),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 3.0)))),
                        ),
                      ),
                      SizedBox(height: 55),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 30),
                        child: CircularProgressIndicator(
                            backgroundColor: Colors.transparent),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return CompanyList(context);
          }
          return Container(
            width: 0,
            height: 0,
          );
        });
  }

  Widget CompanyList(BuildContext context) {
    return Consumer<CalculatorProvider>(
        child: emptyCompanyList(context),
        builder: (context, calculatorProvider, child) => ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 400,
                maxHeight: 400,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 25.0,
                  right: 25.0,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    SizedBox(
                      height: 40,
                      child: Material(
                        elevation: 5.0,
                        shadowColor: Colors.black,
                        child: TextField(
                            onChanged: (value) {
                              calculatorProvider.filterSearchResults(value);
                            },
                            controller: _searchController,
                            decoration: InputDecoration(
                                hintText: "Search",
                                suffixIcon: Icon(Icons.search),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding:
                                    EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 3.0)))),
                      ),
                    ),
                    SizedBox(height: 15),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount:
                              calculatorProvider.searchCompanyList.length,
                          itemBuilder: (context, index) {
                            return CompanyItem(
                              company:
                                  calculatorProvider.searchCompanyList[index],
                              onTap: SetCompanyValue,
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ));
  }

  Widget emptyCompanyList(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 400,
        maxHeight: 400,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
          children: [
            SizedBox(height: 15),
            SizedBox(
              height: 40,
              child: Material(
                elevation: 5.0,
                shadowColor: Colors.black,
                child: TextField(
                    onChanged: (value) {},
                    controller: _searchController,
                    decoration: InputDecoration(
                        hintText: "Search",
                        suffixIcon: Icon(Icons.search),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide:
                                BorderSide(color: Colors.white, width: 3.0)))),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget randomValues(BuildContext context) {
    return InkWell(
        child: Column(
          children: [
            Image(image: AssetImage('assets/icons/ico_random.png')),
            Padding(padding: EdgeInsets.only(bottom: 2)),
            Text(
              '랜덤',
              style: TextStyle(fontSize: 11, color: Color(0xFF828282)),
            )
          ],
        ),
        onTap: () {
          CalculatorRandomValues();
        });
  }

  Widget CalculatorRandomValues() {
    List companyList =
        Provider.of<CalculatorProvider>(context, listen: false).companyList;
    int RandomDate = Random().nextInt(dates.length);
    int RandomCompany = Random().nextInt(companyList.length);
    int RandomPrice = Random().nextInt(prices.length);
    setState(() {
      _selectedDateValue = dates[RandomDate];
      _selectedCompany = companyList[RandomCompany];
    });
    _priceController.text = numberWithComma(prices[RandomPrice]);
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  CurrencyInputFormatter({this.maxDigits});
  final int maxDigits;
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }
    if (maxDigits != null && newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }

    double value = double.parse(newValue.text);
    final formatter = NumberFormat("###,###,###,###");
    String newText = formatter.format(value);
    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

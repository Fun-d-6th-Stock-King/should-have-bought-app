import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';

import 'company_item.dart';

class CalculatorWidget extends StatefulWidget {
  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  final TextEditingController _controller = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  String _selectedDateValue = '10년 전';
  Company _selectedCompany = Company('삼성전자', '005930');
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
  Future futureGetCompanyList;

  @override
  void initState() {
    super.initState();
    futureGetCompanyList = Provider.of<CalculatorProvider>(context, listen: false)
        .getCompanies();
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
              const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              viewSelectedDates(context),
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
                  child: Text(
                    '지금 얼마?',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {},
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
        SelectedButton(context, _selectedDateValue, _showDatePicker),
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

  Widget SelectedButton(BuildContext context, String value, ValueChanged<BuildContext> showMenu) {
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
                isDense: true,
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
        ),
        Padding(
          padding: EdgeInsets.only(right: 10),
        ),
        Text(
          '원에',
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
        return CompanyListBuilder(context);
      }
    ).whenComplete(() {
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
                              onChanged: (value) {
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
                      SizedBox(height: 55),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 30),
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
                    onChanged: (value) {
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
          ],
        ),
      ),
    );
  }
}

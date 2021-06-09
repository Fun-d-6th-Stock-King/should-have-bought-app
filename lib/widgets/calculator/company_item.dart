
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';
import 'package:should_have_bought_app/utils.dart';

class CompanyItem extends StatelessWidget {
  CompanyItem({this.company, this.query, this.onTap});

  final Company company;
  final String query;
  final ValueChanged<Company> onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(company);
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration( //                    <-- BoxDecoration
          border: Border(bottom: BorderSide(color:Color(0xFFDADADA))),
        ),
        child: ListTile(
          leading: Text('KOSPI', style: TextStyle(color: Color(0xFFDADADA),fontSize: 21, fontWeight: FontWeight.w500, height: 1.5)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                  children: highlightOccurrences(company.company, query),
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500, height: 1.5, color: Colors.black),
                ),
              ),//Te
            ],
          ),
          contentPadding: EdgeInsets.only(bottom: 18.0,top:9.0),
        ),
      ),
    );
  }
}
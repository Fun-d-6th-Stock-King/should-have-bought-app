
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';

class CompanyItem extends StatelessWidget {
  CompanyItem({this.company, this.onTap});

  final Company company;
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
              Text(company.company, style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500, height: 1.5)),
            ],
          ),
          contentPadding: EdgeInsets.only(bottom: 18.0,top:9.0),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/calculator/company.dart';
import 'package:should_have_bought_app/utils.dart';

class SearchItem extends StatelessWidget {
  SearchItem({this.company, this.query, this.onTap});

  final Company company;
  final String query;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration( //                    <-- BoxDecoration
          border: Border(bottom: BorderSide(color:Color(0xFFDADADA))),
        ),
        child: ListTile(
          leading: RichText(
            text: TextSpan(
              children: highlightOccurrences(company.company, query),
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500, height: 1.5, color: Colors.black),
            ),
          ),//Text(company.company, style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500, height: 1.5)),
          title: Text(''),
          trailing: Text('KOSPI', style: TextStyle(color: Color(0xFFDADADA),fontSize: 21, fontWeight: FontWeight.w500, height: 1.5)),
          contentPadding: EdgeInsets.only(bottom: 18.0,top:9.0),
        ),
      ),
    );
  }
}


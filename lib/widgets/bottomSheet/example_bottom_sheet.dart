import 'package:flutter/material.dart';

void ExampleBottomSheet(BuildContext context, {String buyOrNotStockCode}) {
  showModalBottomSheet<void>(
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
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              height: 200,
              child: Text('hello')),
        );
      });

}

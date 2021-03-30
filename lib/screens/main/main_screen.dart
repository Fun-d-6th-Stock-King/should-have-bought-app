import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/providers/widzets.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: Provider.of<Widzets>(context).items.length,
      itemBuilder: (ctx, index) =>
          Provider.of<Widzets>(context, listen: false).items[index].child,
    ));
  }
}

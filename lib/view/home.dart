import 'package:flutter/material.dart';
import 'package:provider_helper/view/installersPage.dart';
import 'providersPage.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final controller = PageController();
  final backgroundColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return PageView(
     
        controller: controller,
        children: const <Widget>[PlansBuilder()]);
  }

  Widget title(String text) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}

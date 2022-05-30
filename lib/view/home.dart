import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider_helper/view/installersDetails.dart';
import 'package:provider_helper/view/installersPage.dart';
import 'plansPage.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final controller = PageController();
  final backgroundColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Stack(alignment: Alignment.center, children: [
      PageView(
          controller: controller,
          children: const <Widget>[PlansPage(), InstallersBuilder()]),
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseContentWidget extends StatelessWidget {
  BaseContentWidget({
    super.key,
    this.title,
    required this.child,
  });
  final dynamic title;
  final Widget child;

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,

      appBar:AppBar(
      scrolledUnderElevation: 0,
      leading: Opacity(
          opacity: 1.0,
          child: IconButton(
            icon: _backButton(),
            onPressed: () {Get.back();}
          ),
        ),
        automaticallyImplyLeading: true,
        title: title is String
            ? Text(
          title,
          style: TextStyle(
              fontSize: 21,
              height:1.0,),
          strutStyle: StrutStyle(
            fontSize: 21,
            height: 1.0,
            forceStrutHeight: true,
          ),)
            : title is Widget
            ? title
            : null,
        elevation: 0,
      ),
      body: SafeArea(
        child: child,
      ),
    );
  }
}

Widget _backButton() {
  return const Icon(Icons.arrow_back);
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseContentWidget extends StatelessWidget {
  BaseContentWidget({
    super.key,
    this.title,
    required this.child,
    this.bottomNavigationBar,
    this.useBackButton = true,
    this.action,
  });
  final dynamic title;
  final Widget child;
  final Widget? bottomNavigationBar;
  final bool useBackButton;
  final List<Widget>? action;

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFF6F6F6),
      appBar:AppBar(
        scrolledUnderElevation: 0,
        leading: useBackButton == true ? IconButton(
            icon: _backButton(),
            onPressed: () {Get.back();}
        ) : null,
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
        actions: action
      ),
      body: SafeArea(
        top: true,    // 상단 상태바 영역 보호
        bottom: true, // 하단 네비게이션바 영역 보호
        child: child,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

Widget _backButton() {
  return const Icon(Icons.arrow_back);
}
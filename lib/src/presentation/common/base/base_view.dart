import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///모든 뷰들이 상속받는 기본 클래스
abstract class BaseView extends HookConsumerWidget {
  const BaseView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      color: backgroundColor,
      child: buildView(context, ref),
    );
  }

  @protected
  Widget buildView(BuildContext context, WidgetRef ref);

  @protected
  Color get backgroundColor => Colors.white;
}

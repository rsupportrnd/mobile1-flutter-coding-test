import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/theme/app_color.dart';

///모든 스크린들이 상속받아 사용하는 클래스
abstract class BaseScreen extends HookConsumerWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        onInit(ref);
        return () => onDispose(ref);
      },
      [],
    );

    return Scaffold(
      appBar: renderAppBar(context, ref),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor,
      bottomNavigationBar: renderBottomNavigationBar(context, ref),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: Colors.transparent,
          child: SafeArea(
            top: setTopSafeArea,
            bottom: setBottomSafeArea,
            left: false,
            right: false,
            child: buildScreen(
              context,
              ref,
            ),
          ),
        ),
      ),
    );
  }

  @protected
  Widget buildScreen(BuildContext context, WidgetRef ref);

  @protected
  bool get setBottomSafeArea => true;

  @protected
  bool get setTopSafeArea => true;

  @protected
  bool get canPop => false;

  @protected
  Color? get backgroundColor => AppColors.background;

  @protected
  bool get resizeToAvoidBottomInset => true;

  @protected
  PreferredSizeWidget? renderAppBar(BuildContext context, WidgetRef ref) => null;

  @protected
  Widget? renderBottomNavigationBar(BuildContext context, WidgetRef ref) => null;

  @protected
  void onResumed(WidgetRef ref) {}

  @protected
  void onPopInvoked(WidgetRef ref, BuildContext context) {}

  @protected
  void onPaused(WidgetRef ref) {}

  @protected
  void onInactive(WidgetRef ref) {}

  @protected
  void onDetached(WidgetRef ref) {}

  @protected
  void onInit(WidgetRef ref) {}

  @protected
  void onDispose(WidgetRef ref) {}
}

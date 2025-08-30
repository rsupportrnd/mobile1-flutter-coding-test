import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile1_flutter_coding_test/view_models/base_view_model.dart';

abstract class BaseView<V extends BaseViewModel> extends GetView<V> {
  const BaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<V>(
        tag: tag,
        initState: _initState,
        dispose: _dispose,
        builder: (_) {
          assert(_.hashCode == controller.hashCode);
          return builder(context, controller);
        },
      );
  }

  // LazyVMProvider<V>? get lazyVmProvider => null;
  V? get vmProvider => null;

  void _initState(GetBuilderState<V> state) {

    // final vm = vmProvider ?? lazyVmProvider?.call();
    final vm = vmProvider;
    if (!Get.isRegistered<V>(tag: tag) && vm != null) {
      Get.put<V>(vm, tag: tag);
    }

    initState(controller);
  }


  void _dispose(GetBuilderState<V> state) {
    if (Get.isRegistered<V>()) {
      dispose(controller);
    }
  }

  void initState(V vm) {}
  void dispose(V vm) {}

  Widget builder(BuildContext context, V vm);
}
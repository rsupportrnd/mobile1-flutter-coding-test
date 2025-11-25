import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/data.dart';
import '../presentation.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final RazerPositionRepository razerPositionRepo =
        context.read<RazerPositionRepository>();

    return LayoutBuilder(builder: (context, constraints) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        razerPositionRepo.setMax(constraints.maxWidth, constraints.maxHeight);
        razerPositionRepo.init();
      });

      return Consumer<RazerPositionRepository>(
          builder: (context, boxProvider, child) {
        return CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: DotPainterWidget(Offset(boxProvider.x, boxProvider.y)),
        );
      });
    });
  }
}

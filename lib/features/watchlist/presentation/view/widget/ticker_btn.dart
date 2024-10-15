import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/configs/values.dart';

class TickerButton extends ConsumerWidget {
  const TickerButton({
    super.key,
    required this.symbol,
    required this.isOn,
  });

  final String symbol;
  final bool isOn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * CustomGapSize.w2,
        vertical: size.width * CustomGapSize.h2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isOn ? Theme.of(context).colorScheme.secondary : Colors.transparent,
        border: Border.all(
          color: isOn ? Colors.transparent : Theme.of(context).colorScheme.secondary,
        ),
      ),
      child: Center(
        child: Text(
          symbol,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/configs/routes.dart';
import '../../../../cryptocurrency/domain/cryptocurrency.dart';

class WatchlistIndexCard extends ConsumerWidget {
  const WatchlistIndexCard({super.key, required this.data});

  final Cryptocurrency data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        AppRoutes.goRouter.pushNamed(AppRoutes.detail, extra: data.tickerCode);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              data.tickerCode,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "${data.lastPrice}",
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "${data.dailyDiff}",
              textAlign: TextAlign.end,
              style: TextStyle(
                color: data.dailyDiff.isNegative ? Theme.of(context).colorScheme.error : Colors.green,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "${data.dailyChange}",
              textAlign: TextAlign.end,
              style: TextStyle(
                color: data.dailyChange.isNegative ? Theme.of(context).colorScheme.error : Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WatchlistIndexLCard extends ConsumerWidget {
  const WatchlistIndexLCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.surface,
            highlightColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
              ),
              child: Text(
                "XXX-XXX",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.surface,
            highlightColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
              ),
              child: Text(
                "XXXXX.XXXX",
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.surface,
            highlightColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
              ),
              child: Text(
                "XXXXX.XXXX",
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.surface,
            highlightColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
              ),
              child: Text(
                "XXXXXX",
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

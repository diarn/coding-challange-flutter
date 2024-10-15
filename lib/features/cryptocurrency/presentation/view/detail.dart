import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/configs/values.dart';
import '../controller/detail.dart';

class DetailPage extends ConsumerWidget {
  const DetailPage({super.key, required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final cryptocurrencyDC = ref.watch(cryptocurrencyDCPro(CryptocurrencyDCArg(symbol: symbol)));
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * CustomGapSize.w1),
              child: Text(
                symbol,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: size.height * CustomFontSize.h1,
                ),
              ),
            ),
            // Gap(size.height * CustomGapSize.h1),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * CustomGapSize.w1,
                ),
                child: cryptocurrencyDC.when(
                  data: (datum) {
                    return datum.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(text: "\$${datum.last.lastPrice} ", children: [
                                  TextSpan(
                                    text: "(${datum.last.dailyChange}%)",
                                    style: TextStyle(
                                      color: datum.last.dailyChange.isNegative ? Colors.red : Colors.green,
                                    ),
                                  ),
                                ]),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: size.height * CustomFontSize.h2,
                                ),
                              ),
                              Gap(size.height * CustomGapSize.h1),
                              Expanded(
                                child: Material(
                                  textStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                  child: LineChart(
                                    LineChartData(
                                      maxX: datum.length.toDouble(),
                                      titlesData: const FlTitlesData(
                                        topTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: false,
                                          ),
                                        ),
                                        rightTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: false,
                                          ),
                                        ),
                                        leftTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            reservedSize: 50,
                                            showTitles: true,
                                          ),
                                        ),
                                      ),
                                      lineBarsData: [
                                        LineChartBarData(
                                          // ignore: sdk_version_since
                                          spots: datum.indexed
                                              .map(
                                                (e) => FlSpot((e.$1).toDouble(), e.$2.lastPrice),
                                              )
                                              .toList(),
                                          dotData: const FlDotData(show: false),
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                      ],
                                      gridData: const FlGridData(show: false),
                                      borderData: FlBorderData(
                                        border: Border(
                                          left: BorderSide(
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                          bottom: BorderSide(
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox();
                  },
                  error: (error, stackTrace) => Center(
                    child: Text(error.toString()),
                  ),
                  loading: () => Center(
                    child: LoadingAnimationWidget.discreteCircle(
                      color: Theme.of(context).colorScheme.secondary,
                      size: size.width * 0.25,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

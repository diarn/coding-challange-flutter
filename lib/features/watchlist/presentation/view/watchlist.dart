import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:interview_app/core/datum/dummy.dart';
import 'package:interview_app/features/watchlist/presentation/view/widget/ticker_btn.dart';

import '../../../../core/configs/values.dart';
import '../controller/watchlist.dart';
import 'widget/index_card.dart';

class WatchlistPage extends ConsumerWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final watchlist = ref.watch(watchlistPro);

    final watchlistC = ref.watch(watchlistCPro(WatchlistCArg(symbols: watchlist)));
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * CustomGapSize.w1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Watchlist",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * CustomFontSize.h1,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      ref.invalidate(watchlistCPro);
                    },
                    child: const Icon(
                      Icons.refresh_rounded,
                    ),
                  ),
                ],
              ),
            ),
            Gap(size.height * CustomGapSize.h1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: TextFormField(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                  contentPadding: EdgeInsets.fromLTRB(
                    0,
                    size.height * 0.015,
                    size.width * 0.02,
                    size.height * 0.015,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            Gap(size.height * CustomGapSize.h2),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * CustomGapSize.w1),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final ticker = tickerSymbols[index];
                    final temp = [...watchlist];
                    return InkWell(
                      onTap: () {
                        inspect(temp);
                        if (temp.contains(ticker.name)) {
                          temp.removeWhere(
                            (element) => element == ticker.name,
                          );
                          inspect(temp);
                        } else {
                          temp.add(ticker.name);
                          inspect(temp);
                        }
                        ref.read(watchlistPro.notifier).state = temp;
                      },
                      child: TickerButton(
                        symbol: ticker.name,
                        isOn: watchlist.contains(ticker.name),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Gap(size.width * CustomGapSize.w1),
                  itemCount: tickerSymbols.length,
                ),
              ),
            ),
            Gap(size.height * CustomGapSize.h2),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * CustomGapSize.w1),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Symbol",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Last",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Chg",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Chg %",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * CustomGapSize.w1),
              child: Divider(
                height: size.height * CustomGapSize.h1,
              ),
            ),
            Expanded(
              flex: 20,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * CustomGapSize.w1),
                child: watchlistC.when(
                  data: (datum) {
                    return datum.isNotEmpty
                        ? ListView.separated(
                            itemBuilder: (context, index) {
                              final data = datum[index];
                              return WatchlistIndexCard(data: data);
                            },
                            separatorBuilder: (context, index) => Gap(size.height * CustomGapSize.h2),
                            itemCount: datum.length,
                          )
                        : Text(
                            "No Data Available",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          );
                  },
                  error: (error, stackTrace) {
                    return Column(
                      children: [
                        Text(
                          error.toString(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          stackTrace.toString(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    );
                  },
                  loading: () {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return const WatchlistIndexLCard();
                      },
                      separatorBuilder: (context, index) => Gap(size.height * CustomGapSize.h2),
                      itemCount: 33,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

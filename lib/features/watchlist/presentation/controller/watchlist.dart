import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/helpers/ws.dart';
import '../../../cryptocurrency/domain/cryptocurrency.dart';
import '../../data/watchlist.dart';

class WatchlistCArg extends Equatable {
  const WatchlistCArg({
    required this.symbols,
  });
  final List<String> symbols;
  @override
  List<Object?> get props => [symbols];
}

final watchlistCPro = AutoDisposeStreamProviderFamily<List<Cryptocurrency>, WatchlistCArg>(
  (ref, arg) async* {
    final rep = ref.watch(watchlistRepPro);
    final stream = rep.details(symbols: arg.symbols);
    await for (final el in stream) {
      yield el;
    }
    ref.onDispose(
      () {
        final channel = ref.read(wsHelperProvider).setConnection();
        String watchlist = "";
        for (var el in arg.symbols) {
          if (watchlist.isNotEmpty) {
            watchlist += ",$el";
          } else {
            watchlist += el;
          }
        }
        channel.sink.add('{"action": "unsubscribe", "symbols": "$watchlist"}');
        channel.sink.close();
      },
    );
  },
);

final watchlistPro = StateProvider.autoDispose<List<String>>(
  (ref) => ["BTC-USD", "ETH-USD"],
);

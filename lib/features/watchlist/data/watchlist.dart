import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/helpers/ws.dart';
import '../../cryptocurrency/domain/cryptocurrency.dart';

class WatchlistRepository {
  WatchlistRepository({required this.wsHelper});

  final WSHelper wsHelper;

  Stream<List<Cryptocurrency>> details({required List<String> symbols}) async* {
    final channel = wsHelper.setConnection();
    List<Cryptocurrency> cryptos = [];

    String watchlist = "";
    for (var el in symbols) {
      if (watchlist.isNotEmpty) {
        watchlist += ",$el";
      } else {
        watchlist += el;
      }
    }

    channel.sink.add('{"action": "subscribe", "symbols": "$watchlist"}');
    log("sink added");

    await for (final data in channel.stream) {
      final json = jsonDecode(data);

      if (json.containsKey("s")) {
        final cryptocurrency = Cryptocurrency.fromMap(json);
        if (cryptos.isEmpty) {
          cryptos.add(cryptocurrency);
        } else {
          if (cryptos
              .where(
                (element) => element.tickerCode == cryptocurrency.tickerCode,
              )
              .isEmpty) {
            cryptos.add(cryptocurrency);
            log("yielding watchlist");
            yield cryptos;
          } else {
            final i = cryptos.indexWhere((element) => element.tickerCode == cryptocurrency.tickerCode);
            cryptos[i] = cryptocurrency;
            log("yielding watchlist");
            yield cryptos;
          }
        }
      } else {
        yield [];
      }
    }
  }
}

final watchlistRepPro = Provider(
  (ref) {
    final wsHelper = ref.read(wsHelperProvider);
    return WatchlistRepository(wsHelper: wsHelper);
  },
);

import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/helpers/ws.dart';
import '../domain/cryptocurrency.dart';

class CryptocurrencyRepository {
  CryptocurrencyRepository({required this.wsHelper});

  final WSHelper wsHelper;

  Stream<List<Cryptocurrency>> details({required String symbol}) async* {
    final channel = wsHelper.setConnection();
    List<Cryptocurrency> cryptos = [];

    channel.sink.add('{"action": "subscribe", "symbols": "$symbol"}');
    log("sink added");

    await for (final data in channel.stream) {
      final json = jsonDecode(data);

      if (json.containsKey("s")) {
        final cryptocurrency = Cryptocurrency.fromMap(json);
        if (cryptos.isNotEmpty) {
          if (cryptos.last.dateTime.second != cryptocurrency.dateTime.second) {
            cryptos.add(cryptocurrency);
            log("YIELDING DETAIL");
            yield cryptos;
          }
        } else {
          cryptos.add(cryptocurrency);
          log("YIELDING DETAIL");
          yield cryptos;
        }
      } else {
        yield [];
      }
    }
  }
}

final cryptocurrencyRep = Provider(
  (ref) {
    final wsHelper = ref.read(wsHelperProvider);
    return CryptocurrencyRepository(wsHelper: wsHelper);
  },
);

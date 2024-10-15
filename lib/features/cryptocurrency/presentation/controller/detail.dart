import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/helpers/ws.dart';
import '../../data/cryptocurrency.dart';
import '../../domain/cryptocurrency.dart';

class CryptocurrencyDCArg extends Equatable {
  const CryptocurrencyDCArg({required this.symbol});
  final String symbol;
  @override
  List<Object?> get props => [symbol];
}

final cryptocurrencyDCPro = AutoDisposeStreamProviderFamily<List<Cryptocurrency>, CryptocurrencyDCArg>(
  (ref, arg) async* {
    final rep = ref.read(cryptocurrencyRep);
    final stream = rep.details(symbol: arg.symbol);
    await for (final el in stream) {
      yield el;
    }

    ref.onDispose(
      () {
        final channel = ref.read(wsHelperProvider).setConnection();
        channel.sink.add('{"action": "unsubscribe", "symbols": "${arg.symbol}"}');
        channel.sink.close();
      },
    );
  },
);

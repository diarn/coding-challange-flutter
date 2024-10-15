import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/io.dart';

import '../configs/ws.dart';

class WSHelper {
  Stream<T> getData<T>({
    required String url,
    required String action,
  }) async* {
    try {
      log(url);
      log(action);
      final channel = IOWebSocketChannel.connect(url);
      channel.sink.add(action);
      await for (final data in channel.stream) {
        yield data;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  IOWebSocketChannel setConnection() {
    return IOWebSocketChannel.connect(WSConfig.baseUrl);
  }
}

final wsHelperProvider = Provider(
  (ref) {
    return WSHelper();
  },
);

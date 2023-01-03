import 'package:flutter/foundation.dart';
import 'package:plan_meal_app/config/server_addresses.dart';
import 'package:socket_io_client/socket_io_client.dart';

class AppSocket {
  Socket socket = io(
      ServerAddresses.serverAddress,
      OptionBuilder()
          .setTransports(['websocket'])
          .setTimeout(5000)
          .setReconnectionDelay(3000)
          .disableAutoConnect()
          .build());

  initSocket() {
    socket.connect();
    socket.onConnecting((data) {
      if (kDebugMode) {
        print("Connecting socket");
      }
    });
    socket.onConnect((data) {
      if (kDebugMode) {
        print("Socket id: ${socket.id}");
        print("Connect socket");
      }
    });

    socket.onConnectError((data) {
      if (kDebugMode) {
        print("Connect error: $data");
      }
    });

    socket.onError((data) {
      if (kDebugMode) {
        print("Connect error: $data");
      }
    });
  }

  on(String event, void Function(dynamic) callbackFunction) {
    socket.on(event, (data) {
      return callbackFunction(data);
    });
  }

  emit(String event, [dynamic data]) {
    socket.emit(event, data);
  }

  disconnectSocket() {
    socket.disconnect();
    socket.dispose();
  }
}
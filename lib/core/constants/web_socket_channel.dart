import 'package:web_socket_channel/web_socket_channel.dart';

final WebSocketChannel channel = WebSocketChannel.connect(
  Uri.parse(
    'ws://122.179.143.201:8089/websocket?sessionID=ansh&userID=ansh&apiToken=ansh',
  ),
);

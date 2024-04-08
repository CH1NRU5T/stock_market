import 'dart:convert';

String getUnsubscribeMessage(List<int> tokens) {
  return jsonEncode({
    "Task": "unsubscribe",
    "Mode": "ltp",
    "Tokens": tokens.map((e) => e).toList(),
  });
}

String getSubscribeMessage(List<int> tokens) {
  return jsonEncode({
    "Task": "subscribe",
    "Mode": "ltp",
    "Tokens": tokens.map((e) => e).toList(),
  });
}

import 'package:flutter/material.dart';
import 'package:stock_market/core/constants/web_socket_channel.dart';
import 'package:stock_market/core/helpers/web_socket_helper.dart';
import 'package:stock_market/models/stock.dart';

class StockProvider extends ChangeNotifier {
  final List<Stock> _stocks = [];
  List<Stock> get stocks => _stocks;

  void removeStock(Stock stock) {
    _stocks.remove(stock);
    channel.sink.add(getUnsubscribeMessage([stock.key]));
    notifyListeners();
  }

  void addStock(Stock stock) {
    _stocks.add(stock);
    channel.sink.add(getSubscribeMessage([stock.key]));
    notifyListeners();
  }

  void removeStocks(List<Stock> stocksToRemove) {
    _stocks.removeWhere((stock) => stocksToRemove.contains(stock));
    notifyListeners();
  }
}

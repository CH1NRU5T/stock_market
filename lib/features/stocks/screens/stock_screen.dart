import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stock_market/models/stock.dart';
import 'package:stock_market/providers/stock_provider.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  List<Stock>? _stocks;
  Future<void> getStocks() async {
    List<Stock> stocks = [];
    var input = await rootBundle.loadString('assets/stocks.json');
    var map = jsonDecode(input);
    map.forEach((key, value) {
      stocks.add(Stock.fromMap({...value, 'key': int.parse(key)}));
    });
    setState(() {
      _stocks = stocks;
    });
  }

  @override
  void initState() {
    super.initState();
    getStocks();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _stocks == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<StockProvider>(
                builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: _stocks!.length,
                      itemBuilder: (context, index) {
                        final stock = _stocks![index];
                        final contains = value.stocks.contains(stock);
                        return ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          title: Text(stock.company),
                          subtitle: Text(stock.symbol),
                          trailing: IconButton(
                            onPressed: () {
                              contains
                                  ? value.removeStock(stock)
                                  : value.addStock(stock);
                            },
                            icon: Container(
                              decoration: BoxDecoration(
                                color: contains
                                    ? Colors.green
                                    : Colors.transparent,
                                border: Border.all(
                                  color: contains
                                      ? Colors.green
                                      : Colors.blueAccent,
                                ),
                              ),
                              child: Icon(
                                contains ? Icons.remove : Icons.add,
                                color:
                                    contains ? Colors.white : Colors.blueAccent,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}

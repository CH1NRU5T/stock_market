import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_market/core/constants/web_socket_channel.dart';
import 'package:stock_market/features/stocks/screens/stock_screen.dart';
import 'package:stock_market/providers/stock_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<StockProvider>(
          builder: (context, value, child) {
            return StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                print(snapshot.connectionState);
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error occurred'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Text(
                        'No stocks added yet. Add some stocks to see the live prices.'),
                  );
                }
                final data = jsonDecode(snapshot.data);

                return value.stocks.isEmpty
                    ? const Center(
                        child: Text(
                            'No stocks added yet. Add some stocks to see the live prices.'),
                      )
                    : ListView.builder(
                        itemCount: value.stocks.length,
                        itemBuilder: (context, index) {
                          final stock = value.stocks[index];
                          return Dismissible(
                            key: ValueKey(stock.key.toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ),
                            onDismissed: (direction) {
                              context.read<StockProvider>().removeStock(stock);
                            },
                            child: ListTile(
                              title: Text(stock.company),
                              subtitle: Text(stock.symbol),
                              trailing:
                                  Text(data[stock.key.toString()].toString()),
                            ),
                          );
                        },
                      );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const StockScreen();
                },
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_market/features/home/screens/home_screen.dart';
import 'package:stock_market/providers/stock_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => StockProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Market',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

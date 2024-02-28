import 'package:flutter/material.dart';

import 'additional/exchange/ui/exchange_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ExchangePage(),
    );
  }
}

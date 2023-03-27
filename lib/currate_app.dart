import 'package:flutter/material.dart';
import 'list_currencies.dart';

class CurrateApp extends StatelessWidget {
  const CurrateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ListCurrencies());
  }
}

import 'package:flutter/material.dart';

void main() => runApp(const HistoryView());

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HomepageState();
}

class _HomepageState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return Center(child: const Text("History View"));
  }
}

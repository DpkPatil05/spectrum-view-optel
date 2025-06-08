import 'package:flutter/material.dart';

class MarkAsBoughtScreenWidget extends StatefulWidget {
  const MarkAsBoughtScreenWidget({super.key});

  @override
  State<MarkAsBoughtScreenWidget> createState() =>
      _MarkAsBoughtScreenWidgetState();
}

class _MarkAsBoughtScreenWidgetState extends State<MarkAsBoughtScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mark as Bought')),
      body: Center(child: Text('Mark as Bought')),
    );
  }
}

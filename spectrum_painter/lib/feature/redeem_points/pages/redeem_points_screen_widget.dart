import 'package:flutter/material.dart';

class RedeemPointsScreenWidget extends StatefulWidget {
  const RedeemPointsScreenWidget({super.key});

  @override
  State<RedeemPointsScreenWidget> createState() =>
      _RedeemPointsScreenWidgetState();
}

class _RedeemPointsScreenWidgetState extends State<RedeemPointsScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Redeem Points')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Redeem")],
        ),
      ),
    );
  }
}

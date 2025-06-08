import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/verify_product_bloc.dart';

class VerifyProductScreenWidget extends StatefulWidget {
  const VerifyProductScreenWidget({super.key});

  @override
  State<VerifyProductScreenWidget> createState() =>
      _VerifyProductScreenWidgetState();
}

class _VerifyProductScreenWidgetState extends State<VerifyProductScreenWidget> {
  late final VerifyProductBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<VerifyProductBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Verify Product'));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../common/common_constants.dart';
import '../bloc/verify_product_bloc.dart';
import '../model/verify_product_screen_state.dart';

class VerifyProductScreenWidget extends StatefulWidget {
  const VerifyProductScreenWidget({super.key});

  @override
  State<VerifyProductScreenWidget> createState() =>
      _VerifyProductScreenWidgetState();
}

class _VerifyProductScreenWidgetState extends State<VerifyProductScreenWidget> {
  late final VerifyProductBloc bloc;
  final MobileScannerController controller = MobileScannerController(
    torchEnabled: true,
    autoZoom: true,
  );
  Barcode? _barcode;

  Widget _barcodePreview(Barcode? value) {
    if (value == null) {
      return const Text(
        'Scan something!',
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white),
      );
    }

    return Text(
      value.displayValue ?? 'No display value.',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white),
    );
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      _barcode = barcodes.barcodes.firstOrNull;
      bloc.verifyProduct(_barcode!.displayValue!);
    }
  }

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<VerifyProductBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paint serial number qr scanner')),
      backgroundColor: Colors.black,
      body: StreamBuilder<VerifyProductScreenState>(
        stream: bloc.stateStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final data = snapshot.requireData;
            // Show snackbar
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (data.success == true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Product verified successfully!',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: ColorConstants.success,
                  ),
                );
              } else if (data.errorText.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      data.errorText,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: ColorConstants.error,
                  ),
                );
              }
            });
            return Stack(
              children: [
                MobileScanner(onDetect: _handleBarcode),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: 100,
                    color: const Color.fromRGBO(0, 0, 0, 0.4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Center(child: _barcodePreview(_barcode)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

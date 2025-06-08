import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spectrum_painter/feature/mark_as_bought/bloc/mark_as_bought_bloc.dart';

import '../../../common/common_constants.dart';
import '../../../common/ui/buttons/primary_button.dart';
import '../../../common/ui/text_fields/primary_text_field.dart';
import '../model/mark_as_bought_state.dart';

class MarkAsBoughtScreenWidget extends StatefulWidget {
  const MarkAsBoughtScreenWidget({super.key});

  @override
  State<MarkAsBoughtScreenWidget> createState() =>
      _MarkAsBoughtScreenWidgetState();
}

class _MarkAsBoughtScreenWidgetState extends State<MarkAsBoughtScreenWidget> {
  late final MarkAsBoughtBloc bloc;
  final TextEditingController _srnController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<MarkAsBoughtBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mark as Bought')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: StreamBuilder<MarkAsBoughtScreenState>(
          stream: bloc.stateStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final data = snapshot.requireData;
              // Show snackbar
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final message = _getSnackBarMessage(data);

                if (message != null) {
                  final (text, color) = message;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        text,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: color,
                    ),
                  );
                }
              });

              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Enter serial number to mark as bought:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: SpaceConstants.space20),
                    PrimaryTextField(
                      controller: _srnController,
                      errorText: data.errorText,
                      label: 'Enter serial number',
                      hintText: 'e.g. SRN1234',
                      suffixIcon: Icon(Icons.numbers),
                      onChanged: (value) {
                        bloc.resetState();
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: SpaceConstants.minimumButtonHeight,
                      child: PrimaryButton(
                        color: data.isVerified == true
                            ? ColorConstants.success
                            : null,
                        onPressed: () async {
                          await _verifyAndMarkAsBought(data);
                        },
                        text: data.isVerified == true
                            ? 'Mark as Bought'
                            : 'Verify',
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  (String, Color)? _getSnackBarMessage(MarkAsBoughtScreenState data) {
    if (data.isVerified == true &&
        (data.isBought == null || data.isBought == false)) {
      return ('Serial number verified successfully!', ColorConstants.success);
    } else if (data.isVerified == true && data.isBought == true) {
      return ('Marked as bought successfully!', ColorConstants.success);
    } else if (data.errorText.isNotEmpty) {
      return (data.errorText, ColorConstants.error);
    }
    return null;
  }

  Future<void> _verifyAndMarkAsBought(MarkAsBoughtScreenState data) async {
    if (data.isVerified == true) {
      await bloc.markAsBought(_srnController.text.trim());
    } else {
      await bloc.verifyProduct(_srnController.text.trim());
    }
  }
}

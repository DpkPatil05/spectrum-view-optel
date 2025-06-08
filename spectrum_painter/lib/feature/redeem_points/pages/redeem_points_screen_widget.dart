import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common_constants.dart';
import '../../../common/ui/buttons/primary_button.dart';
import '../../../common/ui/text_fields/primary_text_field.dart';
import '../bloc/redeem_points_bloc.dart';
import '../model/redeem_points_state.dart';

class RedeemPointsScreenWidget extends StatefulWidget {
  const RedeemPointsScreenWidget({super.key});

  @override
  State<RedeemPointsScreenWidget> createState() =>
      _RedeemPointsScreenWidgetState();
}

class _RedeemPointsScreenWidgetState extends State<RedeemPointsScreenWidget> {
  late final RedeemPointsBloc bloc;
  final TextEditingController _pointsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<RedeemPointsBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Redeem Points')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: StreamBuilder<RedeemPointsScreenState>(
          stream: bloc.stateStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final data = snapshot.requireData;
              // Show snackbar on success
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (data.success == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Points redeemed successfully!',
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
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Enter points to redeem:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    PrimaryTextField(
                      controller: _pointsController,
                      errorText: data.errorText,
                      keyboardType: TextInputType.number,
                      label: 'Enter points',
                      hintText: 'e.g. 100',
                      suffixIcon: Icon(Icons.stars_outlined),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: SpaceConstants.minimumButtonHeight,
                      child: PrimaryButton(
                        onPressed: () async {
                          await _redeemPoints(data.isLoading);
                        },
                        text: 'Redeem Now',
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

  Future<void> _redeemPoints(bool isLoading) async {
    FocusManager.instance.primaryFocus?.unfocus();
    isLoading ? null : await bloc.redeemPoints(_pointsController.text.trim());
    _pointsController.clear();
  }
}

import 'package:flutter/material.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:rxdart/rxdart.dart';

import '../../common_constants.dart';

class PrimaryLoadingButton extends StatelessWidget {
  const PrimaryLoadingButton({
    super.key,
    this.icon,
    this.successText = StringConstants.success,
    this.failureText = StringConstants.failed,
    this.successIcon = Icons.check_circle,
    this.failureIcon = Icons.cancel,
    this.onPressed,
    required this.text,
    required BehaviorSubject<ButtonState> buttonStateController,
  }) : _buttonStateController = buttonStateController;

  final String successText;
  final String failureText;
  final IconData successIcon;
  final IconData failureIcon;
  final IconData? icon;
  final Function()? onPressed;
  final String text;

  final BehaviorSubject<ButtonState> _buttonStateController;

  Stream<ButtonState> get _stateStream => _buttonStateController.stream;

  bool _isButtonClickDisabled(ButtonState buttonState) =>
      buttonState != ButtonState.idle;

  void _resetButtonStateWhenNecessary(ButtonState buttonState) {
    if (buttonState == ButtonState.success || buttonState == ButtonState.fail) {
      Future.delayed(
        const Duration(seconds: SpaceConstants.defaultDelay),
      ).whenComplete(() {
        _buttonStateController.add(ButtonState.idle);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ButtonState>(
      initialData: ButtonState.idle,
      stream: _stateStream,
      builder: (context, snapshot) {
        final buttonStateData = snapshot.requireData;
        _resetButtonStateWhenNecessary(buttonStateData);
        return AbsorbPointer(
          absorbing: _isButtonClickDisabled(buttonStateData),
          child: ProgressButton.icon(
            state: buttonStateData,
            onPressed: onPressed,
            height: SpaceConstants.minimumButtonHeight,
            iconedButtons: {
              ButtonState.idle: IconedButton(
                text: text,
                icon: icon == null
                    ? null
                    : Icon(icon, color: ColorConstants.lightGray),
                color: ColorConstants.primary,
              ),
              ButtonState.loading: IconedButton(
                text: StringConstants.loading,
                color: ColorConstants.primary,
              ),
              ButtonState.fail: IconedButton(
                text: failureText,
                icon: Icon(failureIcon, color: ColorConstants.red),
                color: ColorConstants.error,
              ),
              ButtonState.success: IconedButton(
                text: successText,
                icon: Icon(successIcon, color: ColorConstants.success),
                color: ColorConstants.success,
              ),
            },
          ),
        );
      },
    );
  }
}

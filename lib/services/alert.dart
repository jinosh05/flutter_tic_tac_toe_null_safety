import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertService {
  AlertStyle? _resultAlertStyle;
  AlertStyle? get resultAlertStyle => _resultAlertStyle;

  AlertStyle? _settingsAlertStyle;
  AlertStyle? get settingsAlertStyle => _settingsAlertStyle;

  AlertService() {
    _resultAlertStyle = AlertStyle(
      animationType: AnimationType.grow,
      isCloseButton: false,
      isOverlayTapDismiss: true,
      titleStyle: const TextStyle(
          color: Color(0xff111111), fontWeight: FontWeight.w700, fontSize: 25),
      descStyle: const TextStyle(fontWeight: FontWeight.bold),
      animationDuration: const Duration(milliseconds: 300),
      buttonAreaPadding: const EdgeInsets.all(12),
      overlayColor: Colors.black.withOpacity(.7),
      constraints: const BoxConstraints(maxHeight: 200, maxWidth: 250),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
    _settingsAlertStyle = AlertStyle(
      animationType: AnimationType.fromBottom,
      isCloseButton: false,
      isOverlayTapDismiss: true,
      titleStyle: const TextStyle(
        color: Color(0xff111111),
        fontWeight: FontWeight.w700,
        fontSize: 25,
      ),
      // animationDuration: Duration(milliseconds: 300),
      buttonAreaPadding: const EdgeInsets.all(12),
      // overlayColor: Colors.black.withOpacity(.5),
      // constraints: BoxConstraints(maxHeight: 200, maxWidth: 250),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

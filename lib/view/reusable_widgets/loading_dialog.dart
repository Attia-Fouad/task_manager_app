import 'dart:io';

import 'package:flutter/material.dart';
import 'default_loading_widget.dart';

class LoadingDialog {
  static bool _isShowing = false;

  static void show(BuildContext loadingContext) {
    if (!_isShowing) {
      _isShowing = true;
      showDialog(
        barrierDismissible: false,
        context: loadingContext,
        builder: (context) {
          return Center(
            child: Platform.isIOS
                ? const CircularProgressIndicator.adaptive()
                : const Center(
                    child: DefaultLoadingWidget(),
                  ),
          );
        },
      );
    }
  }

  static void hide(BuildContext loadingContext) {
    if (_isShowing) {
      Navigator.of(loadingContext, rootNavigator: true)
          .pop(); // Ensure dialog is removed even if in nested routes
      _isShowing = false;
    }
  }

  static bool get isShowing => _isShowing;
}

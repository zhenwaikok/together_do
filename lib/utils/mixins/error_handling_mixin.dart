import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mpma_assignment/utils/util.dart';
import 'package:mpma_assignment/viewmodel/base_view_model.dart';

/// A mixin for handling errors in asynchronous operations gracefully,
/// providing utilities to try operations and catch errors with optional
/// error dialog presentations.
mixin ErrorHandlingMixin {
  /// Tries to execute a given asynchronous [fn] function, showing an error
  /// dialog if an error occurs and [shouldShowAlert] is true.
  /// Returns the result of [fn] if successful, or [null] if an error occurs.
  ///
  /// [BuildContext] context is required for showing dialogs.
  /// [Future<T?> Function()] fn is the asynchronous operation to try.
  /// [bool] shouldShowAlert determines whether to show an error dialog.
  ///
  Future<T?> tryCatch<T>(
    BuildContext context,
    Future<T?> Function() fn, {
    bool shouldShowAlert = true,
  }) async {
    try {
      return await fn();
    } on UrgentErrorException catch (e, stackTrace) {
      if (context.mounted) {
        unawaited(_handleUrgentError(context, e.message, stackTrace));
      }
      return null;
    } on NormalErrorException catch (e, stackTrace) {
      if (context.mounted) {
        unawaited(
          _handleError(context, shouldShowAlert, e.message, stackTrace),
        );
      }
      return null;
    }
  }

  /// Similar to [tryCatch], but shows a loading indicator while [fn] is executing.
  /// Automatically dismisses the loading indicator once [fn] completes or an error occurs.
  ///
  /// Use this for operations where visual feedback during loading is desired.
  Future<T?> tryLoad<T>(
    BuildContext context,
    Future<T?> Function() fn, {
    bool shouldShowAlert = true,
  }) async {
    unawaited(EasyLoading.show());

    try {
      return await fn();
    } on UrgentErrorException catch (e, stackTrace) {
      await EasyLoading.dismiss();
      if (context.mounted) {
        unawaited(_handleUrgentError(context, e.message, stackTrace));
      }
      return null;
    } on NormalErrorException catch (e, stackTrace) {
      await EasyLoading.dismiss();
      if (context.mounted) {
        unawaited(
          _handleError(context, shouldShowAlert, e.message, stackTrace),
        );
      }
      return null;
    } finally {
      await EasyLoading.dismiss();
    }
  }

  Future<void> _handleError(
    BuildContext context,
    bool shouldShowAlert,
    String message,
    StackTrace stackTrace,
  ) async {
    if (shouldShowAlert && context.mounted) {
      await WidgetUtil.showDefaultErrorDialog(context, message.toString());
    }

    // UNCOMMENT TO DEBUG ERROR
    debugPrint('Error: $message');
  }

  Future<void> _handleUrgentError(
    BuildContext context,
    String message,
    StackTrace stackTrace,
  ) async {
    if (context.mounted) {
      await WidgetUtil.showDefaultErrorDialog(context, message.toString());
      if (context.mounted) {
        // await tryLoad(context, () => context.read<UserViewModel>().logout());
        if (context.mounted) {
          // context.router.replaceAll([LoginRoute()]);
        }
      }
    }
    // UNCOMMENT TO DEBUG ERROR
    debugPrint('Error: $message');
  }
}

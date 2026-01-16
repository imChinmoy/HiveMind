import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastHelper {
  static void showSuccess(BuildContext context, String message) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 3),
      title: const Text('Success'),
      description: Text(message),
      alignment: Alignment.bottomCenter,
      icon: const Icon(Icons.check_circle_outline),
      primaryColor: Colors.green,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: BorderRadius.circular(12),
      showProgressBar: true,
    );
  }

  static void showError(BuildContext context, String message) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 3),
      title: const Text('Error'),
      description: Text(message),
      alignment: Alignment.bottomCenter,
      icon: const Icon(Icons.error_outline),
      primaryColor: Colors.red,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: BorderRadius.circular(12),
      showProgressBar: true,
    );
  }

  static void showInfo(BuildContext context, String message) {
    toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 3),
      title: const Text('Info'),
      description: Text(message),
      alignment: Alignment.bottomCenter,
      icon: const Icon(Icons.info_outline),
      primaryColor: Colors.blue,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: BorderRadius.circular(12),
      showProgressBar: true,
    );
  }
}

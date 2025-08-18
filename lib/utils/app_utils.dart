import 'package:cityguide_app/core/common/appcolors.dart';
import 'package:flutter/material.dart';

class AppUtils {
  //   static ShowNotification(String message, context, {bool isError = false}) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(message),
  //         backgroundColor: isError ? Colors.red : Appcolors.primaryColor,
  //       ),
  //     );
  //   }

  static ShowLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // backdrop click se close na ho
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Appcolors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Appcolors.primaryColor,
                  ),
                  strokeWidth: 3,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Processing...",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

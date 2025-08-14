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
      builder: (context) {
        return Dialog(
          backgroundColor: Appcolors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 40,
            children: [CircularProgressIndicator(), Text("Processing...")],
          ),
        );
      },
    );
  }
}

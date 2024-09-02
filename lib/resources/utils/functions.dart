import 'package:assessment/resources/utils/constants.dart';
import 'package:assessment/ui/views/app_text.dart';
import 'package:flutter/material.dart';

///
/// Show scaffold with message
void showMessage(BuildContext context, String message, {bool error = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: AppText(
        message,
        size: 14,
        color: kWhite,
        weight: FontWeight.w500,
      ),
      backgroundColor: error ? redErrorBg : null,
    ),
  );
}

///
/// Executes a block of code after some duration.
void waitAndExec(int duration, VoidCallback callback) async {
  Future.delayed(Duration(milliseconds: duration), callback);
}

Future<void> showBottomSheet({
  required BuildContext context,
  required Widget content,
}) async {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    elevation: 20,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(30),
          ),
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          child: Wrap(children: [content]),
        ),
      );
    },
  );
}

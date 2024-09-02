import 'package:assessment/ui/views/inline_loader.dart';
import 'package:flutter/material.dart';

class Loader {
  static bool visible = false;

  static void show(BuildContext context) {
    visible = true;
    final cs = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      builder: (BuildContext context) => Center(
        child: Container(
          width: 60.0,
          height: 60.0,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: InlineLoader(strokeColor: cs.onBackground),
        ),
      ),
    );
  }

  static void dismiss(BuildContext context) {
    if (!visible) return;
    visible = false;
    Navigator.pop(context, true);
  }
}

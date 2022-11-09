import 'package:flutter/material.dart';
import 'package:puzzle_app/localization/localization.dart';

Future<void> showAlertDialog(BuildContext context, String time, int steps) {
  return showDialog<void>(
    context: context,
    useRootNavigator: false,
    builder: (context) {
      final t = AppLocalizations.of(context);
      final body =
          '${t.yourResultsText} \n ${t.timeText} $time \n ${t.stepsText} ${steps.toString()}';
      return AlertDialog(
        title: Text(t.congratulationText),
        content: Text(body),
        actions: [
          ElevatedButton(
            child: const Text('OK'), //Text(t.okButtonTitle),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

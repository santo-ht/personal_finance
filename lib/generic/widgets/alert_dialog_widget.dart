import 'package:flutter/material.dart';

import '../../config/app_strings.dart';

class AlertDialogWidget extends StatefulWidget {
  final error, navigateBackPage;
  AlertDialogWidget(this.error, this.navigateBackPage);
  @override
  _AlertDialogWidgetState createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.error),
      content: Text(widget.error),
      actions: [
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              if (widget.navigateBackPage) {
                Navigator.of(context).pop(); //Navigate
              }
            },
            icon: const Icon(Icons.close),
            label: const Text(AppStrings.close))
      ],
    );
  }
}

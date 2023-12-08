import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, VoidCallback callback) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Delete item"),
        content: const Text("Are you sure want to delete?"),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed:  () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            onPressed: callback,
            child: const Text("Continue"),
          ),
        ],
      );
    },
  );
}
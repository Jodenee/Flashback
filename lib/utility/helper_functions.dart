import 'package:flutter/material.dart';

Future<void> showInformationModal(
  BuildContext context,
  String titleText,
  String contentText,
) async {
  if (!context.mounted) return;

  return await showDialog(
    // ignore: use_build_context_synchronously
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(titleText),
      content: Text(contentText),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, "Ok"),
          child: const Text("Ok"),
        ),
      ],
    ),
  );
}

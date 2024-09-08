import 'package:flutter/cupertino.dart';

import '../utils/kcolors.dart';
import 'app_style.dart';

void showErrorPopup(
  BuildContext context,
  String errorMessage,
  String? title,
  bool? removeCancel,
) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) {
      return CupertinoActionSheet(
        title: Text(
          title ?? 'Error',
          style: appStyle(
            18.0,
            Kolors.kRed,
            FontWeight.bold,
          ),
        ),
        message: Text(
          errorMessage,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
        cancelButton: removeCancel == null
            ? CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                isDefaultAction: true,
                child: const Text('Cancel'),
              )
            : const SizedBox.shrink(),
      );
    },
  );
}

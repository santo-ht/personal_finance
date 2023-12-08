import 'package:flutter/material.dart';

import 'custom_raised_button_widget.dart';

class FormSubmitButtonWidget extends CustomRaisedButton {
  FormSubmitButtonWidget({
    @required String? title,
    double borderRadius = 10.0,
    VoidCallback? onPressed,
  }) : super(
          child: Text(title!,
              style: const TextStyle(color: Colors.white, fontSize: 18.0)),
          color: Colors.red,
          borderRadius: borderRadius,
          onPressed: onPressed,
        );
}

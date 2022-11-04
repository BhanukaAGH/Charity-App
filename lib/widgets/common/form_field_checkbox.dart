import 'package:charity_app/utils/colors.dart';
import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    required Widget title,
    required FormFieldSetter<bool> onSaved,
    required FormFieldValidator<bool> validator,
    bool initialValue = false,
    bool autovalidate = false,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (FormFieldState<bool> state) {
            return CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              checkColor: Colors.white,
              activeColor: primaryColor,
              dense: true,
              title: title,
              value: state.value,
              onChanged: state.didChange,
              subtitle: state.hasError
                  ? Builder(
                      builder: (BuildContext context) => Text(
                        state.errorText!,
                        style: TextStyle(color: Theme.of(context).errorColor),
                      ),
                    )
                  : null,
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        );
}

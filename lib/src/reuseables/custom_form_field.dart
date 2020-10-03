import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:room_finder/src/values/constants.dart';

class CustomFormField extends StatelessWidget {
  final FocusNode focus;
  final TextEditingController controller;
  final TextInputAction inputAction;
  final Function validator;
  final TextInputType inputType;
  final Function submitted;
  final bool pass;
  final String title;
  final String hint;
  final String helper;
  final String prefixText;
  final Function onEdited;
  final int minLines;
  final bool enabled;
  final String value;
  final bool padded;
  final int maxLines;
  final bool autofocus;
  final bool digitsOnly;
  final int maxLength;
  CustomFormField(
      {this.focus,
      this.maxLength,
      this.controller,
      this.inputAction,
      this.minLines,
      this.onEdited,
      this.validator,
      this.inputType,
      this.submitted,
      this.pass = false,
      this.title,
      this.hint,
      this.autofocus = false,
      this.enabled,
      this.prefixText,
      this.helper,
      this.value,
      this.padded = true,
      this.digitsOnly = false,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: this.padded ? kDefaultPadding : 0.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          this.title != null
              ? Text(
                  this.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          TextFormField(
            autofocus: autofocus,
            onEditingComplete: this.onEdited,
            minLines: this.minLines ?? 1,
            maxLines: this.maxLines ?? 1,
            enabled: this.enabled,
            focusNode: this.focus,
            controller: this.controller,
            textInputAction: this.inputAction,
            validator: this.validator,
            keyboardType: this.inputType,
            onFieldSubmitted: this.submitted,
            obscureText: this.pass,
            initialValue: this.value,
            maxLength: maxLength != null ? maxLength : null,
            enableInteractiveSelection: true,
            inputFormatters: digitsOnly
                ? [
                    FilteringTextInputFormatter.digitsOnly,
                  ]
                : [],
            decoration: InputDecoration(
              contentPadding: (maxLines ?? 1) > 1 || (minLines ?? 1) > 1
                  ? EdgeInsets.all(kDefaultPadding)
                  : EdgeInsets.symmetric(horizontal: kDefaultPadding),
              helperText: this.helper,
              hintText: this.hint,
              fillColor: Colors.transparent,
              prefixText: this.prefixText,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).accentColor,
                ),
              ),
              border: OutlineInputBorder(),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

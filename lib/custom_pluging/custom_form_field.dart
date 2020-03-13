import 'package:flutter/material.dart';
import 'package:room_finder/functions/constants.dart';

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
  final bool enabled;
  final String value;
  final bool padded;
  final int maxLines;

  CustomFormField(
      {this.focus,
      this.controller,
      this.inputAction,
      this.validator,
      this.inputType,
      this.submitted,
      @required this.pass,
      this.title,
      this.hint,
      this.enabled,
      this.prefixText,
      this.helper,
      this.value,
      this.padded = true,
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
          this.title != null ? Text(
            this.title,
          ) : SizedBox(),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          TextFormField(
            minLines: 1,
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
            enableInteractiveSelection: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
            ),
          ),
        ],
      ),
    );
  }
}

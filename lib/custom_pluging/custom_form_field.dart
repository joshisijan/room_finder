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

  CustomFormField(
      {this.focus,
      this.controller,
      this.inputAction,
      this.validator,
      this.inputType,
      this.submitted,
      this.pass,
      this.title,
      this.hint,
      this.enabled,
      this.prefixText,
      this.helper,
      this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 2),
            child: Text(
              this.title,
            ),
          ),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          TextFormField(
            enabled: this.enabled,
            focusNode: this.focus,
            controller: this.controller,
            textInputAction: this.inputAction,
            validator: this.validator,
            keyboardType: this.inputType,
            onFieldSubmitted: this.submitted,
            obscureText: this.pass,
            initialValue: this.value,
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
                borderRadius: BorderRadius.circular(kDefaultPadding),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kDefaultPadding),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Function onChange;

  const CustomChip({
    Key key,
    @required this.label,
    @required this.selected,
    @required this.onChange,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      child: FilterChip(
        label: Text(this.label),
        checkmarkColor: Colors.white,
        selected: selected,
        selectedColor: Theme.of(context).primaryColor,
        labelStyle: TextStyle(
          fontSize: Theme.of(context).textTheme.overline.fontSize,
          color: selected ? Colors.white : Colors.black,
        ),
        onSelected: this.onChange,
      ),
    );
  }
}

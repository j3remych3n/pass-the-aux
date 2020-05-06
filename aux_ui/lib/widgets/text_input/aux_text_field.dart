
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/rendering.dart';

class AuxTextField extends StatefulWidget {
  final Widget icon;
  final String label;

  AuxTextField(
    {
      Key key,
      this.icon,
      this.label,
    }
  ): super(key: key);

  @override 
  _AuxTextFieldState createState() => _AuxTextFieldState();
}



class _AuxTextFieldState extends State<AuxTextField> {
  @override
  Widget build(BuildContext context) {
    return 
      TextField(
        style: auxBody2,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          prefixIcon: widget.icon,
          labelText: widget.label,
          labelStyle: auxAccentButton,
          contentPadding: EdgeInsets.all(11),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.circular(10), // TODO: scale by screen resolution
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.circular(10), // TODO: scale by screen resolution
          ),
      ),
    );
  }
}
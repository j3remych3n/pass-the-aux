
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/rendering.dart';

class AuxTextField extends StatefulWidget {
  final Widget icon;
  final String label;

  AuxTextField(
    {
      Key key,
      this.icon = const Icon( Icons.short_text, color:auxAccent, size: 26.0, semanticLabel: "Short text input"),
      this.label,
    }
  ): super(key: key);

  @override 
  _AuxTextFieldState createState() => _AuxTextFieldState();
}

class _ActionButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Function onPressed;

  _ActionButton(
    {
      Key key,
      this.text,
      this.textColor,
      this.onPressed
    }
  );
  
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(0), child: RawMaterialButton(
      child: Text(
        this.text, 
        strutStyle: StrutStyle(height: 1.2), 
        style: auxCaption.apply(color: this.textColor, fontSizeDelta: 1)),
      onPressed:this.onPressed,
      fillColor: Colors.transparent,
      splashColor: Colors.white38,
      constraints: BoxConstraints(minWidth: 40, minHeight: 30),
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      shape: StadiumBorder(),
    ));
  }
}

class _AuxTextFieldState extends State<AuxTextField> {
  @override
  Widget build(BuildContext context) {
    return  
      Column(children: <Widget>[
          TextField(
            style: auxBody2,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              prefixIcon: widget.icon,
              labelText: widget.label,
            ),
          ),
          Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft, 
                child: Padding(
                  padding: EdgeInsets.only(left: 5), 
                  child: _ActionButton(
                    text: 'cancel / clear', 
                    textColor: auxDGrey, 
                    onPressed: (){print('fuck');}
                  )
                )
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 5), 
                  child: _ActionButton(
                    text: 'ok', 
                    textColor: auxAccent, 
                    onPressed: (){print('fuck');}
                  )
                )
              ),
            ],
          ),
        ],
      );
  }
}
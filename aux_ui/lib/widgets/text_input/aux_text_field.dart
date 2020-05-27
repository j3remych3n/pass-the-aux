
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/rendering.dart';

class AuxTextField extends StatefulWidget {
  final Widget icon;
  final String label;
  final Function onFocusChange;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final TextEditingController controller;
  final bool showActions;

  AuxTextField(
    {
      Key key,
      this.icon = const Icon( Icons.short_text, color:auxAccent, size: 26.0, semanticLabel: "Short text input"),
      this.label,
      this.onSubmitted,
      this.onFocusChange,
      this.onChanged,
      this.controller,
      this.showActions = true,
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
  ): super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(0), child: RawMaterialButton(
      child: Text(
        this.text, 
        strutStyle: StrutStyle(height: 1.2), 
        style: auxCaption.apply(color: this.textColor, fontSizeDelta: 1)),
      onPressed: this.onPressed,
      fillColor: Colors.transparent,
      splashColor: Colors.white38,
      constraints: BoxConstraints(minWidth: 50, minHeight: 30),
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      shape: StadiumBorder(),
    ));
  }
}

class _AuxTextFieldState extends State<AuxTextField> {
  FocusNode _textFocus;
  bool _showCancel = false;
  bool _hasInput = false;

  @override
  void initState() {
    super.initState();
    _textFocus = FocusNode();
    _textFocus.addListener(_onFocusChange);
  }

  @override dispose() {
    _textFocus.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    bool focused = _textFocus.hasFocus;
    setState(() {
      _showCancel = focused;
    }); 

    if(widget.onFocusChange != null) widget.onFocusChange(focused);
  }

  void _onChanged(String textInput) {
    if(widget.onChanged != null) widget.onChanged(textInput);
    if((!_hasInput && textInput.length > 0) || (_hasInput && textInput.length == 0)) {
      setState(() {
        _hasInput = !_hasInput;
      });
    }
  }

  void _cancelClear() {
    _textFocus.unfocus();
    widget.controller.clear();
  }

  void _submitCurry() {
    return widget.onSubmitted(widget.controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return  
      Column(children: <Widget>[
          TextField(
            controller: widget.controller,
            focusNode: _textFocus,
            onChanged: _onChanged,
            onSubmitted: widget.onSubmitted,
            style: auxBody2,
            strutStyle: StrutStyle(height: 1.2),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              prefixIcon: widget.icon,
              labelText: widget.label,
            ),
          ),
          Visibility(visible: _showCancel && widget.showActions, child: 
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft, 
                  child: Padding(
                    padding: EdgeInsets.only(left: 5), 
                    child: _ActionButton(
                      text: 'cancel / clear', 
                      textColor: auxDGrey, 
                      onPressed: _cancelClear,
                    )
                  )
                ),
                Visibility(visible: _hasInput, child: 
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 5), 
                      child: _ActionButton(
                        text: 'ok', 
                        textColor: auxAccent, 
                        onPressed: _submitCurry,
                      )
                    )
                  ),
                ),
              ],
            )
          ),
        ],
      );
  }
}
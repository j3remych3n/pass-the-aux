import 'package:aux_ui/widgets/sequential_widget.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/widgets/nux_container.dart';
import 'package:aux_ui/widgets/text_input/aux_text_field.dart';

class NuxOverlay extends SequentialWidget {
  final String title;
  final String label;
  final int topFlex;
  final double nudge;
  final TextEditingController controller;
  final Function onSubmitted;
  final Function onFocusChange;

  const NuxOverlay({
    Key key, 
    this.title,
    this.label,
    this.onSubmitted,
    this.onFocusChange,
    this.controller,
    this.topFlex = 6,
    this.nudge,
  }) : super(key: key);

  _NuxOverlayState createState() => _NuxOverlayState();
}

class _NuxOverlayState extends State<NuxOverlay> {

  void closeOverlay() {
    Navigator.pop(context);
  }
  
  void txtSubmitted(String str) {
    widget.onSubmitted(str);
    closeOverlay();
  }

  void txtFocused(bool focused) {
    widget.onFocusChange(focused);
    if (!focused) {
      closeOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return NuxContainer(
      topFlex: widget.topFlex,
      title: widget.title,
      topWidget: Align(
        alignment: Alignment.bottomCenter,
        child: Expanded(child: AuxTextField(
          label: widget.label,
          controller: widget.controller,
          onSubmitted: txtSubmitted,
          onFocusChange: txtFocused,
        )
        )
      ),
    );
  }
}
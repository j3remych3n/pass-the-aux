import 'package:aux_ui/widgets/sequential_widget.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/rendering.dart';
import 'package:aux_ui/widgets/layout/nux_container.dart';
import 'package:aux_ui/widgets/buttons/rounded_action_button.dart';

class JoinQueueConfirmation extends SequentialWidget {
  const JoinQueueConfirmation({
      Key key, 
      String nextPage, 
      String backPage
    }) : super(key: key, nextPage: nextPage, backPage: backPage);
  _JoinQueueConfirmationState createState() => _JoinQueueConfirmationState();
}

class _JoinQueueConfirmationState extends State<JoinQueueConfirmation> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return NuxContainer(
        topFlex: 6,
        title: 'aux',
        topWidget: const Align(
            alignment: Alignment.bottomLeft,
            child: Text("does this look right?", style: auxDisp3)),
        bottomWidget: Align(
          alignment: Alignment.bottomCenter,
          child: Column(children: <Widget>[
            Padding(
                padding: EdgeInsets.only(
                    top: 35), // TODO: change after putting in queue preview
                child: RoundedActionButton(
                    height: 32,
                    width: SizeConfig.screenWidth * 3 / 5,
                    onPressed: () => widget.next(context),
                    color: auxAccent,
                    borderColor: auxAccent,
                    text: "join",
                    textStyle: auxPrimaryButton)),
            Padding(
                padding: EdgeInsets.only(top: 35),
                child: RoundedActionButton(
                    height: 32,
                    width: SizeConfig.screenWidth * 3 / 5,
                    onPressed: () => widget.back(context),
                    color: auxPrimary,
                    borderColor: auxAccent,
                    text: "this isn't it, take me back",
                    textStyle: auxAccentButton))
          ]),
        ));
  }
}
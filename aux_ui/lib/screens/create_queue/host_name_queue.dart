import 'package:aux_ui/widgets/sequential_widget.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/rendering.dart';
import 'package:aux_ui/widgets/layout/nux_container.dart';
import 'package:aux_ui/widgets/text_input/aux_text_field.dart';

class HostNameQueue extends SequentialWidget {
  const HostNameQueue({Key key, String nextPage})
      : super(key: key, nextPage: nextPage);

  _HostNameQueueState createState() => _HostNameQueueState();
}

class _HostNameQueueState extends State<HostNameQueue> {
  String queueName = "";
  TextEditingController queueNameController;

  @override
  void initState() {
    super.initState();
    queueNameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    queueNameController.dispose();
  }

  void submitted(String queueName) {
    widget.nextReplace(context, arguments: queueName);
  }

  void changed(String text) {
    queueName = text;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return NuxContainer(
        topFlex: 6,
        title: 'aux',
        topWidget: const Align(
            alignment: Alignment.bottomLeft,
            child: Text(
                "one more step and we're ready to roll", style: auxDisp3)),
        bottomWidget: Align(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(
                    bottom: SizeConfig.safeAreaVertical * 1.5),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      AuxTextField(
                        controller: queueNameController,
                        onSubmitted: submitted,
                        onChanged: changed,
                        icon: Icon(
                          Icons.short_text,
                          color: auxAccent,
                          size: 26.0,
                          semanticLabel: "aux queue name",
                        ),
                        label: 'name your aux queue',
                      )
                    ]))));
  }
}
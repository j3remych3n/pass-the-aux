import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/buttons/header_chip.dart';
import 'package:flutter/material.dart';

class QueueHeader extends StatelessWidget {
  int getNumInParty() {
    // TODO: implement
    return 12;
  }

  String getHost() {
    // TODO: implement
    return "Diane";
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Align(
          alignment: Alignment.bottomLeft,
          child: Text('too queue for u', style: auxDisp2)),
      Padding(
          padding: EdgeInsets.only(top: 3), // TODO: scale or finalize
          child: Row(
            children: <Widget>[
              HeaderChip(iconName: Icons.fiber_manual_record, text: "LIVE", color: Colors.red),
              HeaderChip(iconName: Icons.group, text: "${getNumInParty()} people in group", color: auxAccent),
              HeaderChip(iconName: Icons.person_outline, text: "hosted by ${getHost()}", color: auxAccent)
            ],
          ))
    ]);
  }
}
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/layout/aux_card.dart';
import 'package:aux_ui/widgets/layout/queue_item.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/widgets/buttons/queue_item_action.dart';

class Tester extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  SizeConfig().init(context);

    return Container(
        color: auxPrimary,
        child: Padding(
            padding: SizeConfig.notchPadding,
            child: AuxCard(
              borderColor: auxAccent,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                ],
              ),
            )
        )
    );
  }
}
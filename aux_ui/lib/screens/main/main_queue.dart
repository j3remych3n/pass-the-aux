import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/layout/queue_container.dart';

class MainQueue extends StatefulWidget {
  _MainQueueState createState() => _MainQueueState();
}

class _MainQueueState extends State<MainQueue> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Material(
      type: MaterialType.transparency,
      child:
        Container(
          padding: SizeConfig.notchPadding,
          color: auxPrimary,
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left:12, right:12, top:42, bottom: 8),
                  child: 
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('too queue for u', style: auxDisp2)
                    )
                ),    
                QueueContainer(
                  title: 'your songs',
                  child: Text('child'),
                  titleWidget: Text('title widget'),
                ),
              ],
            ),
        ),
      )
    );
  }
}
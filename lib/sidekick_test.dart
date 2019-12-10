import 'package:flutter/material.dart';
import 'package:flutter_sidekick/flutter_sidekick.dart';

class SideKickTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SideKickTestState();
  }
}

class SideKickTestState extends State<SideKickTest>
    with TickerProviderStateMixin {
  SidekickController controller;

  @override
  void initState() {
    super.initState();
    controller = SidekickController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Sidekick(
            tag: 't1',
            targetTag: 't3',
            child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("t1"),
                ),
                onTap: () => controller.moveToTarget(context))),
        Sidekick(
            tag: 't2',
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("t2"),
            )),
        Sidekick(
            tag: 't3',
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(),
            )),
        Sidekick(
            tag: 't4',
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("t4"),
            )),
      ],
    );
  }
}

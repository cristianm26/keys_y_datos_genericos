import 'package:flutter/material.dart';

class AdaptivePage extends StatelessWidget {
  final _listKey = GlobalKey();
  AdaptivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: OrientationBuilder(
            builder: (_, Orientation orientation) {
              if (orientation == Orientation.portrait) {
                return AdaptiveList(listKey: _listKey);
              }
              return Row(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text("Contenido Izquierda"),
                    ),
                  ),
                  Expanded(
                    child: AdaptiveList(listKey: _listKey),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class AdaptiveList extends StatelessWidget {
  const AdaptiveList({
    Key? key,
    required GlobalKey listKey,
  })  : _listKey = listKey,
        super(key: key);

  final GlobalKey _listKey;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: _listKey,
      itemBuilder: (_, index) => ListTile(
        title: Text("$index"),
      ),
      itemCount: 100,
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeysPage extends StatefulWidget {
  const KeysPage({Key? key}) : super(key: key);

  @override
  _KeysPageState createState() => _KeysPageState();
}

class _KeysPageState extends State<KeysPage> {
  bool _enabled = true;
  final _key = GlobalKey();
  List<Widget> _textFields = [
    const CupertinoTextField(
      key: ValueKey(1),
      placeholder: "Input 1",
    ),
    const CupertinoTextField(
      key: ValueKey(2),
      placeholder: "Input 2",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !_enabled
            ? CupertinoTextField(
                key: _key,
                placeholder: "Input",
              )
            : Container(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_enabled)
              CupertinoTextField(
                key: _key,
                placeholder: "Input 1",
              ),
            /*
            else
              Container(
                color: Colors.redAccent,
                padding: const EdgeInsets.all(10),
                child: CupertinoTextField(
                  key: _key,
                  placeholder: "Input 1",
                ),
              ),
            const CupertinoTextField(
              key: ValueKey(2),
              placeholder: "Input 2",
            ) */
            ..._textFields,
            Switch(
              value: _enabled,
              onChanged: (value) {
                _enabled = value;

                _textFields = _textFields.reversed.toList();
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}

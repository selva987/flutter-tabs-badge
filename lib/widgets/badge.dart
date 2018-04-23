import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final _texto;

  Badge(this._texto);

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.deepOrange,
      ),
      child: new Text(this._texto),
      padding: EdgeInsets.all(7.0),
      margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
    );
  }
}

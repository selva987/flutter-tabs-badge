import 'package:flutter/material.dart';
import 'lista.dart';
import 'widgets/badge.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return new MaterialApp(title: 'Prueba tabs', home: new MiTabController());
  }
}

class MiTabController extends StatefulWidget {
  @override
  createState() => new MiTabControllerState();
}

class MiTabControllerState extends State<MiTabController> {
  Set _saved = new Set();
  RandomWords randomWords;

  void _onRefreshList(Set lista) {
    setState(() {
          _saved = lista;
        });
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 3,
        child: new Scaffold(
            appBar: new AppBar(
              bottom: new TabBar(
                tabs: [
                  new Tab(
                      //text: 'home',
                      child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[new Text('Home'), new Badge(_saved.length.toString())],
                  )),
                  new Tab(icon: new Icon(Icons.directions_transit)),
                  new Tab(icon: new Icon(Icons.directions_bike)),
                ],
              ),
              title: new Text('Prueba tabs'),
            ),
            body: new TabBarView(
              children: [
                randomWords,
                new Icon(Icons.directions_transit),
                new Icon(Icons.directions_bike),
              ],
            )));
  }

  @override
  void initState() {
      // TODO: implement initState
      super.initState();
      randomWords = new RandomWords(listaChanged: _onRefreshList,);
      
    }


}

import 'package:flutter/material.dart';
import 'lista.dart';
import 'widgets/badge.dart';

void main() => runApp(new MiTab());

class MiTab extends StatefulWidget {
  @override
  createState() => new MiTabState();
}

class MiTabState extends State<MiTab> with SingleTickerProviderStateMixin {
  Set _saved = new Set();
  RandomWords randomWords;
  TabController _tabController;

  void _onRefreshList(Set lista) {
    setState(() {
      _saved = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Prueba tabs',
        home: new Scaffold(
            appBar: new AppBar(
              bottom: new TabBar(
                tabs: [
                  new Tab(
                      //text: 'home',
                      child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text('Home'),
                      new Badge(_saved.length.toString())
                    ],
                  )),
                  new Tab(icon: new Icon(Icons.directions_transit)),
                  new Tab(icon: new Icon(Icons.directions_bike)),
                ],
                controller: _tabController,
              ),
              title: new Text('Prueba tabs'),
            ),
            body: new TabBarView(
              children: [
                new RandomWords(listaChanged: _onRefreshList,),
                new Icon(Icons.directions_transit),
                new Icon(Icons.directions_bike),
              ],
              controller: _tabController,
            )));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(
      length: 3,
      vsync: this,
    );
  }
}

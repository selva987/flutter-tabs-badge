import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_flux/flutter_flux.dart';
import 'flux/stores.dart';

class RandomWords extends StatefulWidget {
  final ValueChanged<Set> listaChanged;
  RandomWords({Key key, this.listaChanged,}): super(key:key);

  @override
  createState() => new RandomWordsState();
}

//FLUX: para poder usar flux en mi action tengo que implementar StoreWatcherMixin
class RandomWordsState extends State<RandomWords> with StoreWatcherMixin<RandomWords>{
  final _biggerFont = const TextStyle(fontSize: 18.0);
  //FLUX: declaro las variables de lo que voy a usar
  SuggestionStore _suggestionStore;
  SavedStore _savedStore;

  @override
  Widget build(BuildContext context) {
    return  _buildSuggestions();
  }

  Widget _buildSuggestions() {
    //FLUX: obtengo el dato que necesito de la store, o sea, el dato persistido
    List<WordPair> _suggestions = _suggestionStore.suggestions;
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          // Add a one-pixel-high divider widget before each row in theListView.
          if (i.isOdd) return new Divider();

          final index = i ~/ 2;
          // If you've reached the end of the available word pairings...
          if (index >= _suggestions.length) {
            // ...then generate 10 more and add them to the suggestions list.
            _suggestions.addAll(generateWordPairs().take(10));

            //FLUX: llamo al action para modificar los datos de la store para que "persistan"
            setSuggestionsAction(_suggestions);
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    Set<WordPair> _saved = _savedStore.saved;
    final alreadySaved = _saved.contains(pair);

    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
          setSavedAction(_saved);
        });
        widget.listaChanged(_saved);
      },
    );
  }

  void _pushSaved() {
    Set<WordPair> _saved = _savedStore.saved;
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile
              .divideTiles(
                context: context,
                tiles: tiles,
              )
              .toList();
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
  @override
    void initState() {
      // TODO: implement initState
      super.initState();

      //FLUX: cada vez que inicio el state traigo las instancias de los stores
      _suggestionStore = listenToStore(sugggestionStoreToken);
      _savedStore = listenToStore(savedStoreToken);
    }

}

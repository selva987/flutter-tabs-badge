import 'package:flutter_flux/flutter_flux.dart';
import 'package:english_words/english_words.dart';

class SuggestionStore extends Store {
  List _suggestions = <WordPair>[];
 

  SuggestionStore() {
    //Hago que mi store escuche a ese action y guarde la lista
    triggerOnAction(setSuggestionsAction, (List lista) {
      this._suggestions = lista;
    });

  }

  //getter de la lista, hago una copia porque la store solo se debe modificar mediante actions
  List<WordPair> get suggestions => new List<WordPair>.from(_suggestions);
  
}

class SavedStore extends Store {
   Set _saved = new Set<WordPair>();

   SavedStore() {
     triggerOnAction(setSavedAction, (Set lista) {
      this._saved = lista;
    });
   }

   Set<WordPair> get saved => new Set.from(_saved);
}

//Cada store tiene su token, creo que es para identificar una instancia de la store o algo asi
final StoreToken sugggestionStoreToken = new StoreToken(new SuggestionStore());
final StoreToken savedStoreToken = new StoreToken(new SavedStore());

//declaro los actions
final Action<List> setSuggestionsAction = new Action<List>();
final Action<Set> setSavedAction = new Action<Set>();
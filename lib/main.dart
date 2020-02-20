import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Welcom to cristian zabala',
      home: Randowords(),
    );

  }

}

class Randowords extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RandomWordsState();

  }
}
class RandomWordsState extends State<Randowords>{
  final _sugetions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggeFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('well come'),
        actions:<Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: _pushSaved,
        ),
        ],
      ),
      body: _new(),
    );
  }

  void _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute(
        // ignore: missing_return
        builder: (context){
          final tiles = _saved.map((pair){
            return ListTile(
              title: Text(pair.asPascalCase,
              style:_biggeFont ,
              ),
            );
          });
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles).toList();
          return Scaffold(
            appBar: AppBar(
            title: Text('saved Suggestions'),

            ),
            body: ListView(children: divided,),
          );
        }));
  }

  Widget _new(){
  return ListView.builder(
    // ignore: missing_return
    padding: const EdgeInsets.all(16.0),
    itemBuilder: (context, i){
      if(i.isOdd){
        return Divider();
      }
      if(i >= _sugetions.length){
        _sugetions.addAll(generateWordPairs().take(10));
      }
      final index = i ~/2;
     return _builRow(_sugetions[index]);
  },
  );

  }

  Widget _builRow(WordPair pair){
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase,
      style:_biggeFont ,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: (){
        setState(() {
          if(alreadySaved){
            _saved.remove(pair);
          }else{
            _saved.add(pair);
          }
          
        });
      },
    );
  }

}



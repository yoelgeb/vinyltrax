import 'package:flutter/material.dart';
import '../database.dart';

class AlbumOrderAlbum extends StatelessWidget {
  AlbumOrderAlbum({Key? key}) : super(key: key);

  final Future<List<Text>> _results = Database.displayByName();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FutureBuilder<List<Text>>(
          future: _results,
          builder: (BuildContext context, AsyncSnapshot<List<Text>> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[];
              for (int i = 0; i < snapshot.data!.length; i += 2) {
                children.add(SizedBox(
                  width: double.infinity,
                  height: 20,
                  child: const Text(""),
                ));
                children.add(Center(
                  child: snapshot.data?[i],
                ));
                children.add(Center(
                  child: snapshot.data?[i + 1],
                ));
              }
            } else if (snapshot.hasError) {
              children = <Widget>[
                Icon(Icons.error),
              ];
            } else {
              children = <Widget>[
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                )
              ];
            }
            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children),
            );
          }),
    );
  }
}

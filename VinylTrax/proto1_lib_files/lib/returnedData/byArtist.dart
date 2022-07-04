import 'package:flutter/material.dart';
import '../database.dart';
import '../show_data/listEntry.dart';
import '../show_data/listEntryList.dart';

class AlbumOrderArtist extends StatelessWidget {
  AlbumOrderArtist({Key? key}) : super(key: key);

  final Future<List<Text>> _results = Database.artists();
  List<Widget> children = <Widget>[];


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FutureBuilder<List<Text>>(
          future: _results,
          builder: (BuildContext context, AsyncSnapshot<List<Text>> snapshot) {
            if (snapshot.hasData)
            {
              for (int i = 0; i < snapshot.data!.length; i+=2)
                {
                  ListEntry temp = ListEntry( snapshot.data?[i].data as String, "", false);
                  temp.artistID = snapshot.data?[i + 1].data as String;
                  if (children.length % 2 != 0)
                    temp.color = Colors.black12;
                  children.add(temp);
                }
            }
            else if (snapshot.hasError) {
              children = <Widget>[
                Icon(Icons.error),
              ];
            }
            // else {
            //   children = <Widget>[
            //     Center(
            //       child: SizedBox(
            //         width: 50,
            //         height: 50,
            //         child: CircularProgressIndicator(),
            //       ),
            //     )
            //   ];
            // }
            return ListEntryList(children);
          }),
    );
  }
}

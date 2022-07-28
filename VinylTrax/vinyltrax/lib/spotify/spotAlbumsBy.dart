import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:vinyltrax/show_data/iconList.dart';
import '../show_data/icon.dart';
import 'spotify.dart';
import '../pages/settingspage.dart' as settings;
import '../show_data/listEntry.dart';
import 'spotScroll.dart';

import 'dart:developer';

class SpotAlbumsBy extends StatelessWidget {
  final List<String> input;
  SpotAlbumsBy(this.input);

  @override
  Widget build(BuildContext context) {
    // Future<Map<String, List<String>>> _results = Collection.albumsBy(input[0]);
    Future<Map<String, List<dynamic>>> _results = Spotify.albumsBy(input[0]);
    // late String name = "Artist not found";
    String name = input[1];

    Widget title = Text(
      name.replaceAll(RegExp(r'\([0-9]+\)'), ""),
      style: TextStyle(
        color: settings.darkTheme ? Colors.white : Colors.black,
      ),
    );

    if (name.length > 27) {
      title = Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Marquee(
          velocity: 20,
          blankSpace: 30,
          text: name,
          style: TextStyle(
            color: settings.darkTheme ? Colors.white : Colors.black,
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: settings.darkTheme ? Color(0xFF1C1C1C) : Color(0xFFFFFDF6),
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.10, //180
          backgroundColor: settings.darkTheme ? Color(0xFF181818) : Color(0xFFFFFDF6),
          leading: BackButton(
            color: settings.darkTheme ? Colors.white : Colors.black,
          ),
          title: title,
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: SizedBox(
                width: double.infinity,
                child: FutureBuilder<Map<String, List<dynamic>>>(
                  future: _results,
                  builder: (BuildContext context,
                      AsyncSnapshot<Map<String, List<dynamic>>> snapshot) {
                    List<Widget> children;
                    if (snapshot.hasData) {
                      children = <Widget>[];
                      List<Widget> albums = [];
                      List<Widget> singles = [];
                      List<Widget> appears = [];

                      var map = snapshot.data!;
                      List<dynamic> list;

                      // #######################################################
                      // Collect Albums
                      // #######################################################
                      list = map["albums"] as List<dynamic>;

                      // list view
                      if (settings.listBool)
                        list.forEach((element) {
                          children.add(
                            ListEntry(
                              name: element[1],
                              image: element[3],
                              isAlbum: true,
                              location: "spotify",
                              id: element[0],
                            ),
                          );
                        });

                      // icon view
                      else
                        for (int i = 0; i < list.length && i < 10; i++) {
                          var element = list[i];
                          albums.add(ShowIcon(
                            coverArt: element[3],
                            isArtist: false,
                            location: 'spotify',
                            id: element[0],
                            albumName: element[1],
                          ));
                        }

                      // #######################################################
                      // Collect Singles and EPs
                      // #######################################################
                      list = map["singles"] as List<dynamic>;

                      // list view
                      if (settings.listBool)
                        list.forEach((element) {
                          children.add(
                            ListEntry(
                              name: element[1],
                              image: element[3],
                              isAlbum: true,
                              location: "spotify",
                              id: element[0],
                            ),
                          );
                        });

                      // icon view
                      else
                        for (int i = 0; i < list.length && i < 10; i++) {
                          var element = list[i];

                          // log(element[1]);
                          singles.add(ShowIcon(
                            coverArt: element[3],
                            isArtist: false,
                            location: 'spotify',
                            id: element[0],
                            albumName: element[1],
                          ));
                        }
                      // #######################################################
                      // Collect Albums the Artist Appears On
                      // #######################################################
                      list = map["appears"] as List<dynamic>;

                      // list view
                      if (settings.listBool)
                        list.forEach((element) {
                          children.add(
                            ListEntry(
                              name: element[1],
                              image: element[3],
                              isAlbum: true,
                              location: "spotify",
                              id: element[0],
                            ),
                          );
                        });

                      // icon view
                      else
                        for (int i = 0; i < list.length && i < 10; i++) {
                          var element = list[i];
                          appears.add(ShowIcon(
                            coverArt: element[3],
                            isArtist: false,
                            location: 'spotify',
                            id: element[0],
                            albumName: element[1],
                          ));
                        }
                      // #######################################################
                      // Output each collection in its own horizontal section
                      // #######################################################
                      if (!settings.listBool) {
                        if (albums.length > 0)
                          children.add(SpotScroll(albums, "Albums", snapshot));
                        if (singles.length > 0)
                          children.add(
                              SpotScroll(singles, "Singles & EPs", snapshot));
                        if (appears.length > 0)
                          children
                              .add(SpotScroll(appears, "Appears On", snapshot));
                        if (children.length == 0)
                          children.add(Text(
                            "No results for ${input[1]}",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ));
                      }

                      children.add(SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: const Text(""),
                      ));
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
                    return Column(
                      children: [
                        IconList(children),
                      ],
                    );
                  },
                )),
          ),
        ),
      ),
    );
  }
}

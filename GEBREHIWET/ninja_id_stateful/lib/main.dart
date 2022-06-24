import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: NinjaCard(),
  ));
}

class NinjaCard extends StatefulWidget {
  const NinjaCard({Key? key}) : super(key: key);

  @override
  State<NinjaCard> createState() => _NinjaCardState();
}

class _NinjaCardState extends State<NinjaCard> {

  int ninjaLevel = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Ninja ID Card'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            ninjaLevel += 1;
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.grey[800],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, //left aligned
          children: [ //list of widgets
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/chun-li.jpg'),
                radius: 40,
              ),
            ),
            Divider(
              height: 90.0,
              color: Colors.grey[700]
            ),
            Text(
              'NAME',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0
              ),
            ),
            SizedBox(height: 10), //makes an empty box
            Text(
              'Chun-Li',
              style: TextStyle(
                  color: Colors.amberAccent[200],
                  letterSpacing: 2.0,
                fontSize: 28,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 30,),
            Text(
              'CURRENT NINJA LEVEL',
              style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0
              ),
            ),
            SizedBox(height: 10), //makes an empty box
            Text(
              '$ninjaLevel',
              style: TextStyle(
                  color: Colors.amberAccent[200],
                  letterSpacing: 2.0,
                  fontSize: 28,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Icon(
                  Icons.email,
                  color: Colors.grey[400],
                ),
                SizedBox(width: 10,),
                Text(
                  'chun.li@theninga.co.uk',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}

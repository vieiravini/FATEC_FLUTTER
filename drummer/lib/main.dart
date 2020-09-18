import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drummer',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SonnyDrummer'),
        backgroundColor: Colors.black,
      ),
      body: GridView.count(
          crossAxisCount: 4,
          children: List.generate(16, (index) {
            return Center(
              child: BotaoDrum(
                cor: Color.fromRGBO(255, index * 15, index + 1, 100),
                numero: index + 1,
              ),
            );
          })),
    );
  }
}

class BotaoDrum extends StatelessWidget {
  final int numero;
  final Color cor;

  const BotaoDrum({this.numero, this.cor});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      height: 80,
      color: cor,
      onPressed: () {
        var player = AudioCache();
        player.play('beat$numero.wav');
      },
    );
  }
}

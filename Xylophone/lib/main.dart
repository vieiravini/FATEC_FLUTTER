import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BotaoXilofone(
          numero: 1,
          cor: Colors.red,
        ),
        BotaoXilofone(
          numero: 2,
          cor: Colors.orange,
        ),
        BotaoXilofone(
          numero: 3,
          cor: Colors.yellow,
        ),
        BotaoXilofone(
          numero: 4,
          cor: Colors.blue,
        ),
        BotaoXilofone(
          numero: 5,
          cor: Colors.purple,
        ),
        BotaoXilofone(
          numero: 6,
          cor: Colors.cyan,
        ),
        BotaoXilofone(
          numero: 7,
          cor: Colors.lightBlue,
        ),
      ],
    ));
  }
}

class BotaoXilofone extends StatelessWidget {
  final int numero;
  final Color cor;

  const BotaoXilofone({this.numero, this.cor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(
        color: cor,
        onPressed: () {
          var player = AudioCache();
          player.play('note$numero.wav');
        },
      ),
    );
  }
}

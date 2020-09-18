import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

// Criamos Widget Statefull que representa a tela
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future _launchUrl() async {
    const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Falha ao abrir url: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar
      appBar: AppBar(
        title: Text('IdCard'),
      ),
      //Body
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 95,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/5211507/pexels-photo-5211507.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
              radius: 90,
            ),
          ),
          Text(
            'Yasmin Roussef',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            'FLUTTER DEVELOPER',
            style: TextStyle(
              fontSize: 24,
              fontStyle: FontStyle.italic,
              color: Colors.black54,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 75,
              vertical: 20,
            ),
            child: Divider(
              color: Colors.blueAccent,
              height: 5,
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: ListTile(
              leading: Icon(FontAwesomeIcons.linkedin, color: Colors.black),
              title: Text(
                'linkedin/yasminroussef',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                _launchUrl();
              },
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: ListTile(
              leading: Icon(FontAwesomeIcons.facebook, color: Colors.black),
              title: Text(
                'facebook/yasminroussef',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                _launchUrl();
              },
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: ListTile(
              leading: Icon(FontAwesomeIcons.instagram, color: Colors.black),
              title: Text(
                'instagram/yasminroussef',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                _launchUrl();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ButaoCustomizado extends StatelessWidget {
  final String textoBotao;
  const ButaoCustomizado(this.textoBotao);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {},
      child: Text(textoBotao),
    );
  }
}

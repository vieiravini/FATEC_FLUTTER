import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'dart:convert' as json;

import 'package:loading/loading.dart';

class PexelsImage extends StatelessWidget {
  final Map data;
  final int index;

  PexelsImage({@required this.data, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          data["photos"][index]["src"]["medium"],
          fit: BoxFit.cover,
          height: 300,
        ),
        //LabelImageData(data: data, index: index),
      ],
    );
  }
}

class DeuRuimWidget extends StatelessWidget {
  final String mensagem;
  final IconData icon;

  DeuRuimWidget({this.mensagem, this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: Text(
            mensagem,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Icon(
          icon,
          color: Colors.green.shade500,
          size: 72,
        ),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static String _busca;

  @override
  void initState() {
    super.initState();
    _getImages().then((value) => print(value));
  }

  static const String API_KEY =
      '563492ad6f917000010000016fb1179c61fb4678b5a1eda0e788f443';

  /* Metodo reponsavel por realizar requisicao web assincrona com a Pexels API
    O header Authorization foi adicionado ao parametro opcional nomeado [headers:{}]
    O modificado async torna o metodo assincrono.
    O modificador await faz com que a instrucao seja executada em background e continue do ponto atual ao concluir as tarefas.
  */

  int _getCount(List data) {
    // O operador ?? valida se é nulo, caso contrário retorna um valor qualquer.
    return data.length ?? 0;
  }

  Future _getImages() async {
    // Url para buscar as melhores foto do dia
    final urlCuratedPhotos =
        'https://api.pexels.com/v1/curated?per_page=40&page=1';

    // Url para realizar buscas na API
    final urlSearch =
        'https://api.pexels.com/v1/search?query=$_busca&per_page=40&page=1';

    /* Trecho valida estado da variacel _busca; como este método _getImages() está dentro de InitState;
      Sempre que a tela for redesenhada por uma chamada ao setState, a função será carregada.
      Então será validado o conteudo da requisicao; se estiver vazio as imagens do dia serao exibidas,
      se houver conteudo, será realizada uma busca pelo conteudo contido.
    */
    var url = _busca == null || _busca.isEmpty ? urlCuratedPhotos : urlSearch;

    http.Response response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: API_KEY});

    // Neste trecho validados o statusCode da requisição, caso não haja problemas, retorna-se os dados da requisção em JSON
    if (response.statusCode == 200) {
      // O objeto json foi extraido da classe convert.dart, ele é responsável por realizar conversões para JSON.
      return json.jsonDecode(response.body);
    } else {
      print("Erro ao obte imagens. Status Code: ${response.statusCode}");
    }
  }
  // Scaffold logo abaixo...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF232A34),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              color: Color(0xFF232A34),
              padding: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  Image.network(
                    'http://images.pexels.com/lib/api/pexels-white.png',
                    height: 35,
                    fit: BoxFit.fitHeight,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        onSubmitted: (text) {
                          setState(() {
                            _busca = text;
                          });
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: _getImages(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Container(
                          width: 200,
                          height: 200,
                          alignment: Alignment.center,
                          child: Loading(
                            indicator: BallPulseIndicator(),
                            size: 200,
                            color: Colors.white,
                          ),
                        );
                      default:
                        if (snapshot.hasError) {
                          return DeuRuimWidget(
                            mensagem: "Erro ao obter dados da API Pexels...",
                            icon: FontAwesomeIcons.exclamationTriangle,
                          );
                        } else if ((_getCount(snapshot.data['photos'])) == 0) {
                          return DeuRuimWidget(
                            mensagem: "Nao encontramos resultados...",
                            icon: FontAwesomeIcons.sadCry,
                          );
                        } else {
                          return Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: _createImageGrid(context, snapshot),
                          );
                        }
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget _createImageGrid(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: EdgeInsets.only(top: 5, bottom: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: _getCount(snapshot.data["photos"]),
      itemBuilder: (context, index) {
        return PexelsImage(data: snapshot.data, index: index);
      },
    );
  }
}

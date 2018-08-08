import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:cepappp_flutter/cep.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'CepApp',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'CepApp Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final myController = TextEditingController();
  String _numCep = null;

  Future<Cep> _getCep() async {
    final String dataURL = "https://viacep.com.br/ws/" + _numCep + "/json";
    final http.Response response = await http.get(dataURL);

    if (response.statusCode == 200) {
      return Cep.fromJson(json.decode(response.body));
    } else {
      print(json.decode(response.body));
    }

  }

  String updateNumCep() {

    setState(() {
      _numCep = myController.text;
    });

    return _numCep;
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Column(
        children: <Widget> [
          FutureBuilder<Cep>(
            future: _getCep(),
            builder: (context, cep) {
              if (cep.hasData) {
                return Column(
                  children: <Widget> [
                    Row(
                      children: <Widget> [
                        Text("Logradouro:"),
                        Text("${cep.data.logradouro}"),
                      ]
                    ),
                    Row(
                      children: <Widget> [
                        Text("Complemento:"),
                        Text("${cep.data.complemento}"),
                      ]
                    ),
                    Row(
                      children: <Widget> [
                        Text("Bairro:"),
                        Text("${cep.data.bairro}"),
                      ]
                    ),
                    Row(
                      children: <Widget> [
                        Text("Cidade:"),
                        Text("${cep.data.cidade}"),
                      ]
                    ),
                    Row(
                      children: <Widget> [
                        Text("Estado:"),
                        Text("${cep.data.estado}"),
                      ]
                    ),
                  ]
                );
              } else {
                print("${cep.error}");
                return Text("Digite abaixo um CEP válido para pesquisar");
              }
              // Por padrão mostra tela de carregando
              return CircularProgressIndicator();
            }
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: myController,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          updateNumCep();
        },
        tooltip: 'Pesquisar!',
        child: Icon(Icons.search),
      ),
    );
  }

}

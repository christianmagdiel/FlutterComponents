import 'dart:async';

import 'package:flutter/material.dart';

class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {

  ScrollController _scrollController = new ScrollController();

  List<int> _listaNumeros = new List();
  int _ultimoNumero = 0;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _agregar10();

    _scrollController.addListener((){
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        //_agregar10();
        fetchData();
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas'),
      ),
      body: Stack(
        children: <Widget>[
                   _crearLista(),
                   _crearLoading()
        ],
      )
    );
  }

  Widget _crearLista(){
    return RefreshIndicator(
       
      onRefresh: ObtenerPagina1,

       child: ListView.builder(
       controller: _scrollController,
       itemCount: _listaNumeros.length,
       itemBuilder: (BuildContext context,int index){
         final imagen = _listaNumeros[index];
         return FadeInImage(
           image: NetworkImage('https://picsum.photos/500/300/?image=$imagen'),
           placeholder: AssetImage('assets/jar-loading.gif'),
         );
       },
      ),
    );
  }

  Future<Null> ObtenerPagina1() async{
    final duration = new Duration(seconds: 2);

    new Timer(duration,(){
        _listaNumeros.clear();
        _ultimoNumero++;
        _agregar10();
    });

    return Future.delayed(duration);
  }

  void _agregar10(){
    for (var i = 0; i < 10; i++) {
      _ultimoNumero++;
      _listaNumeros.add(_ultimoNumero);
    }

    setState(() {
      
    });
  }

  Future fetchData() {
    _isLoading =true;
    setState(() {
      final duration = new Duration(seconds: 2);
      return new Timer(duration, respuestaHTTP);
    });
  }

  void respuestaHTTP() {
    _isLoading = false;
    _scrollController.animateTo(
      _scrollController.position.pixels + 100,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 250)
    );
    _agregar10();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  Widget _crearLoading() {
    if (_isLoading){
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator()
            ],
          ),
          SizedBox(height: 15.0,)
        ],
      ); 
      
     
    }else{
      return Container();
    }
  }
}
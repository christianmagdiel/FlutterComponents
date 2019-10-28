import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _valorSlider = 100.0;
  bool _bloquearSlider = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slider'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50.0),
        child: Column(
          children: <Widget>[
            _crearSlider(),
            _crearCheckBox(),
            _crearSwitch(),
            Expanded(
              child: _crearImagen()
              )
          ],
        ),
      ),
    );
  }

 Widget _crearSlider() {
   return Slider(
     value:_valorSlider,
     label: 'Tamaño de la imagen',
     min: 10.0,
     max: 400.0,
     onChanged: (_bloquearSlider) ? null : (valor){
       setState(() {
          _valorSlider = valor;
       });
     },
   );
 }

 Widget _crearImagen() {
   return Image(
     image: NetworkImage('http://static.t13.cl/images/sizes/1200x675/1569598035-spider-man-2.jpg'),
     width: _valorSlider,
     fit : BoxFit.contain
   );
 }

 Widget _crearCheckBox() {
  //  return Checkbox(
  //    value: _bloquearCheck,
  //    onChanged: (valor) {
  //      setState(() {
  //      _bloquearCheck = valor;
  //      });
  //    },
  //  );
  return CheckboxListTile(
    title: Text('Bloquear Slider'),
    value: _bloquearSlider,
    onChanged: (valor){
      setState(() {
       _bloquearSlider = valor; 
      });
    },
  );
 }

 Widget _crearSwitch() {
   return SwitchListTile(
    title: Text('Bloquear Slider'),
    value: _bloquearSlider,
    onChanged: (valor){
      setState(() {
       _bloquearSlider = valor; 
      });
    },
  );
 }
}
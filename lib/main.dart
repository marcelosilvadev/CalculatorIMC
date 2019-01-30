import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 16) {
        _infoText = "Magreza grave (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 16 && imc < 17) {
        _infoText = "Magreza moderada (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 17 && imc < 18.5) {
        _infoText = "Magreza leve (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.5 && imc < 25) {
        _infoText = "Saudável (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 25 && imc < 30) {
        _infoText = "Sobrepeso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 30 && imc < 35) {
        _infoText = "Obesidade Grau 1 (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 35 && imc < 40) {
        _infoText =
            "Obesidade Grau II (severa) (${imc.toStringAsPrecision(3)})";
      } else if (imc > 40) {
        _infoText =
            "	Obesidade Grau III (mórbida) (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.stretch, //Buscara sempre preencher a tela
              children: <Widget>[
                Icon(Icons.person_pin, size: 120.0, color: Colors.blue),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (KG)",
                      labelStyle: TextStyle(color: Colors.blue)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 25.0),
                  controller: weightController,
                  validator: (value) {
                    if(value.isEmpty){
                      return "Insira seu Peso";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.blue)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    if(value.isEmpty){
                      return "Insira sua Altura";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if(_formKey.currentState.validate()){
                            _calculate();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.blue,
                      )),
                ),
                Text(_infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25.0))
              ],
            ),
          )
        ));
  }
}

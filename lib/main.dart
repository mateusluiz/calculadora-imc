import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void resetFields() {
    weightController.text = "";
    heightController.text = "";

    setState(() {
      _infoText = "Informe seus dados!";
    });
  }

  void calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsFixed(2)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsFixed(2)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsFixed(2)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsFixed(2)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsFixed(2)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsFixed(2)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            onPressed: resetFields,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.person,
                  size: 120,
                  color: Colors.deepPurple,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Peso (kg)',
                    labelStyle: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 30,
                  ),
                  controller: weightController,
                  validator: (value) {
                    if (value == null) {
                      _infoText = "Insira seu Peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 30,
                  ),
                  controller: heightController,
                  validator: (value) {
                    if (value == null) {
                      return "Insira sua Altura!";
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: calculate,
                      child: const Text(
                        'Calcular',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 25.0,
                  ),
                )
              ],
            ),
          )),
    );
  }
}

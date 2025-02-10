import 'package:flutter/material.dart';

class Contador extends StatefulWidget {
  const Contador({super.key});

  @override
  State<Contador> createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {
  TextEditingController counterText = TextEditingController();
  int counter = 0;
  final estiloTexto = TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador de taps'),
      ),
      body: Center(
        child: contenido(),
      ),
      floatingActionButton: botones(counter),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void incrementar() {
    counter++;
    counterText.text = counter.toString();
    print(counter);
    setState(() {});
  }

  void decrementar() {
    counter--;
    counterText.text = counter.toString();
    print(counter);
    setState(() {});
  }

  void reinicio() {
    counter = 0;
    counterText.text = counter.toString();
    print(counter);
    setState(() {});
  }

  Column contenido() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        espacio(15.5),
        Text('Número de Taps: ', style: estiloTexto),
        espacio(50.0),
        conteo(),
        Text(
          'desarrollador: ',
          style: estiloTexto,
        ),
        Text(
          'Santiago Alameda Sánchez',
          style: estiloTexto,
        ),
        espacio(50),
      ],
    );
  }

  SizedBox conteo() {
    return SizedBox(
      width: 250.0,
      child: TextField(
          onChanged: (value) {
            counter = int.parse(value);
          },
          enabled: true,
          controller: counterText,
          style: TextStyle(
            color: Color.fromARGB(200, 200, 25, 0),
            fontWeight: FontWeight.bold,
          ),
          maxLength: 5,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
              labelText: 'Taps',
              hintText: 'Escribe el valor inicial del contador',
              hintStyle: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.deepPurple,
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                    width: 4.0,
                  )),
              prefix: Icon(Icons.account_circle),
              helperText: 'Aqui debes escribir un número')),
    );
  }

  SizedBox espacio(double alto) {
    return SizedBox(height: alto);
  }

  Row botones(int counter) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(
          onPressed: decrementar,
          foregroundColor: const Color.fromARGB(255, 225, 255, 0),
          backgroundColor: const Color.fromARGB(255, 17, 0, 255),
          child: const Icon(Icons.exposure_minus_1),
        ),
        FloatingActionButton(
          onPressed: reinicio,
          foregroundColor: const Color.fromARGB(255, 17, 0, 255),
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          child: const Icon(Icons.exposure_zero),
        ),
        FloatingActionButton(
          onPressed: incrementar,
          foregroundColor: const Color.fromARGB(255, 255, 7, 7),
          backgroundColor: const Color.fromARGB(255, 255, 255, 0),
          child: const Icon(Icons.exposure_plus_1),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

class VentanaPrincipal extends StatelessWidget {
  const VentanaPrincipal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Primera App'),
      ),
      body: Center(
        child: Column(
          children: [
            espacio(),
            const Text('Juan',
                style: TextStyle(
                    fontSize: 20.0, color: Color.fromARGB(255, 255, 0, 2))),
            const Text('Marco'),
            const Text('Antony'),
            const Text('Alanmbre'),
          ],
        ),
      ),
    );
  }

  SizedBox espacio() {
    return const SizedBox(height: 30.0);
  }
}

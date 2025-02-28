import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/corral_model.dart';
import 'package:flutter_application_3/services/mongo_service.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class InsertCorralScreen extends StatefulWidget {
  const InsertCorralScreen({super.key});

  @override
  State<InsertCorralScreen> createState() => _InsertCorralScreenState();
}

class _InsertCorralScreenState extends State<InsertCorralScreen> {
  late TextEditingController _corralController;
  late TextEditingController _porcentajeController;
  late TextEditingController _alimentoController;
  late TextEditingController _cerdosController;

  @override
  void initState() {
    super.initState();
    _corralController = TextEditingController();
    _porcentajeController = TextEditingController();
    _alimentoController = TextEditingController();
    _cerdosController = TextEditingController();
  }

  void dispose() {
    _corralController.dispose();
    _porcentajeController.dispose();
    _alimentoController.dispose();
    _cerdosController.dispose();
    super.dispose();
  }

  void _insertCorral() async {
    var corral = CorralModel(
      id: mongo.ObjectId(),
      corral: int.parse(_corralController.text),
      porcentaje: double.parse(_porcentajeController.text),
      alimento: _alimentoController.text,
      cerdos: _cerdosController.text,
    );
    await MongoService().insertCorral(corral);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insertar nuevo Corral'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _corralController,
              decoration: const InputDecoration(labelText: 'Corral'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _porcentajeController,
              decoration:
                  const InputDecoration(labelText: 'Porcentaje de Alimento'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _alimentoController,
              decoration: const InputDecoration(labelText: 'Alimento'),
            ),
            TextField(
              controller: _cerdosController,
              decoration:
                  const InputDecoration(labelText: 'Estado de los Cerdos'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _insertCorral,
              child: const Text('Insertar'),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/corral_model.dart';
import 'package:flutter_application_3/services/mongo_service.dart';
import 'package:flutter_application_3/screens/insert_corral_screen.dart'; // Asegúrate de importar InsertCorralScreen
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class CorralScreen extends StatefulWidget {
  const CorralScreen({super.key});

  @override
  State<CorralScreen> createState() => _CorralScreenState();
}

class _CorralScreenState extends State<CorralScreen> {
  List<CorralModel> corrales = [];
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
    _fetchCorrales();
  }

  @override
  void dispose() {
    _corralController.dispose();
    _porcentajeController.dispose();
    _alimentoController.dispose();
    _cerdosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario de Corrales'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () async {
                // Navegar a la pantalla de inserción de corral
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const InsertCorralScreen(),
                  ),
                );
                // Actualizar la lista de corrales después de regresar de la pantalla de inserción
                _fetchCorrales();
              },
              child: const Icon(
                Icons.add,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: corrales.length,
        itemBuilder: (context, index) {
          var corral = corrales[index];
          return oneTitle(corral);
        },
      ),
    );
  }

  void _fetchCorrales() async {
    corrales = await MongoService().getCorrales();
    print('En fetch $corrales');
    setState(() {});
  }

  void _deleteCorral(mongo.ObjectId id) async {
    await MongoService().deleteCorral(id);
    _fetchCorrales();
  }

  void _updateCorral(CorralModel corral) async {
    await MongoService().updateCorral(corral);
    _fetchCorrales();
  }

  void _showEditDialog(CorralModel corral) {
    _corralController.text = corral.corral.toString();
    _porcentajeController.text = corral.porcentaje.toString();
    _alimentoController.text = corral.alimento;
    _cerdosController.text = corral.cerdos;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Corral'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
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
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                corral.corral = int.parse(_corralController.text);
                corral.porcentaje = double.parse(_porcentajeController.text);
                corral.alimento = _alimentoController.text;
                corral.cerdos = _cerdosController.text;
                _updateCorral(corral);
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  ListTile oneTitle(CorralModel corral) {
    return ListTile(
      leading: const Icon(Icons.house),
      title: Text(
        'Corral ${corral.corral}',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Porcentaje: ${corral.porcentaje}%'),
          Text('Alimento: ${corral.alimento}'),
          Text('Cerdos: ${corral.cerdos}'),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => _showEditDialog(corral),
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              _deleteCorral(corral.id);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}

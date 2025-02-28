import 'dart:io';
import 'package:flutter_application_3/models/corral_model.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class MongoService {
  //servicio para conectar con mongodb atlas
  //usando singleton
  static final MongoService _instance = MongoService._internal();

  MongoService._internal();

  factory MongoService() {
    return _instance;
  }

  late mongo.Db _db;

  Future<void> connect() async {
    try {
      _db = await mongo.Db.create(
          'mongodb+srv://xsantiagodospuntosuvex:integradora12345@integradora.daarp.mongodb.net/?retryWrites=true&w=majority&appName=Integradora');
      await _db.open();
      _db.databaseName = 'productos';
      print('Conectado a la base de datos');
    } on SocketException catch (e) {
      print('Error de conexión a la base de datos: $e');
      rethrow;
    }
  }

  mongo.Db get db {
    if (!_db.isConnected) {
      throw StateError(
          'Base de datos no inicializa, llama a connect() primero');
    }
    return _db;
  }

  // Obtener todos los corrales
  Future<List<CorralModel>> getCorrales() async {
    final collection = _db.collection('corrales');
    print('Colección obtenida: $collection');
    var corrales = await collection.find().toList();
    print('En MongoService: $corrales');
    if (corrales.isEmpty) {
      print('No se encontraron datos en la colección.');
    }
    return corrales.map((corral) => CorralModel.fromJson(corral)).toList();
  }

  // Insertar un nuevo corral
  Future<void> insertCorral(CorralModel corral) async {
    final collection = _db.collection('corrales');
    await collection.insertOne(corral.toJson());
  }

  // Actualizar un corral existente
  Future<void> updateCorral(CorralModel corral) async {
    final collection = _db.collection('corrales');
    await collection.updateOne(
        mongo.where.eq('_id', corral.id),
        mongo.modify
            .set('corral', corral.corral)
            .set('porcentaje', corral.porcentaje)
            .set('alimento', corral.alimento)
            .set('cerdos', corral.cerdos));
  }

  // Eliminar un corral por su ID
  Future<void> deleteCorral(mongo.ObjectId id) async {
    var collection = _db.collection('corrales');
    await collection.remove(mongo.where.eq('_id', id));
  }
}

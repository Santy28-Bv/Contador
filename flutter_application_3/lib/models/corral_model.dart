import 'package:mongo_dart/mongo_dart.dart' as mongo;

class CorralModel {
  final mongo.ObjectId id;
  int corral;
  double porcentaje;
  String alimento;
  String cerdos;

  CorralModel({
    required this.id,
    required this.corral,
    required this.porcentaje,
    required this.alimento,
    required this.cerdos,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'corral': corral,
      'porcentaje': porcentaje,
      'alimento': alimento,
      'cerdos': cerdos
    };
  }

  factory CorralModel.fromJson(Map<String, dynamic> json) {
    var id = json['_id'];
    if (id is String) {
      try {
        id = mongo.ObjectId.fromHexString(id);
      } catch (e) {
        id = mongo.ObjectId();
      }
    } else if (id is! mongo.ObjectId) {
      id = mongo.ObjectId();
    }
    return CorralModel(
      id: id as mongo.ObjectId,
      corral: json['corral'] as int,
      porcentaje: (json['porcentaje'] as num).toDouble(),
      alimento: json['alimento'] as String,
      cerdos: json['cerdos'] as String,
    );
  }
}

import 'package:hive_flutter/hive_flutter.dart';
part 'catogory_model.g.dart';

@HiveType(typeId: 2)
enum CatogoryType {
  @HiveField(0)
  income,
  @HiveField(1)
  expence,
}

@HiveType(typeId: 1)
class CatogoryModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final bool isDeleted;

  @HiveField(3)
  final CatogoryType type;

  CatogoryModel({
    required this.id,
    required this.name,
    required this.type,
    this.isDeleted = false,
  });
  @override
  String toString() {
    return '${name} ${type}';
  }
}

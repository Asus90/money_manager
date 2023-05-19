import 'package:hive_flutter/hive_flutter.dart';
import 'package:money/Models/Catogory/catogory_model.dart';
import 'package:money/db_functions/catogory/catogory_db.dart';
part 'Transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  final String Purpose;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final CatogoryType type;

  @HiveField(4)
  final CatogoryModel category;
  
  @HiveField(5)
  String? Id;

  TransactionModel(
      {required this.Purpose,
      required this.amount,
      required this.date,
      required this.type,
      required this.category}) {
    Id = DateTime.now().microsecondsSinceEpoch.toString();
  }
}

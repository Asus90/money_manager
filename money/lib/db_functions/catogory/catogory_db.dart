import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money/Models/Catogory/catogory_model.dart';

const CATOGORY_DB_NAME = 'catogory_database';

abstract class CatogoryDbfunctions {
  Future<List<CatogoryModel>> getcatogories();
  Future<void> insertCatogory(CatogoryModel values);
  Future<void> deleteCatogory(String catogoryID);
}

class catogoryDb implements CatogoryDbfunctions {
  catogoryDb._intenal();
  static catogoryDb instence = catogoryDb._intenal();

  factory catogoryDb() {
    return instence;
  }

  ValueNotifier<List<CatogoryModel>> incomeCatogoryListener = ValueNotifier([]);
  ValueNotifier<List<CatogoryModel>> expenceCatogoryListener = ValueNotifier([]);

  get db => null;

  @override
  Future<void> insertCatogory(CatogoryModel values) async {
    final _catogoryDB = await Hive.openBox<CatogoryModel>(CATOGORY_DB_NAME);
    await _catogoryDB.put(values.id, values);
    RefreshUI();
  }

  @override
  Future<List<CatogoryModel>> getcatogories() async {
    final _catogoryDB = await Hive.openBox<CatogoryModel>(CATOGORY_DB_NAME);
    return _catogoryDB.values.toList();
  }

  Future<void> RefreshUI() async {   
    final _allCatogory = await getcatogories();
    incomeCatogoryListener.value.clear();
    expenceCatogoryListener.value.clear();

    await Future.forEach(_allCatogory, (CatogoryModel catogory) {
      if (catogory.type == CatogoryType.income) {
        incomeCatogoryListener.value.add(catogory);
      } else {
        expenceCatogoryListener.value.add(catogory);
      }
    });
    incomeCatogoryListener.notifyListeners();
    expenceCatogoryListener.notifyListeners();
  }

  @override
  Future<void> deleteCatogory(String catogoryID) async {
    final _catogory = await Hive.openBox<CatogoryModel>(CATOGORY_DB_NAME);
    await _catogory.delete(catogoryID);
    RefreshUI();
  }
}

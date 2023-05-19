import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../Models/Catogory/catogory_model.dart';
import '../../db_functions/catogory/catogory_db.dart';

class IncomeCatogoryList extends StatelessWidget {
  const IncomeCatogoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: catogoryDb().incomeCatogoryListener,
        builder: (BuildContext ctx, List<CatogoryModel> newList, Widget? _) {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final catogory = newList[index];
                return Card(
                  child: ListTile(
                    leading: Text(catogory.name),
                    trailing: IconButton(
                        onPressed: () {
                          catogoryDb.instence.deleteCatogory(catogory.id);
                        },
                        icon: Icon(Icons.delete)),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: newList.length);
        });
  }
}

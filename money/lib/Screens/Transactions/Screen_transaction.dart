import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:money/Screens/Home/Widgets/Bottom_navigation.dart';
import 'package:money/db_functions/Transactions/Transaction_db.dart';
import 'package:money/Models/Catogory/catogory_model.dart';
import 'package:money/db_functions/catogory/catogory_db.dart';
import '../../Models/Transaction/Transaction_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refreshUI();
    catogoryDb.instence.RefreshUI();

    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotofire,
      builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: newList.length,
          itemBuilder: (ctx, index) {
            final _value = newList[index];
            return Slidable(
              key: Key(_value.Id!),
              startActionPane: ActionPane(motion: ScrollMotion(), children: [
                SlidableAction(
                  onPressed: (cxt) {
                    TransactionDB.instance.deleteTransaction(_value.Id!);
                  },
                  icon: Icons.delete,
                  label: 'delete',
                )
              ]),
              child: Card(
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      parseDate(_value.date),
                      textAlign: TextAlign.center,
                    ),
                    radius: 50,
                    backgroundColor: _value.type == CatogoryType.income
                        ? Colors.green
                        : Colors.red,
                  ),
                  title: Text('RS ${_value.amount}'),
                  subtitle: Text(_value.category.name),
                ),
              ),
            );
          },
        );
      },
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDte = _date.split(' ');

    return '${_splitedDte.last}\n${_splitedDte.first}';
  }
}

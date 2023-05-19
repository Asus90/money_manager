import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:money/Models/Catogory/catogory_model.dart';
import 'package:money/Screens/Catogory/Catogory_popup.dart';
import 'package:money/Screens/Home/Widgets/Bottom_navigation.dart';
import 'package:money/Screens/Transactions/Screen_transaction.dart';
import 'package:money/Screens/Catogory/Screen_catogory.dart';
import 'package:money/db_functions/catogory/catogory_db.dart';
import 'package:money/Screens/Add_transactions/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  static ValueNotifier<int> selectedIndexNotifire = ValueNotifier(0);
  final _pages = const [ScreenTransaction(), ScreenCatogory()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Momey Managment"),
        centerTitle: true,
      ),
      bottomNavigationBar: MoneymanagmentBottomnavigation(),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: selectedIndexNotifire,
        builder: (BuildContext context, int newUpdatedIndex, _) {
          print("$newUpdatedIndex pages");
          return _pages[newUpdatedIndex];
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifire.value == 0) {
            Navigator.of(context).pushNamed(screenAddtransaction.routName);
            print("Add trassaction");
          } else {
            print("add catogory");
            showCatogoryAddPopUp(context);

            // final sample = CatogoryModel(
            //     id: DateTime.now().millisecondsSinceEpoch.toString(),
            //     name: 'travel',
            //     type: CatogoryType.expence);
            // catogoryDb().insertCatogory(sample);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

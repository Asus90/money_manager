import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money/Models/Catogory/catogory_model.dart';
import 'package:money/Models/Transaction/Transaction_model.dart';
import 'package:money/Screens/Add_transactions/screen_transaction.dart';

import 'package:money/Screens/Home/Screen_home.dart';
import 'package:money/Screens/Transactions/Screen_transaction.dart';
import 'package:money/db_functions/catogory/catogory_db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CatogoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CatogoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CatogoryModelAdapter().typeId)) {
    Hive.registerAdapter(CatogoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const ScreenHome(),
      routes: {
        screenAddtransaction.routName: (ctx) => const screenAddtransaction(),
      },
    );
  }
}

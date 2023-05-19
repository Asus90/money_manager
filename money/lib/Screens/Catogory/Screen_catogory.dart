import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:money/db_functions/catogory/catogory_db.dart';

import 'Income_catogory.dart';
import 'exoence_catogory.dart';

class ScreenCatogory extends StatefulWidget {
  const ScreenCatogory({super.key});

  @override
  State<ScreenCatogory> createState() => _ScreenCatogoryState();
}

class _ScreenCatogoryState extends State<ScreenCatogory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    catogoryDb(). RefreshUI();
    print("got it");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(
                text: 'INCOME',
              ),
              Tab(
                text: "EXPENSE",
              ),
            ]),
        Expanded(
          child: TabBarView(
              controller: _tabController,
              children: [IncomeCatogoryList(), expenceCatogoryList()]),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:money/Screens/Home/Screen_home.dart';

class MoneymanagmentBottomnavigation extends StatelessWidget {
  const MoneymanagmentBottomnavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifire,
      builder: (BuildContext ctx, int UpdatedInx, Widget? _) {
        print("$UpdatedInx  bar");
        return BottomNavigationBar(
            selectedItemColor: Colors.purple,
            unselectedItemColor: Colors.grey,
            currentIndex: UpdatedInx,
            onTap: (Newindex) {
              ScreenHome.selectedIndexNotifire.value = Newindex;
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: "catogory")
            ]);
      },
    );
  }
} 
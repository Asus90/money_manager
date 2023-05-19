import 'package:flutter/material.dart';
import 'package:money/Models/Catogory/catogory_model.dart';
import 'package:money/db_functions/catogory/catogory_db.dart';

ValueNotifier<CatogoryType> selectedCatogoryNotifire =
    ValueNotifier(CatogoryType.expence);

Future<void> showCatogoryAddPopUp(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text('Add catogory'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameEditingController,
                decoration: const InputDecoration(
                  hintText: 'Add Catogory',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    RaidoButton(title: 'Income', type: CatogoryType.income),
                    RaidoButton(title: 'Expence', type: CatogoryType.expence)
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    final _name = _nameEditingController.text;

                    if (_name.isEmpty) {
                      return;
                    }

                    final _type = selectedCatogoryNotifire.value;

                    final _catogory = CatogoryModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: _name,
                        type: _type);
                    catogoryDb.instence.insertCatogory(_catogory);
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Add')),
            )
          ],
        );
      });
}

class RaidoButton extends StatelessWidget {
  final String title;
  final CatogoryType type;

  const RaidoButton({required this.title, required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCatogoryNotifire,
            builder: (BuildContext ctx, CatogoryType newCatogory, Widget_) {
              return Radio<CatogoryType>(
                  value: type,
                  groupValue: newCatogory,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    print(value);
                    selectedCatogoryNotifire.value = value;
                    selectedCatogoryNotifire.notifyListeners();
                  });
            }),
        Text(title),
      ],
    );
  }
}

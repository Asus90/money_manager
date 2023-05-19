import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:money/Models/Catogory/catogory_model.dart';
import 'package:money/Models/Catogory/catogory_model.dart';
import 'package:money/Models/Transaction/Transaction_model.dart';
import 'package:money/db_functions/Transactions/Transaction_db.dart';
import 'package:money/db_functions/catogory/catogory_db.dart';

class screenAddtransaction extends StatefulWidget {
  static const routName = 'Add_transaction';
  const screenAddtransaction({super.key});

  @override
  State<screenAddtransaction> createState() => _screenAddtransactionState();
}

class _screenAddtransactionState extends State<screenAddtransaction> {
  final _perposeTextEditingcontroller = TextEditingController();
  final _AmountTextEditingcontroller = TextEditingController();

  DateTime? _selectedDate;
  CatogoryType? _selectedCatogoryType;
  CatogoryModel? _selectedCtogoryModel;
  String? _catogoryID;
  final _TexteditingController = TextEditingController();
  final _AmontRditingController = TextEditingController();

  @override
  void initState() {
    _selectedCatogoryType = CatogoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _perposeTextEditingcontroller,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(hintText: 'Purpose'),
            ),
            TextFormField(
              controller: _AmountTextEditingcontroller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Amount'),
            ),
            TextButton.icon(
                onPressed: () async {
                  final _setectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 30)),
                    lastDate: DateTime.now(),
                  );
                  if (_setectedDateTemp == null) {
                    return;
                  } else {
                    print(_setectedDateTemp.toString());
                    setState(() {
                      _selectedDate = _setectedDateTemp;
                    });
                  }
                },
                icon: Icon(Icons.calendar_today),
                label: Text(_selectedDate == null
                    ? 'Select Date'
                    : _selectedDate!.toString())),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                        value: CatogoryType.income,
                        groupValue: _selectedCatogoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCatogoryType = CatogoryType.income;
                            _catogoryID = null;
                          });
                        }),
                    Text('income')
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: CatogoryType.expence,
                        groupValue: _selectedCatogoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCatogoryType = CatogoryType.expence;
                            _catogoryID = null;
                          });
                        }),
                    Text('expence')
                  ],
                ),
              ],
            ),
            DropdownButton(
                hint: Text('Select catogory'),
                value: _catogoryID,
                items: (_selectedCatogoryType == CatogoryType.income
                        ? catogoryDb().incomeCatogoryListener
                        : catogoryDb().expenceCatogoryListener)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                    onTap: () {
                      _selectedCtogoryModel = e;
                      print(e);
                    },
                  );
                }).toList(),
                onChanged: (selectedValue) {
                  setState(() {
                    _catogoryID = selectedValue;
                    // print(_catogoryID);
                  });
                }),
            ElevatedButton(
                onPressed: () {
                  addTransactions();
                },
                child: Text('Submit'))
          ],
        ),
      )),
    );
  }

  Future<void> addTransactions() async {
    final _purpose = _perposeTextEditingcontroller.text;
    final _amount = _AmountTextEditingcontroller.text;
    if (_purpose.isEmpty ||
        _amount.isEmpty ||
        _selectedDate == null ||
        _selectedCtogoryModel == null) {
      return;
    }
    final _parsedAmount = double.tryParse(_amount);
    if (_parsedAmount == null) {
      return;
    }
    final _model = TransactionModel(
      Purpose: _purpose,
      amount: _parsedAmount,
      date: _selectedDate!,
      type: _selectedCatogoryType!,
      category: _selectedCtogoryModel!,
    );

    await TransactionDB.instance.addTransaction(_model);
    Navigator.of(context).pop();
    await TransactionDB.instance.refreshUI();
  }
}

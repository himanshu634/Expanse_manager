import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newtxfun;

  NewTransaction(this.newtxfun);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  DateTime _selectedDate;
  final _amountController = TextEditingController();

  void _onSubmit() {
    final _submitTitle = _titleController.text;
    final _submitAmount = double.parse(_amountController.text);
    if (_submitTitle.isEmpty || _submitAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.newtxfun(_submitTitle, _submitAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((_pickedDate) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: _titleController,
            onSubmitted: (_) => _onSubmit(),
            // onChanged: (val) {
            // titleInput = val;

            //},
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _onSubmit(),

            //onChanged: (val) => amountInput = val,
          ),
          Container(
            height: 80,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No date has selected'
                        : 'Picked Date : ${DateFormat.yMd().format(_selectedDate)}',
                  ),
                ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  onPressed: _presentDatePicker,
                  child: Text(
                    'Choose Date!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: _onSubmit,
            child: Text(
              'Add Transaction',
              style: Theme.of(context).textTheme.button,
            ),
          )
        ],
      ),
    );
  }
}

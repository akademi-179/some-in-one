import 'package:flutter/material.dart';
import 'package:some_in_one/models/expense.dart';

List<Widget> buildExpenses(BuildContext context, List<Expense> expenses) {
  List<Widget> expenseItems = [];
  for (int i = 0; i < expenses.length; i++) {
    expenseItems.add(
        Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(expenses[i].type),
                Text(expenses[i].date.toString().substring(0, 11)),
                Text("${expenses[i].cost}")
              ],
            ),
          ),
        ));
  }

  return expenseItems;
}
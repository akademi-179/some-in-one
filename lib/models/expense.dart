import 'dart:convert';

Expense expenseFromJson(String str) => Expense.fromJson(json.decode(str));

String expenseToJson(Expense data) => json.encode(data.toJson());

class Expense {
  Expense({
    required this.date,
    required this.cost,
    required this.type,
    this.referenceId,
  });

  String date;
  double cost;
  String type;
  String? referenceId;

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
    date: json["date"],
    cost: json["cost"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "cost": cost,
    "type": type,
  };
}

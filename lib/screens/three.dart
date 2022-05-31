import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:some_in_one/models/expense.dart';
import 'package:some_in_one/widgets/expense_tracker/build_expenses.dart';
import 'package:some_in_one/widgets/expense_tracker/chart_data.dart';
import 'package:some_in_one/widgets/expense_tracker/chart_labels.dart';

class Three extends StatefulWidget {
  const Three({Key? key}) : super(key: key);

  @override
  State<Three> createState() => _ThreeState();
}

class _ThreeState extends State<Three> {
  final myController = TextEditingController();

  int touchedIndex = -1;
  double masraf = 0,
      gida = 0,
      ulasim = 0,
      fatura = 0,
      abonelik = 0,
      diger = 0;
  String dropdownValue = 'Gıda';
  List<Expense> expensesList = [];
  String now = "";

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getExpenses();
  }

  Future<void> getExpenses() async {
    CollectionReference expensesCollection =
    FirebaseFirestore.instance.collection('expenses');
    QuerySnapshot querySnapshot = await expensesCollection.get();

    final allExpenses = querySnapshot.docs.map((doc) =>
        Expense(date: doc.get('date'),
            cost: doc.get('cost').toDouble(),
            type: doc.get('type'))
    ).toList();

    setState(() {
      expensesList = allExpenses;
    });

    for(var expense in allExpenses){
      switch (expense.type) {
        case 'Gıda':
          setState(() => gida += expense.cost);
          break;
        case 'Ulaşım':
          setState(() => ulasim += expense.cost);
          break;
        case 'Faturalar':
          setState(() => fatura += expense.cost);
          break;
        case 'Abonelikler':
          setState(() => abonelik += expense.cost);
          break;
        case 'Diğer':
          setState(() => diger += expense.cost);
          break;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    CollectionReference expensesCollection =
    FirebaseFirestore.instance.collection('expenses');

    Future<void> addExpense() {
      // Call the user's CollectionReference to add a new user
      return expensesCollection.add({
        'date': now, // John Doe
        'cost': masraf, // Stokes and Sons
        'type': dropdownValue // 42
      }).then((value) {
        showDialog(
            context: context,
            builder: (context) {
              Future.delayed(Duration(seconds: 1), () {
                Navigator.of(context).pop(true);
              });
              return AlertDialog(
                title: Text('${dropdownValue}: ${masraf}₺'),
              );
            });
      }).catchError((error) => print("Failed to add expense: $error"));
    }


    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text("Expense Tracker"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: Colors.indigo,
              elevation: 0,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 2,
                      child: PieChart(
                        PieChartData(
                            pieTouchData: PieTouchData(touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            }),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 30,
                            sections: showingSections(touchedIndex, gida,
                                ulasim, fatura, abonelik, diger)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            chartLabels(context, gida, ulasim, fatura, abonelik, diger),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: myController,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        labelText: "Miktar ₺",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelStyle: TextStyle(color: Colors.white)),
                    maxLength: 8,
                    style: const TextStyle(color: Colors.white),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  color: Colors.indigo,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      value: dropdownValue,
                      elevation: 16,
                      icon: const Icon(Icons.arrow_drop_down_circle_sharp,
                          color: Colors.white),
                      dropdownColor: Colors.indigo,
                      style: const TextStyle(color: Colors.white),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>[
                        'Gıda',
                        'Ulaşım',
                        'Faturalar',
                        'Abonelikler',
                        'Diğer'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (myController.text.isNotEmpty) {
                      setState(() {
                        masraf = (myController.text == "")
                            ? 0
                            : double.parse(myController.text);
                        switch (dropdownValue) {
                          case 'Gıda':
                            gida += masraf;
                            break;
                          case 'Ulaşım':
                            ulasim += masraf;
                            break;
                          case "Faturalar":
                            fatura += masraf;
                            break;
                          case "Abonelikler":
                            abonelik += masraf;
                            break;
                          case "Diğer":
                            diger += masraf;
                            break;
                        }
                        now = DateTime(DateTime
                            .now()
                            .year,
                            DateTime
                                .now()
                                .month, DateTime
                                .now()
                                .day)
                            .toString();

                        Expense occuredExpense = Expense(
                            date: now, cost: masraf, type: dropdownValue);

                        expensesList.add(occuredExpense);

                        addExpense();

                        showingSections(touchedIndex, gida, ulasim, fatura,
                            abonelik, diger);
                      });
                    }
                  },
                  child: Text("Ekle"),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 3,
              child: Scrollbar(
                thickness: 8,
                child: SingleChildScrollView(
                  child: Column(
                    children: buildExpenses(context, expensesList),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

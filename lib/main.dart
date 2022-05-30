import 'package:flutter/material.dart';
import 'package:some_in_one/constants/routes.dart';
import 'package:some_in_one/screens/four.dart';
import 'screens/main_screen.dart';
import 'package:some_in_one/screens/three.dart';
import 'package:some_in_one/screens/two.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swiss App',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: Routes.routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Swiss App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/one');
                },
                child: const Text("First App")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/two');
                },
                child: const Text("Second App")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/three');
                },
                child: const Text("Third App")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/four');
                },
                child: const Text("Fourth App")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/five');
                },
                child: const Text("Fifth App")),
          ],
        ),
      ),
    );
  }
}

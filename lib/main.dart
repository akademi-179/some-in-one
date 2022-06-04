import 'package:flutter/material.dart';
import 'package:some_in_one/constants/routes.dart';
import 'screens/pomodoro_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  MyApp({Key? key}) : super(key: key);

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
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('You have an error! ${snapshot.error.toString()}');
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            return const MyHomePage(
              title: 'Swiss App',
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
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
                  Navigator.pushNamed(context, '/pomodoro');
                },
                child: const Text("Pomodoro")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/calculator');
                },
                child: const Text("Calculator")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/expense_tracker');
                },
                child: const Text("Expense Tracker")),
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

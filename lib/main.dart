import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'mainpage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAxWH7JUNjqxSVk0ZFXheEqH_TNro5rsnE",
          appId: "1:1084534148026:web:89ab74308b7e9eb5be2b83",
          messagingSenderId: "1084534148026",
        databaseURL: "https://pharmacy-app-decf9-default-rtdb.firebaseio.com",
        projectId: "pharmacy-app-decf9",));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent)
            .copyWith(background: Color(0xFFeae5fe)),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double progressvalue = 0.2;
  @override
  void initState() {
    progress();
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
                fullscreenDialog: true, builder: (context) => Next())));
  }

  void progress() {
    Timer(
      const Duration(seconds: 2),
      () => progressvalue = 0.9,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const SizedBox(
        height: 80,
      ),
      Image.network(
        "images/splash.png",
        width: 300,
      ),
      const SizedBox(
        height: 50,
      ),
      Container(
        //Progressbar
        margin: const EdgeInsets.symmetric(vertical: 20),
        width: 300,
        height: 7,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: LinearProgressIndicator(
            value: progressvalue,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xffa984fe)),
            backgroundColor: const Color(0xffD6D6D6),
          ),
        ),
      )
    ])));
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pref/provider.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cont = context.watch<myProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Result Screen"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "User name = ${cont.myname!.isNotEmpty ? cont.myname : 'no name'}"),
            Text("times app opened = ${cont.mycounter}"),
          ],
        ),
      ),
    );
  }
}

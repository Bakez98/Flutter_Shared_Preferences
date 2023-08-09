import 'package:flutter/material.dart';
import 'package:shared_pref/provider.dart';
import 'package:shared_pref/result.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => myProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Shared Pref'),
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();

  void _submit() {
    final theProvider = Provider.of<myProvider>(context, listen: false);
    theProvider.setNameFromform(_userNameController.text);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("my app init state");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<myProvider>().initMyController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Center(
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _userNameController,
                      decoration: InputDecoration(
                        label: Text("Name"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    ElevatedButton(
                      onPressed: _submit,
                      child: const Text("Submit"),
                    )
                  ],
                ))),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            heroTag: "mh2",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ResultScreen()),
              );
            },
            // tooltip: 'Increment',
            child: const Icon(Icons.arrow_right),
          ),
          FloatingActionButton(
            heroTag: "mh1",
            onPressed: () {
              context.read<myProvider>().setFirstOpenerVals();
            },
            // tooltip: 'Increment',
            child: const Icon(Icons.restore),
          ),
        ],
      ),
    );
  }
}

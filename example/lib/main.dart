import 'package:flutter/material.dart';
import 'package:state_illustrator/state_illustrator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StateIllustrator Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'StateIllustrator Demo'),
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
  ViewState _state = ViewState.loading;

  void _setState(ViewState newState) {
    setState(() {
      _state = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          // Expanded to fill screen with StateIllustrator
          Expanded(
            child: StateIllustrator(
              state: _state,
              onRetry: () => _setState(ViewState.loading),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Data Loaded Successfully!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Buttons to switch states
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _setState(ViewState.loading),
                  child: const Text('Loading'),
                ),
                ElevatedButton(
                  onPressed: () => _setState(ViewState.empty),
                  child: const Text('Empty'),
                ),
                ElevatedButton(
                  onPressed: () => _setState(ViewState.error),
                  child: const Text('Error'),
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
        ],
      ),
    );
  }
}

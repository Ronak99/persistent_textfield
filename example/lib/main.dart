import 'package:flutter/material.dart';
import 'package:persistent_textfield/persistent_textfield.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Basic Persistent Field'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PersistentTextField(
              persistenceId: 'user_notes',
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Notes',
                hintText: 'Enter your notes here',
              ),
              onPersist: (value) {
                print('Text persisted: $value');
              },
            ),
            TextButton(
              onPressed: () {
                PersistentTextField.resetPersistedValue('user_notes');
                controller.clear();
              },
              child: const Text("Clear Field"),
            ),
          ],
        ),
      ),
    );
  }
}

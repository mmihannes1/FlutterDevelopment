/*
 * A Simple ToDo List App
 * Created by: Hannes Lundberg
 */

import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ToDo List'),
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
  final List<String> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _taskController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'What do you need to get done?'),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (_taskController.text.isEmpty) {
                  return;
                }
                setState(() {
                  _tasks.add(_taskController.text);
                  _taskController.clear();
                });
              },
              child: const Text('Add the task'),
            )),
        Expanded(
          child: ListView.builder(
            itemCount: _tasks.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _taskController.text = _tasks[index];
                    _tasks.removeAt(index);
                  });
                },
                child: ListTile(
                  title: Text(_tasks[index]),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}

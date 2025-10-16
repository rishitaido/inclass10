import 'package:flutter/material.dart';
import 'services/database_helper.dart';

// Here we are using a global variable. 
// In production apps, you might use something like get_it instead.
final dbHelper = DatabaseHelper();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize the database
  await dbHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sqflite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _insert,
              child: const Text('insert'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _query,
              child: const Text('query'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _update,
              child: const Text('update'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _delete,
              child: const Text('delete'),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: _queryByID, 
              child: const Text('Query by ID')
              ),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: onPressed, child: child)
          ],
        ),
      ),
    );
  }
  // Button Methods
  void _insert() async {
    Map<String, dynamic> row = {
        DatabaseHelper.columnName: 'Bob', 
        DatabaseHelper.columnAge: 23
    };
    final id = await dbHelper.insert(row);
    debugPrint('Inserted row ID: $id');
  }
  
  void _query() async{ 
    final allRows = await dbHelper.queryAllRows();
    debugPrint('query all rows'); 
    for (final row in allRows){
      debugPrint(row.toString());
    }
  }

  void _update() async {
    Map<String,dynamic> row = {
      DatabaseHelper.columnId: 1,
      DatabaseHelper.columnName: "Mary", 
      DatabaseHelper.columnAge: 32,
    }; 
    final rowsAffected = await dbHelper.update(row); 
    debugPrint('updated $rowsAffected row(s)'); 
  }

  void _delete() async{
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id); 
    debugPrint('deleted $rowsDeleted row(s): row $id'); 

  }
}
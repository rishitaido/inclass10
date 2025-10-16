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
      DatabaseHelper.columnId: 4,
      DatabaseHelper.columnName: "John", 
      DatabaseHelper.columnAge: 10,
    }; 
    final rowsAffected = await dbHelper.update(row); 
    debugPrint('updated $rowsAffected row(s)'); 
  }

  void _delete() async{
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id); 
    debugPrint('deleted $rowsDeleted row(s): row $id'); 

  }
  void _queryByID() async{
    const id = 5;
    final row = await dbHelper.queryByID(id); 
    if (row != null){
      debugPrint('Found row: $row'); 
    }else {
      debugPrint('No record found for ID $id');
    }
  }

  void _deleteAll() async{
    final rowsDeleted = await dbHelper.deleteAll(); 
    debugPrint('Deleted $rowsDeleted rows');
  }

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('sqflite'),
      ),
      backgroundColor: const Color.fromARGB(255, 59, 0, 43),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _insert,
              child: const Text('Insert'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _query,
              child: const Text('Query'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _update,
              child: const Text('Update'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _delete,
              child: const Text('Delete'),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: _queryByID, 
              child: const Text('Query by ID')
              ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: _deleteAll, 
              child: const Text("Delete All")
              )
          ],
        ),
      ),
    );
  }

}
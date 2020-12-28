import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataService {
  Future<Database> _database;
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  dataService() async {
  WidgetsFlutterBinding.ensureInitialized();
  _database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'wallet_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      return db.execute(
        """CREATE TABLE transactions
        (
        id INTEGER PRIMARY KEY,
        title TEXT,
        time TEXT,
        amount INTEGER,
        isIncome INTEGER
        )
        """,
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );
  }
  // Open the database and store the reference.

  Future<void> insertTransaction(Transaction transaction) async {
    // Get a reference to the database.
    final Database db = await _database;

    // Insert the transaction into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same transaction is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Transaction>> transactions() async {
    // Get a reference to the database.
    final Database db = await _database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('transactions');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Transaction(
        id: maps[i]['id'],
        title: maps[i]['title'],
        time: maps[i]['time'],
        amount: maps[i]['amount'],
        isIncome: maps[i]['isIncome'],
      );
    });
  }

  Future<void> updateTransaction(Transaction transaction) async {
    // Get a reference to the database.
    final db = await _database;

    // Update the given Dog.
    await db.update(
      'transactions',
      transaction.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [transaction.id],
    );
  }

  Future<void> deleteTransaction(int id) async {
    // Get a reference to the database.
    final db = await _database;

    // Remove the Dog from the database.
    await db.delete(
      'transactions',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}

class Transaction {
  final int id;
  final String title;
  final String time;
  final int amount;
  final int isIncome;

  Transaction({this.id,this.title, this.time, this.amount, this.isIncome, });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'time': time,
      'amount': amount,
      'isIncome': isIncome,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Transaction{id: $id, title: $title, time: $time, amount: $amount, isIncome: $isIncome}';
  }
}
import 'package:contact_book/models/contact_model.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteHelper {
  static late Database database;
  static List<Map> contactsList = [];
  //create database
  static void createDatabase() async {
    await openDatabase(
      'contact.db',
      version: 1,
      onCreate: (database, version) async {
        print('database created');
        await database
            .execute(
                'CREATE TABLE contacts (id INTEGER PRIMARY KEY, name TEXT, phone TEXT, email TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
    });
  }

  //insert record
  static void insertToDatabase({
    required ContactModel contactModel,
  }) async {
    await database.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO contacts(name, phone, email) VALUES("${contactModel.name}", "${contactModel.phone}", "${contactModel.email}")')
          .then((value) {
        print('$value inserted successfully');
        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  //get record
  static void getDataFromDatabase(database) async {
    contactsList = [];
    await database.rawQuery('SELECT * FROM contacts').then((value) {
      value.forEach((element) {
        contactsList.add(element);
      });
    }).catchError((error) {
      print('Error When Getting Record ${error.toString()}');
    });
  }

  //update record
  static void updateData({
    required ContactModel contactModel,
  }) async {
    await database.rawUpdate(
      'UPDATE contacts SET name = ?, phone = ?, email = ? WHERE id = ?',
      [
        (contactModel.name),
        (contactModel.phone),
        (contactModel.email),
        contactModel.id
      ],
    ).then((value) {
      getDataFromDatabase(database);
    }).catchError((error) {
      print('Error When Updating Record ${error.toString()}');
    });
  }

  //delete record
  static void deleteData({
    required ContactModel contactModel,
  }) async {
    await database.rawDelete(
      'DELETE FROM contacts WHERE id = ?',
      [contactModel.id],
    ).then((value) {
      getDataFromDatabase(database);
    }).catchError((error) {
      print('Error When Deleting Record ${error.toString()}');
    });
  }
}

import 'package:contact_book/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitialState());
  static ContactCubit get(context) => BlocProvider.of(context);
  late Database database;
  List<Map> contactsList = [];

  //create database
  Future<void> createDatabase() async {
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
      emit(ContactCreateDatabaseState());
    });
  }

  //insert record
  Future<void> insertToDatabase({
    required ContactModel contactModel,
  }) async {
    await database.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO contacts(name, phone, email) VALUES("${contactModel.name}", "${contactModel.phone}", "${contactModel.email}")')
          .then((value) {
        print('$value inserted successfully');
        emit(ContactInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  //get record
  Future<void> getDataFromDatabase(database) async {
    contactsList = [];
    emit(ContactGetDatabaseLoadingState());
    await database.rawQuery('SELECT * FROM contacts').then((value) {
      value.forEach((element) {
        contactsList.add(element);
      });
      emit(ContactGetDatabaseState());
    }).catchError((error) {
      print('Error When Getting Record ${error.toString()}');
    });
  }

  //update record
  Future<void> updateData({
    required ContactModel contactModel,
  }) async {
    await database.rawUpdate(
      'UPDATE contacts SET name = ?, phone = ?, email = ? WHERE id = ?',
      [
        contactModel.name,
        contactModel.phone,
        contactModel.email,
        contactModel.id,
      ],
    ).then((value) {
      emit(ContactUpdateDatabaseState());
      getDataFromDatabase(database);
      print('$value updated successfully');
    }).catchError((error) {
      print('Error When Updating Record ${error.toString()}');
    });
  }

  //delete record
  Future<void> deleteData({
    required ContactModel contactModel,
  }) async {
    await database.rawDelete(
      'DELETE FROM contacts WHERE id = ?',
      [contactModel.id],
    ).then((value) {
      emit(ContactDeleteDatabaseState());
      getDataFromDatabase(database);
    }).catchError((error) {
      print('Error When Deleting Record ${error.toString()}');
    });
  }
}

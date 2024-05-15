part of 'contact_cubit.dart';

@immutable
abstract class ContactState {}

class ContactInitialState extends ContactState {}

class ContactCreateDatabaseState extends ContactState {}

class ContactGetDatabaseLoadingState extends ContactState {}

class ContactGetDatabaseState extends ContactState {}

class ContactInsertDatabaseState extends ContactState {}

class ContactUpdateDatabaseState extends ContactState {}

class ContactDeleteDatabaseState extends ContactState {}

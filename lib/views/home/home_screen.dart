import 'package:contact_book/models/contact_model.dart';
import 'package:contact_book/view_model/db_helper.dart';
import 'package:contact_book/views/add/add_screen.dart';
import 'package:contact_book/views/home/widgets/contacts_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SqfliteHelper.createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Column(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                SqfliteHelper.getDataFromDatabase(SqfliteHelper.database);
              });
            },
            icon: const Icon(Icons.refresh),
          ),
          Expanded(
            child: contactsBuilder(
                contacts: SqfliteHelper.contactsList
                    .map((element) => ContactModel(
                        id: element['id'],
                        name: element['name'],
                        phone: element['phone'],
                        email: element['email']))
                    .toList()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

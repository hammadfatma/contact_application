import 'package:contact_book/models/contact_model.dart';
import 'package:contact_book/view_model/cubit/contact_cubit.dart';
import 'package:contact_book/views/add/add_screen.dart';
import 'package:contact_book/views/home/widgets/contacts_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: BlocConsumer<ContactCubit, ContactState>(
        listener: (context, state) {
          if (state is ContactGetDatabaseLoadingState) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        builder: (context, state) {
          ContactCubit cubit = ContactCubit.get(context);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // this button was used to refresh list
              // IconButton(
              //   onPressed: () {
              //     cubit.getDataFromDatabase(cubit.database);
              //   },
              //   icon: const Icon(
              //     Icons.refresh,
              //     color: Colors.deepPurple,
              //   ),
              // ),
              Expanded(
                child: contactsBuilder(
                    contacts: cubit.contactsList
                        .map((element) => ContactModel(
                            id: element['id'],
                            name: element['name'],
                            phone: element['phone'],
                            email: element['email']))
                        .toList()),
              ),
            ],
          );
        },
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

// this method when i used setState as state management and this widget was stateful widget
// and all comments in code was related to the past condition
// @override
// void initState() {
//   super.initState();
//   SqfliteHelper.createDatabase();
// }
// this method was triggered when i clicked on refresh button
// setState(() {
//   SqfliteHelper.getDataFromDatabase(SqfliteHelper.database);
// });

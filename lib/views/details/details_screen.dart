import 'package:contact_book/models/contact_model.dart';
import 'package:contact_book/view_model/db_helper.dart';
import 'package:contact_book/views/edit/edit_screen.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.contactModel});
  final ContactModel contactModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120.0,
                  height: 120.0,
                  child: CircleAvatar(
                    child: Text(contactModel.name[0]),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Text('Name: '),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(contactModel.name),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const Text('Phone: '),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(contactModel.phone),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const Text('Email: '),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(contactModel.email),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.teal,
                          height: 45.0,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'EDIT',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.blue,
                          height: 45.0,
                          child: MaterialButton(
                            onPressed: () {
                              SqfliteHelper.deleteData(
                                  contactModel: contactModel);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'DELETE',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

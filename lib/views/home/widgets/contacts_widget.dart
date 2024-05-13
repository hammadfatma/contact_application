import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:contact_book/models/contact_model.dart';
import 'package:contact_book/view_model/db_helper.dart';
import 'package:contact_book/views/details/details_screen.dart';
import 'package:flutter/material.dart';

Widget buildContactItem(ContactModel model, context) => GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(contactModel: model),
          ),
        );
      },
      child: Dismissible(
        key: Key(model.id.toString()),
        onDismissed: (direction) {
          SqfliteHelper.deleteData(contactModel: model);
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40.0,
                child: Text(model.name[0].toUpperCase()),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      model.name,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      model.phone,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget contactsBuilder({required List<ContactModel> contacts}) =>
    ConditionalBuilder(
      condition: contacts.isNotEmpty,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) {
          return buildContactItem(contacts[index], context);
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 20.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          );
        },
        itemCount: contacts.length,
      ),
      fallback: (context) => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              'No Contacts Yet, Please Add Some Contacts',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );

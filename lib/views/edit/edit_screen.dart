import 'package:contact_book/models/contact_model.dart';
import 'package:contact_book/view_model/cubit/contact_cubit.dart';
import 'package:contact_book/views/add/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.id});
  final int id;
  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late GlobalKey<FormState> formKey;

  late TextEditingController nameController;

  late TextEditingController phoneController;

  late TextEditingController emailController;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Screen'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              defaultFormField(
                controller: nameController,
                type: TextInputType.name,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'name must not be empty';
                  }
                  return null;
                },
                label: 'Name',
                prefix: Icons.person,
              ),
              const SizedBox(
                height: 15.0,
              ),
              defaultFormField(
                controller: phoneController,
                type: TextInputType.phone,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'phone must not be empty';
                  }
                  if (value.length != 11) {
                    return 'phone number must be 11 numbers';
                  }
                  return null;
                },
                label: 'Phone',
                prefix: Icons.phone,
              ),
              const SizedBox(
                height: 15.0,
              ),
              defaultFormField(
                controller: emailController,
                type: TextInputType.emailAddress,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'email must not be empty';
                  }
                  if (!value.contains('@')) {
                    return 'Enter Valid Email';
                  }
                  return null;
                },
                label: 'Email',
                prefix: Icons.email,
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ContactModel model = ContactModel(
                        name: nameController.text,
                        phone: phoneController.text,
                        email: emailController.text,
                        id: widget.id,
                      );
                      BlocProvider.of<ContactCubit>(context)
                          .updateData(contactModel: model);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('SAVE'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

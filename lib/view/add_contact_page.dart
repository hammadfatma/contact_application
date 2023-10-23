import 'package:contacts_application/model/contact.dart';
import 'package:contacts_application/view_model/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController cName = TextEditingController();
    final TextEditingController cNickName = TextEditingController();
    final TextEditingController cWork = TextEditingController();
    final TextEditingController cPhoneNumber = TextEditingController();
    final TextEditingController cEmail = TextEditingController();
    final TextEditingController cWebSite = TextEditingController();

    return Consumer<AppViewModel>(builder: (context,viewModel,child){
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text("Criar novo contato"),
          actions: [
            SizedBox(
              width: 80,
              child: IconButton(
                onPressed: () {},
                icon: const Text(
                  'SALVAR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(
              height: 20,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120.0,
                  height: 120.0,
                  child: CircleAvatar(
                    child: Icon(
                      Icons.camera_alt,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    icon: Icon(Icons.person),
                  ),
                  keyboardType: TextInputType.text,
                  autofocus: true,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(45),
                  ],
                  controller: cName,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Apelido',
                    icon: Icon(Icons.person),
                  ),
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(25),
                  ],
                  controller: cNickName,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Trabalho',
                    icon: Icon(Icons.work),
                  ),
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(45),
                  ],
                  controller: cWork,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                    icon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  maxLength: 16,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(45),
                  ],
                  controller: cPhoneNumber,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    icon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                  controller: cEmail,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Site da Web',
                    icon: Icon(Icons.web),
                  ),
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                  controller: cWebSite,
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      String nam = cName.text;
                      String nkNam = cNickName.text;
                      String wk = cWork.text;
                      String phone = cPhoneNumber.text;
                      String mail = cEmail.text;
                      String web = cWebSite.text;
                      if (nam.isNotEmpty &&
                          nkNam.isNotEmpty &&
                          wk.isNotEmpty &&
                          phone.isNotEmpty &&
                          mail.isNotEmpty &&
                          web.isNotEmpty) {
                        Contact newCont = Contact(nam, nkNam, wk, phone, mail, web);

                        viewModel.addCont(newCont);

                        cName.clear();
                        cNickName.clear();
                        cWork.clear();
                        cPhoneNumber.clear();
                        cEmail.clear();
                        cWebSite.clear();
                      }
                      Navigator.of(context).pop();
                    },
                    child: const Text("Save"),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

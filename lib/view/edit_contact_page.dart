import 'package:contacts_application/view_model/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class EditContactPage extends StatelessWidget {
  final int inDex;
  const EditContactPage({super.key, required this.inDex});

  @override
  Widget build(BuildContext context) {
    final TextEditingController cName = TextEditingController();
    final TextEditingController cNickName = TextEditingController();
    final TextEditingController cWork = TextEditingController();

    return Consumer<AppViewModel>(builder: (context,viewModel,child){
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text("Editar contato"),
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
                      if (nam.isNotEmpty &&
                          nkNam.isNotEmpty &&
                          wk.isNotEmpty ) {
                        viewModel.updateName(inDex, nam);
                        viewModel.updateNickName(inDex, nkNam);
                        viewModel.updateWork(inDex, wk);
                        cName.clear();
                        cNickName.clear();
                        cWork.clear();
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


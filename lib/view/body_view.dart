import 'package:contacts_application/view_model/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit_contact_page.dart';

class BodyView extends StatelessWidget {
  const BodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          children: [
            viewModel.cont.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.list,
                        size: 120,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: Text(
                          'Sua lista de contatos está vazia',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "ADICIONAR CONTATO",
                          style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "SOBRE",
                          style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: viewModel.numCont,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            leading: CircleAvatar(
                              child: Text(
                                viewModel.getName(index)[0].toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 26, color: Colors.white60),
                              ),
                            ),
                            title: Text(
                              viewModel.getName(index),
                              style: const TextStyle(fontSize: 17),
                            ),
                            subtitle:
                                viewModel.getPhone(index).toString().isNotEmpty
                                    ? Text(viewModel.getPhone(index))
                                    : null,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditContactPage(inDex: index,),
                                      ),
                                    );
                                  },
                                  splashRadius: 24,
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    viewModel.deleteCont(index);
                                  },
                                  splashRadius: 24,
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        );
      },
    );
  }
}

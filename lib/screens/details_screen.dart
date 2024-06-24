import 'package:auto_control_panel/providers/tarefas_provider.dart';
import 'package:auto_control_panel/routes.dart';
import 'package:auto_control_panel_pk/auto_control_panel_pk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Recupera os argumentos passados
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Recupera a tarefa e o índice dos argumentos
    final Tarefas tarefa = args['tarefa'];
    final int index = args['index'];

    final tarefasProvider = context.watch<TarefasProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text("Detalhes Tarefas"),
        actions: [
          IconButton(
              onPressed: () {
                //tarefasProvider.deleteTarefas(index);
                Navigator.pushNamed(context, Routes.HOME);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text("Descrição: ${tarefa.nome}"),
            Text("Data: ${tarefa.datahora}"),
            Text("Localização: ${tarefa.latitude} - ${tarefa.longitude}"),
          ],
        ),
      ),
    );
  }
}

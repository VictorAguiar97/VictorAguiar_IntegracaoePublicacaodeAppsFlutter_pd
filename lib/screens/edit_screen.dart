import 'package:auto_control_panel/components/tarefas_form.dart';
import 'package:auto_control_panel/providers/tarefas_provider.dart';
import 'package:auto_control_panel_pk/auto_control_panel_pk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final Tarefas tarefa = args['tarefa'];
    final int index = args['index'];

    final tarefasProvider = context.watch<TarefasProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Tarefa'),
        actions: [
          if (index.toString().isNotEmpty)
            IconButton(
                onPressed: () {
                  tarefasProvider.delete(tarefa.id.toString(), index);
                  Navigator.pushNamed(context, Routes.HOME);
                },
                icon: const Icon(Icons.delete))
        ],
      ),
      body: TarefasForm(
        tarefa: tarefa,
        index: index,
      ),
    );
  }
}

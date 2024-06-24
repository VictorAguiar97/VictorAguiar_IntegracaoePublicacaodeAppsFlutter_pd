import 'package:auto_control_panel/components/tarefas_list_tite.dart';
import 'package:auto_control_panel/providers/tarefas_provider.dart';
import 'package:auto_control_panel_pk/auto_control_panel_pk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TarefasList extends StatefulWidget {
  const TarefasList({super.key});

  @override
  State<TarefasList> createState() => _TarefasListState();
}

class _TarefasListState extends State<TarefasList> {
  @override
  Widget build(BuildContext context) {
    final tarefasProvider = context.watch<TarefasProvider>();
    final List<Tarefas> listaTarefas = tarefasProvider.tarefas;

    if (listaTarefas.isEmpty) {
      tarefasProvider.list();
    }

    return ListView.builder(
      itemCount: listaTarefas?.length,
      itemBuilder: (context, index) {
        Tarefas tarefa = listaTarefas![index];
        return TarefasListTile(tarefa: tarefa, index: index);
      },
    );
  }
}

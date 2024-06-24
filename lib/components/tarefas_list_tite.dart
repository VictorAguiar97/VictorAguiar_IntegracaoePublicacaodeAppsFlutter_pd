import 'package:auto_control_panel/routes.dart';
import 'package:auto_control_panel_pk/auto_control_panel_pk.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TarefasListTile extends StatelessWidget {
  const TarefasListTile({super.key, required this.tarefa, required this.index});

  final Tarefas tarefa;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(tarefa.nome),
      subtitle: Text(DateFormat('dd/MM/yyyy HH:mm').format(tarefa.datahora)),
      trailing: Text('${tarefa.latitude} ${tarefa.longitude}'),
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.EDIT_FORM,
          arguments: {'tarefa': tarefa, 'index': index},
        );
      },
    );
  }
}

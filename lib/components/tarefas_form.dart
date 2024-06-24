import 'package:auto_control_panel/providers/tarefas_provider.dart';
import 'package:auto_control_panel/routes.dart';
import 'package:auto_control_panel_pk/auto_control_panel_pk.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TarefasForm extends StatefulWidget {
  final Tarefas? tarefa;
  final int? index;

  const TarefasForm({super.key, this.tarefa, this.index});

  @override
  State<TarefasForm> createState() => _TarefasFormState();
}

class _TarefasFormState extends State<TarefasForm> {
  final descricaotarefaController = TextEditingController();
  final datatimeController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  var index = -1;
  var id = '';

  Future<LocationData?> getLocation() async {
    Location location = Location();
    bool serviceEnabledLocation;
    PermissionStatus permissionStatus;

    serviceEnabledLocation = await location.serviceEnabled();
    if (!serviceEnabledLocation) {
      serviceEnabledLocation = await location.requestService();
      if (!serviceEnabledLocation) return null;
    }

    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) return null;
    }

    return location.getLocation();
  }

  @override
  void initState() {
    super.initState();

    if (widget.tarefa != null) {
      descricaotarefaController.text = widget.tarefa!.nome;
      latitudeController.text = widget.tarefa!.latitude;
      longitudeController.text = widget.tarefa!.longitude;
      id = widget.tarefa!.id!;

      String dateFormat =
          DateFormat('yyyy-MM-dd HH:mm').format(widget.tarefa!.datahora);
      datatimeController.text = dateFormat.toString();
    } else {
      String dateFormat = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
      datatimeController.text = dateFormat.toString();
    }

    if (widget.index != null) {
      index = widget.index!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tarefasProvider = context.read<TarefasProvider>();

    return SizedBox(
      child: Column(
        children: [
          TextField(
            controller: descricaotarefaController,
            decoration: const InputDecoration(
              hintText: 'Descrição',
            ),
          ),
          TextField(
            controller: datatimeController,
            inputFormatters: [
              MaskTextInputFormatter(
                mask: '####-##-## ##:##',
                filter: {"#": RegExp(r'[0-9]')},
              ),
            ],
            decoration: const InputDecoration(
              hintText: 'Data (YYYY-MM-DD HH:MM)',
            ),
          ),
          TextField(
            controller: latitudeController,
            decoration: const InputDecoration(
              hintText: 'Latitude',
            ),
            enabled: false,
          ),
          TextField(
            controller: longitudeController,
            decoration: const InputDecoration(
              hintText: 'Longitude',
            ),
            enabled: false,
          ),
          ElevatedButton(
            onPressed: () {
              String descricao = descricaotarefaController.text;
              DateTime datetime;
              try {
                datetime = DateTime.parse(datatimeController.text);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data inválida')),
                );
                return;
              }

              if (descricao.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Preencha o campo Descrição')),
                );
                return;
              }

              if (id == '') {
                double latitude = double.parse(latitudeController.text);
                double longitude = double.parse(longitudeController.text);

                if (latitude.toString().isEmpty ||
                    longitude.toString().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Localização não encontrada')),
                  );
                  return;
                }

                final tarefa = Tarefas(
                  null,
                  descricao,
                  datetime,
                  latitude.toString(),
                  longitude.toString(),
                );

                tarefasProvider.insert(tarefa);
              } else {
                String latitude = latitudeController.text;
                String longitude = longitudeController.text;

                if (latitude.isEmpty || longitude.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Localização não encontrada')),
                  );
                  return;
                }

                final tarefa = Tarefas(
                  id,
                  descricao,
                  datetime,
                  latitude.toString(),
                  longitude.toString(),
                );

                tarefasProvider.editTarefas(tarefa);
              }

              Navigator.pushNamed(context, Routes.HOME);
            },
            child: Text(id == '' ? "Salvar" : "Editar"),
          ),
          FutureBuilder<LocationData?>(
            future: getLocation(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else if (snapshot.hasData) {
                double? latitude = snapshot.data?.latitude;
                double? longitude = snapshot.data?.longitude;

                if (id == '') {
                  if (latitude != null && longitude != null) {
                    latitudeController.text = latitude.toString();
                    longitudeController.text = longitude.toString();
                  }

                  return Text(
                    'Latitude: ${latitude?.toString()}, Longitude: ${longitude?.toString()}',
                  );
                } else {
                  return const Text(
                    '',
                  );
                }
              } else {
                return const Text('Nenhum dado disponível');
              }
            },
          ),
        ],
      ),
    );
  }
}

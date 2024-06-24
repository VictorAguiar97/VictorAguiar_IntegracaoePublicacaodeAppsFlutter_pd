import 'package:auto_control_panel/components/tarefas_list.dart';
import 'package:auto_control_panel/routes.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  //Cada vez que a Widge atualizar, saber o estado anterior e final
  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    //final mediaQuery = MediaQuery.of(context);

    //final larguraDisponivel = mediaQuery.size.width;
    //final alturaDisponivel = mediaQuery.size.height -
    //appBar.preferredSize.height -
    //MediaQuery.of(context).padding.top;

    //final orientacaoVertical = mediaQuery.orientation == Orientation.portrait;
    //Platform.isAndroid || Platform.isIos
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
              onPressed: () {
                //Navigator.push(context,
                //MaterialPageRoute(builder: (context) => const AboutScreen()));
                Navigator.pushNamed(context, 'about_screen').then((value) {
                  // ignore: avoid_print
                  //String valor = value as String;
                  //print("VOLTAMOSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS $valor");
                });
              },
              icon: const Icon(Icons.info))
        ],
      ),
      body: const TarefasList(),
      drawer: Drawer(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.receipt),
              title: const Text("Adicionar Tarefas"),
              trailing: const Icon(Icons.arrow_right),
              onTap: () {
                Navigator.pushNamed(context, Routes.FORM,
                    arguments: {'tarefa': null, 'index': null});
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("Sobre Nós"),
              trailing: const Icon(Icons.arrow_right),
              onTap: () {
                Navigator.pushNamed(context, Routes.ABOUT).then((value) {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text("Localização"),
              trailing: const Icon(Icons.arrow_right),
              onTap: () {
                Navigator.pushNamed(context, Routes.LOCATION).then((value) {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Sair"),
              trailing: const Icon(Icons.arrow_right),
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.SIGNIN)
                    .then((value) {});
              },
            )
          ],
        ),
      ),
    );
  }
}

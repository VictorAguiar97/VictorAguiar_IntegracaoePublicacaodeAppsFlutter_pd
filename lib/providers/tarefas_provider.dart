import 'package:auto_control_panel_pk/auto_control_panel_pk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TarefasProvider extends ChangeNotifier {
  String collection = "tarefas";

  FirebaseFirestore db = FirebaseFirestore.instance;

  List<Tarefas> tarefas = [];

  void addTarefas(Tarefas tarefa) {
    tarefas.add(tarefa);
    notifyListeners();
  }

  void deleteTarefas(int index) {
    tarefas.removeAt(index);
    notifyListeners();
  }

  Future<void> editTarefas(Tarefas tarefa) async {
    var data = <String, dynamic>{
      'nome': tarefa.nome,
      'datahora': tarefa.datahora,
      'latitude': tarefa.latitude,
      'longitude': tarefa.longitude,
    };

    await db.collection(collection).doc(tarefa.id).update(data);

    tarefas = [];
    list();
  }

  list() {
    db.collection(collection).get().then((QuerySnapshot qs) {
      for (var doc in qs.docs) {
        var taref = doc.data() as Map<String, dynamic>;

        DateTime dt = (taref['datahora'] as Timestamp).toDate();
        taref['datahora'] = dt;
        tarefas.add(Tarefas.fromMap(doc.id, taref));
        notifyListeners();
      }
    }).catchError((error) {
      print("Erro ao buscar tarefas: $error");
    });
  }

  insert(Tarefas tarefa) {
    var data = <String, dynamic>{
      'nome': tarefa.nome,
      'datahora': tarefa.datahora,
      'latitude': tarefa.latitude,
      'longitude': tarefa.longitude,
    };

    //var future = db.collection(collection).doc("tarefA").set(data);
    var future = db.collection(collection).add(data);
    //.add(data); - FireBase que determina a primary key

    future.then((Index) {
      String id = Index.id;
      tarefa.id = id;
      tarefas.add(tarefa);
      notifyListeners();
    });
  }

  delete(String id, int index) {
    var future = db.collection(collection).doc(id).delete();

    future.then((_) {
      tarefas.removeAt(index);
      notifyListeners();
    });
  }
}

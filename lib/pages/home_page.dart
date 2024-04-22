import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/components/tile.dart';
import 'package:todolist/services/firebase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  FirestoreService tasks = FirestoreService();

  void openDialogBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textEditingController,
        ),
        actions: [
          ElevatedButton(
            onPressed: docID == null
                ? () {
                    tasks.addTask(textEditingController.text);
                    textEditingController.clear();
                    Navigator.pop(context);
                  }
                : () {
                    tasks.updateTask(docID, textEditingController.text);
                    textEditingController.clear();
                    Navigator.pop(context);
                  },
            child: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
    );
  }

  void onDelete(String docID) {
    tasks.deleteTask(docID);
  }

  void onCheck(bool? value, String docID) {
    tasks.updateTaskValue(docID, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan[300],
        title: const Text(
          'T O - D O - L I S T',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan[300],
        onPressed: () => openDialogBox(),
        child: const Icon(
          Icons.add,
        ),
      ),
      body: StreamBuilder(
        stream: tasks.getTasks,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List tasksList = snapshot.data.docs;

            return ListView.builder(
              itemCount: tasksList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = tasksList[index];

                return ToDoListTile(
                  onCheck: (value) => onCheck(value, doc.id),
                  value: doc['value'],
                  data: doc['task'],
                  onDelete: () => onDelete(doc.id),
                  onUpdate: () => openDialogBox(docID: doc.id),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'Loading Data...',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

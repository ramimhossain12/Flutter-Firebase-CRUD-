import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/single_todo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreens extends StatefulWidget {
  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  final _textField = TextEditingController();
  final _textUpdate = TextEditingController();

  //for server request get.....

  Future<void> _addtodo() async {
    if (_textField.text.length <= 0) {
      return;
    }

    // for data insert

    final collucrion = FirebaseFirestore.instance.collection('todo');
    await collucrion.add({
      "title": _textField.text,
    });

    _textField.text = '';
    Navigator.of(context).pop();
  }

  //for delete

  Future<void> dellateTodo(String id) async {
    try {
      final collucrion = FirebaseFirestore.instance.collection('todo').doc(id);
      await collucrion.delete();
    } catch (e) {
      print(e);
    }
  }

//for updateing
  Future<void> _updatetodo(String id) {
    String updateText =  _textUpdate.text;
    try {
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('todo').doc(id);
      FirebaseFirestore.instance.runTransaction((transition) async {
        
            await transition.get(documentReference);
        transition.update(documentReference, {
          'title': updateText,
        });
      });
      Navigator.of(context).pop();
      _textUpdate.text = '';
    } catch (e) {}
  }

  Future<void> editbutton(String id) async {
    final collucrion = FirebaseFirestore.instance.collection('todo').doc(id);
    await collucrion.get().then((value) {
      _textUpdate.text = (value.data()['title']);
    });
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Update Todo"),
            content: TextField(
              controller: _textUpdate,
              decoration: InputDecoration(hintText: "Update Todo"),
            ),
            actions: [
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cencel'),
              ),
              RaisedButton(
                onPressed: () {
                  //for data update
                  _updatetodo(id);
                },
                child: Text('Update'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Todo App"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("todo").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("No Data Found "),
            );
          }
          return ListView(
            children: snapshot.data.docs
                .map(
                  (todoData) => SingleTodo(
                    todo: todoData.data()['title'],
                    id: todoData.id,
                    deletefunction: dellateTodo,
                    editFunction: editbutton,
                  ),
                )
                .toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Add Note"),
                  content: TextField(
                    controller: _textField,
                    decoration: InputDecoration(hintText: "Add a Todo"),
                  ),
                  actions: [
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cencel'),
                    ),
                    RaisedButton(
                      onPressed: () {
                        //for data add
                        _addtodo();
                      },
                      child: Text('Add'),
                    )
                  ],
                );
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

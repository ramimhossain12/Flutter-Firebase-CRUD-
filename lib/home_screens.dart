import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/single_todo.dart';
import 'package:flutter/material.dart';

class HomeScreens extends StatefulWidget {
  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  final _textField = TextEditingController();
  List<String> todos = [
    'Test Todo 1',
    'Test Todo 2',
    'Test Todo 3',
    'Test Todo 4',
    'Test Todo 5'
  ];
  void _addtodo() {
    if (_textField.text.length <= 0) {
      return;
    }
    setState(() {
      todos.insert(0, _textField.text);
    });

    _textField.text = '';
    Navigator.of(context).pop();
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
            .map((todoData) =>SingleTodo(
              todo: todoData.data()['title'],) ,).toList
               (),

            
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

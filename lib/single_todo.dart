import 'package:flutter/material.dart';

class SingleTodo extends StatelessWidget {
  final String todo;
  final String id;
  //for delete function
  final Function deletefunction;
  final Function editFunction;

  SingleTodo({this.todo, this.id, this.deletefunction, this.editFunction});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(13),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Text(
                todo,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Spacer(),
              IconButton(
                  icon: Icon(
                    Icons.edit,
                    size: 25,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    editFunction(id);
                  }),
              IconButton(
                  icon: Icon(
                    Icons.delete,
                    size: 25,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    deletefunction(id);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

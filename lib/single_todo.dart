import 'package:flutter/material.dart';
class SingleTodo extends StatelessWidget {

  final String todo;

  SingleTodo({this.todo});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(13),child: Card(
        child: Padding(

          padding: const EdgeInsets.all(8),

          child: Row(

            children: [
              Text(todo,style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,

              ),),
              Spacer(),
              IconButton(icon:Icon(Icons.edit,
              size: 25,color: Colors.green,) , onPressed: (){

              }),
              IconButton(icon:Icon(Icons.delete,size: 25,color: Colors.red,) , onPressed: (){

              }),
            ],
          ),
        ),
      
      
    ),);

  }
}

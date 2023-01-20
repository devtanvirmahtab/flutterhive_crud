import 'package:flutter/material.dart';
import 'package:flutterhive_crud/Models/notes_model.dart';
import 'package:flutterhive_crud/details_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'Boxes/boxes.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final titleController = TextEditingController();
  final discriptionController = TextEditingController();



  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hive Database crud'),),
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context,box, _){
          var data = box.values.toList().cast<NotesModel>();
        return  ListView.builder(
          reverse: true,
          itemCount: box.length,
            shrinkWrap: true,
            primary: true,
            itemBuilder: (context,index){
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(
                title: data[index].title.toString(),
                descrioption: data[index].description.toString(),
              )));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              margin: const EdgeInsets.all(10.0),
              child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(data[index].title.toString(),overflow: TextOverflow.ellipsis, style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),),
                      Spacer(),
                      IconButton(onPressed: (){
                        delete(data[index]);
                      }, icon: Icon(Icons.delete)),
                      IconButton(onPressed: (){
                        _editMyDialog(data[index], data[index].title.toString(), data[index].description.toString());
                      }, icon: Icon(Icons.edit)),
                    ],
                  ),

                  Text(data[index].description.toString(),overflow: TextOverflow.ellipsis),
                ],
              ),
            ),),
          );
        });
      },),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          _showMyDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }


  void delete(NotesModel notesModel) async{
    await notesModel.delete();
  }

  Future<void> _editMyDialog(NotesModel notesModel,String title,String description)async{

    titleController.text = title;
    discriptionController.text = description;

    return showDialog(
      context: context,
      builder: (context){
        return  AlertDialog(
          title: Text('Edit Notes'),
          content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                        hintText:  'Enter Title',
                        border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: discriptionController,
                    decoration: InputDecoration(
                        hintText: 'Description',
                        border: OutlineInputBorder()
                    ),
                  )
                ],
              )
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            } ,
              child: Text('Cancel'),
            ),
            TextButton(onPressed: () async{

              notesModel.title = titleController.text.toString();
              notesModel.description = discriptionController.text.toString();
              notesModel.save();

              titleController.clear();
              discriptionController.clear();

              Navigator.pop(context);
            } ,
              child: Text('Edit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog()async{
    return showDialog(
        context: context,
        builder: (context){
          return  AlertDialog(
            title: Text('Add Notes'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText:  'Enter Title',
                      border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: discriptionController,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder()
                    ),
                  )
                ],
              )
            ),
            actions: [
              TextButton(onPressed: (){
                  Navigator.pop(context);
                } ,
                child: Text('Cancel'),
              ),
              TextButton(onPressed: (){

                final data = NotesModel(title: titleController.text, description: discriptionController.text);
                final box = Boxes.getData();
                box.add(data);
                data.save();
                titleController.clear();
                discriptionController.clear();

                print(box);

                  Navigator.pop(context);
                } ,
                child: Text('Add'),
              ),
            ],
          );
        },
    );
  }

}

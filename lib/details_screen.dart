import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  String? title;
  String? descrioption;
   DetailsScreen({Key? key , required this.title,required this.descrioption}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState(title: title, descrioption: descrioption);
}

class _DetailsScreenState extends State<DetailsScreen> {
  String? title;
  String? descrioption;
  _DetailsScreenState({required this.title,required this.descrioption});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$title', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 20,
            ),
            Text('$descrioption'),
          ],
        ),
      ),
    );
  }
}

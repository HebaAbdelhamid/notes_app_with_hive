import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'models/date.dart';
import 'models/notes.dart';

class Home_Page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Home_Page_state();
  }

}

class Home_Page_state extends State<Home_Page>{
  late TextEditingController _textEditingController;
  late TextEditingController _titleEditinController;
  final GlobalKey<FormState>form_key=GlobalKey();
  late TextEditingController _edittextEditingContoler;
  late TextEditingController _edittitleEditingController;
  final GlobalKey<FormState>_key=GlobalKey();


  @override
  void initState() {
    super.initState();
    _textEditingController=TextEditingController();
    _titleEditinController=TextEditingController();
  }
  @override
  void dispose() {
    super.dispose();
    _titleEditinController.dispose();
    _textEditingController.dispose();
  }
 final Box<Note> notebox=Hive.box("notes");
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: Text("Notes App",

       style: TextStyle(color: Colors.white),

     ),backgroundColor:Color(
         0xffaf75e7),
       centerTitle: true,
     ),
     body: SingleChildScrollView(
       child: Padding(
         padding: const EdgeInsets.all(12.0),
         child: Column(
           children: [
             Form(
               key:form_key,
                 child:Column(
               children: [
                 TextFormField(
                   controller:_titleEditinController,validator:(value)=>value!.isEmpty?"This field is require":null,
                   decoration: InputDecoration(labelText: "Title",focusColor:Color(0xffaf75e7),
           enabledBorder: OutlineInputBorder(borderSide: BorderSide( color:Color(0xffaf75e7) ),),),
                 ),
                 SizedBox(height: 17,),
                 TextFormField(
                   controller:_textEditingController,
                   validator: (value)=>value!.isEmpty?"This field is required":null,
                   decoration: InputDecoration(labelText: "Text",focusColor:Color(0xffaf75e7),
                     enabledBorder: OutlineInputBorder(borderSide: BorderSide( color:Color(0xffaf75e7) ),),),
                 ),
                 SizedBox(
                   height: 5,
                 ),
                 ElevatedButton(
                   onPressed: (){
                   setState(() {
                     if(form_key.currentState!.validate()){
                      Note note_= Note(title:_titleEditinController.value.text,text:_textEditingController.value.text,
                        date:DataManagement.currentDateTime()
                       );
                      notebox.add(note_);

                      print("hi");
                     }
                   });
                 },
                   
                   child: Text("save"),style: ElevatedButton.styleFrom(backgroundColor: Color(0xffaf75e7),),)
               ],
             ) ),
             ValueListenableBuilder<Box<Note>>(
               valueListenable: notebox.listenable(),
               builder: (context,notebox,child)=>
                   ListView.separated(
                     shrinkWrap: true,
                     physics: NeverScrollableScrollPhysics(),
                     itemCount: notebox.length,
                     separatorBuilder: (context,index)=>Divider(),
                     itemBuilder: (context,index)=>
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Color(
                          0xffbda1ce)),

                      child: ListTile(title: Text(notebox.getAt(index)!.title!),
                 subtitle: Text(notebox.getAt(index)!.text!),
                 leading: Icon(Icons.note),
                 trailing: SizedBox(width: 100,
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.end,
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           IconButton(onPressed: (){
                             setState(() {
                               _showDialogeform(index);
                             });
                           }, icon: Icon(Icons.edit,),color: Colors.green, ),
                           IconButton(onPressed: (){
                             notebox.deleteAt(index);
                           }, icon: Icon(Icons.delete),color:Colors.red),
                         ],
                       ),
                 ),
               ),
                    ),
                   ),
             ) ,

           ],
         ),
       ),
     ),
   );

  }
  void _showDialogeform(int index){
    _edittextEditingContoler=TextEditingController(text: _textEditingController.value.text);
    _edittitleEditingController=TextEditingController(text: _titleEditinController.value.text);
     showDialog(
       context: context,
       builder:(context)=> AlertDialog(
        title: Text("update note"),
        content:Wrap(
          children: [
            Form(
              key:_key,
              child:Column(
                children: [
                  TextFormField(
                    controller:_edittitleEditingController,validator:(value)=>value!.isEmpty?"This field is require":null,
                    decoration: InputDecoration(labelText: "Title",focusColor:Color(0xffaf75e7),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide( color:Color(0xffaf75e7) ),),),
                  ),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller:_edittextEditingContoler,
                    validator: (value)=>value!.isEmpty?"This field is required":null,
                    decoration: InputDecoration(labelText: "Text",focusColor:Color(0xffaf75e7),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide( color:Color(0xffaf75e7) ),),),
                  ),
                ],
              ) ),]
        ),
        actions: [
          ElevatedButton(onPressed: (){
            setState(() {
              if(form_key.currentState!.validate()){
                Note n=Note(title: _edittitleEditingController.value.text,text: _edittextEditingContoler.value.text,date: DataManagement.currentDateTime());
                notebox.putAt(index, n);
                Navigator.pop(context);


              }
            });
          }, child: Text("update"),style: ElevatedButton.styleFrom(backgroundColor:Colors.green),),
          ElevatedButton(onPressed: (){
           setState(() {
             Navigator.pop(context);
           });
          }, child: Text("canel"),style: ElevatedButton.styleFrom(backgroundColor:Colors.red,),)

        ],
    ),
     );
  }

}
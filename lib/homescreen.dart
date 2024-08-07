import 'package:flutter/material.dart';
import 'package:taskmate/login_screen.dart';
import 'package:taskmate/model/taskmate_model.dart';
import 'package:taskmate/services/auth_services.dart';
import 'package:taskmate/services/database_services.dart';
import 'package:taskmate/widgets/completed_widgets.dart';
import 'package:taskmate/widgets/pending_widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _buttonIndex = 0;
  final List<Widget> _widgets = [
    // Pending
    PendingWidget(),

    // Completed
    CompltedWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text("TaskMate"),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService().signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    setState(() {
                      _buttonIndex = 0;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2.2,
                    decoration: BoxDecoration(
                      color: _buttonIndex==0 ? Colors.indigo: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: _buttonIndex==0 ? 16:14,
                            fontWeight: FontWeight.w400,
                            color: _buttonIndex==0 ? Colors.white : Colors.black,
                          ),
                        ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    setState(() {
                      _buttonIndex = 1;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2.2,
                    decoration: BoxDecoration(
                      color: _buttonIndex==1 ? Colors.indigo: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: _buttonIndex==1 ? 16:14,
                            fontWeight: FontWeight.w400,
                            color: _buttonIndex==1 ? Colors.white : Colors.black,
                          ),
                        ),
                    ),
                  ),
                ),
              ],
            ),
            // Add other widgets as necessary
            SizedBox(height: 30,),
            _widgets[_buttonIndex],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showTaskDialog(context);
        },
      ),
    );
  }

  void _showTaskDialog(BuildContext context,{TaskMate? taskmate}){
    final TextEditingController _titleController=TextEditingController(text: taskmate?.title);
    final TextEditingController _descriptionController=TextEditingController(text:taskmate?.description);
    final DatabaseService _databaseService=DatabaseService();

    showDialog(context: context, builder: (context){
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(taskmate == null ?"Add Task": "Edit Task",
          style: TextStyle(
            fontWeight: FontWeight.w500,

          ),
        ),
        content: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed:(){
            Navigator.pop(context);
            },
            child:Text('Cancel'),
          ),
          ElevatedButton(onPressed: () async{
            
            if(taskmate==null){
              await _databaseService.addTask(_titleController.text, _descriptionController.text);
            }
            else{
              await _databaseService.updateTaskmate(taskmate.id,_titleController.text, _descriptionController.text);
            }
            Navigator.pop(context);
          }, 
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
          child: Text(taskmate==null? "Add":"Update"),
          )
        ],
      );
    });
  }
}

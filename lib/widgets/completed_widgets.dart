import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
//import 'package:taskmate/model/taskmate_model.dart';
import 'package:taskmate/services/database_services.dart';

class CompltedWidget extends StatefulWidget {
  const CompltedWidget({super.key});

  @override
  State<CompltedWidget> createState() => _CompltedWidgetState();
}

class _CompltedWidgetState extends State<CompltedWidget> {
  User? user = FirebaseAuth.instance.currentUser;
  late String uid;

  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Taskmate>>(
      stream: _databaseService.completedTasks,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Taskmate> tasks = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              Taskmate taskmate = tasks[index];
              final DateTime dt = taskmate.timeStamp;
              return Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Slidable(
                  key: ValueKey(taskmate.id),
                  endActionPane: ActionPane(
                    motion: StretchMotion(),
                    children: [
                      SlidableAction(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                        onPressed: (context) async {
                          await _databaseService.deleteTaskmate(taskmate.id);
                        },
                      ),
                    ],
                  ),
                  
                  child: ListTile(
                    title: Text(
                      taskmate.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    subtitle: Text(
                      taskmate.description,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    trailing: Text(
                      '${dt.day}/${dt.month}/${dt.year}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      },
    );
  }
}
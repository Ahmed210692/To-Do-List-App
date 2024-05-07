
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/view_model.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(25, 25, 112, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 0, 139, 1),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.check,
                size: 20,
              ),
            ),
            SizedBox(width: 10,),
            Center(child: Text('To Do List', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
          ],
        ),
      ),
      body: Consumer<Taskviwemodel>(
        builder: (context, taskProvider,_) {
          return ListView.separated(
            itemBuilder: (context, index){
              return const ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                title: Text('Doctor Checkup', style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                ),
                subtitle: Text('Tomorrow 3:40 p.m', style: TextStyle(color: Colors.white),),
              );

            },
            separatorBuilder: (context, index){
              return const Divider(
                color: Colors.deepPurpleAccent,
                thickness: 3,
                height: 1,
              );
            },
            itemCount: taskProvider.tasks.length,
          );
        }
      ),

      floatingActionButton: FloatingActionButton(

        onPressed: (){
          final double sh = MediaQuery.of(context).size.height;
          final double sw = MediaQuery.of(context).size.width;
          final taskProvider = Provider.of<Taskviwemodel>(context, listen: false);
          print("Show Dialog");
          showDialog(
            context: context,
            builder:(context){
              return Dialog(
                backgroundColor: const Color.fromRGBO(0, 0, 139, 1),
                shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
                child: SizedBox(
                  height: sh * 0.6,
                  width: sw * 0.8,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sw * 0.05, vertical: sh * 0.02),
                    child: Padding(
                      padding: const  EdgeInsets.all(10.0),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('New Task', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500)),
                         const  SizedBox(height: 30,),
                         const  Text('What has to be done?', style: TextStyle(color: Colors.white, fontSize: 20)),
                          CustomTextField(hint: "Enter a task",
                         onChanged: (value){
                           taskProvider.setTaskName(value);
                         },),

                        const   SizedBox(height: 60,),
                          const Text('Due Date', style: TextStyle(color: Colors.white, fontSize: 15),),
                          CustomTextField(
                            hint: "Pick a date" ,
                            icon: Icons.calendar_month,
                            readOnly: true,
                            controller: taskProvider.dateCont,
                            onTap: () async {
                              DateTime? date =  await showDatePicker(context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2016),
                                lastDate:DateTime(2031));
                              taskProvider.setDate(date);
                            },

                            ),
                          CustomTextField(
                            hint: "Pick a time" ,
                            icon: Icons.timer,
                              readOnly: true,
                            controller: taskProvider.timeCont,
                            onTap: ()  async {
                              TimeOfDay? time =  await showTimePicker(context: context,
                                  initialTime: TimeOfDay.now());

                            },

                              ),
                            const  SizedBox(height: 20,),
                          Center(
                            child: ElevatedButton(

                                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                onPressed:() async {
                             await taskProvider.addTask();
                              if(context.mounted){
                              Navigator.pop(context);}
                                }, child: const Text("Create", style: TextStyle(color: Colors.deepPurple),)
                    ),
                          ),


                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
           return;
        },
        child: const  Icon(Icons.add, size: 45),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.hint,
     this.icon,
     this.readOnly = false,
     this.onTap,
    this.onChanged,
    this.controller
  });
final String hint;
final IconData? icon;
final void Function()? onTap;
  void Function(String)? onChanged;
  final TextEditingController? controller;
final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return  TextField(
      readOnly: readOnly,
      onChanged: onChanged,
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        suffixIcon: InkWell(onTap: onTap, child: Icon(icon, color: Colors.white,)),
        hintText: hint, hintStyle: const TextStyle(color: Colors.grey)
      ),
    );
  }
}

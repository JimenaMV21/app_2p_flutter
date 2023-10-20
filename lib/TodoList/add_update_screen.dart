import 'package:app_segpar/TodoList/datab.dart';
import 'package:app_segpar/TodoList/draw.dart';
import 'package:app_segpar/TodoList/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddUpdateTask extends StatefulWidget {
  int? todoId;
  String? todoTitle;
  String? todoDesc;
  String? tODODT;
  bool? update;

  AddUpdateTask({
    this.todoId,
    this.todoTitle,
    this.todoDesc,
    this.tODODT,
    this.update,
  });

  @override
  State<AddUpdateTask> createState() => _AddUpdateTaskState();
}

class _AddUpdateTaskState extends State<AddUpdateTask> {
  DBHelper? dbHelper;

  late Future<List<TodoMOdel>> dataList;

  final _fromkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    dataList = dbHelper!.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    final titlecontroller = TextEditingController(text: widget.todoTitle);
    final descontroller = TextEditingController(text: widget.todoDesc);

    String appTitle;
    if (widget.update == true) {
      appTitle = "Update Task";
    } else {
      appTitle = "Add Task";
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            appTitle,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 100),
          child: SingleChildScrollView(
            child: Column(children: [
              Form(
                key: _fromkey,
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      controller: titlecontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Write notes here',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter some Text';
                        }
                        return null;
                      },
                    ),
                  )
                ]),
              ),
              SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Material(
                      color: Colors.green[400],
                      child: InkWell(
                        onTap: () {
                          if (_fromkey.currentState!.validate()) {
                            if (widget.update == true) {
                              dbHelper!.insert(TodoMOdel(
                                  title: titlecontroller.text,
                                  desc: descontroller.text,
                                  dateandtime: widget.tODODT));
                            } else {
                              dbHelper!.insert(TodoMOdel(
                                  title: titlecontroller.text,
                                  desc: descontroller.text,
                                  dateandtime: DateFormat('yMd')
                                      .add_jm()
                                      .format(DateTime.now())
                                      .toString()));
                            }

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeDraw()));
                            titlecontroller.clear();
                            descontroller.clear();
                            print('Data added');
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 55,
                          width: 120,
                          decoration: BoxDecoration(),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.red[400],
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            titlecontroller.clear();
                            descontroller.clear();
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 55,
                          width: 120,
                          decoration: BoxDecoration(),
                          child: Text(
                            'Clear',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}

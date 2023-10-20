import 'package:app_segpar/Compass/compass_main.dart';
import 'package:app_segpar/TodoList/add_update_screen.dart';
import 'package:app_segpar/TodoList/datab.dart';
import 'package:app_segpar/TodoList/model.dart';
import 'package:flutter/material.dart';

class HomeDraw extends StatefulWidget {
  const HomeDraw({super.key});

  @override
  State<HomeDraw> createState() => _HomeDrawState();
}

class _HomeDrawState extends State<HomeDraw> {
  DBHelper? dbHelper;
  late Future<List<TodoMOdel>> dataList;

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DP-TODO',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const MyApp()),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: dataList,
                  builder: (context, AsyncSnapshot<List<TodoMOdel>> snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data!.length == 0) {
                      return Center(
                        child: Text(
                          'No Task Found',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            int TodoId = snapshot.data![index].id!.toInt();
                            String TodoTitle =
                                snapshot.data![index].title!.toString();
                            String TodoDesc =
                                snapshot.data![index].desc!.toString();
                            String TODODT =
                                snapshot.data![index].dateandtime!.toString();
                            return Dismissible(
                                key: ValueKey<int>(TodoId),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Colors.red,
                                  child: const Icon(Icons.delete_forever,
                                      color: Colors.white),
                                ),
                                onDismissed: (DismissDirection direction) {
                                  setState(() {
                                    dbHelper!.deleteData(TodoId);
                                    dataList = dbHelper!.getDataList();
                                    snapshot.data!
                                        .remove(snapshot.data![index]);
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow.shade300,
                                  ),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.all(10),
                                        title: Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            TodoTitle,
                                            style: TextStyle(fontSize: 19),
                                          ),
                                        ),
                                        subtitle: Text(
                                          TodoDesc,
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        thickness: 0.8,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              TODODT,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddUpdateTask(
                                                        todoId: TodoId,
                                                        todoTitle: TodoTitle,
                                                        todoDesc: TodoDesc,
                                                        tODODT: TODODT,
                                                        update: true,
                                                      ),
                                                    ));
                                              },
                                              child: Icon(
                                                Icons.edit_note,
                                                size: 28,
                                                color: Colors.green,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          });
                    }
                  })),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddUpdateTask()));
          }),
    );
  }
}

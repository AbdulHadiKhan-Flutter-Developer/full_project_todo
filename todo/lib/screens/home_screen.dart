import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/utils/app_constant.dart';
import 'package:todo/utils/functions.dart';
import 'package:todo/widgets/todo_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    loadmodel();
    super.initState();
  }

  final Functions functions = Functions();
  int done = 0;
  List<TodoModel> mytodos = [];

  void loadmodel() async {
    List<TodoModel> fetchdata = await functions.fetchdata();
    int completed = await fetchdata.where((todo) => todo.isdone).length;
    setState(() {
      done = completed;
      mytodos = fetchdata;
    });
  }

  final List<Color> color = [AppConstant.primary, AppConstant.textPrimary];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.background,
      body: Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height:
                  270, // Increase this height as needed to fit both containers
              child: Stack(
                children: [
                  // Top container
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: AppConstant.primary,
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 80),
                          child: Image(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),

                  // Overlapping container
                  Positioned(
                    top: 120,
                    left: 16,
                    right: 16,
                    child: Container(
                        height: 150,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppConstant.card,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: PieChart(
                          legendOptions: LegendOptions(
                              legendTextStyle: TextStyle(
                                  fontFamily: AppConstant.primaryfonts,
                                  color: AppConstant.textSecondary)),
                          chartValuesOptions: ChartValuesOptions(
                              chartValueStyle: TextStyle(
                                  fontFamily: AppConstant.primaryfonts,
                                  color: AppConstant.textPrimary),
                              showChartValueBackground: true,
                              showChartValuesInPercentage: true,
                              showChartValuesOutside: true),
                          colorList: color,
                          ringStrokeWidth: 10,
                          chartRadius: 80,
                          baseChartColor: AppConstant.primary,
                          dataMap: {
                            'Pending': (mytodos.length - done).toDouble(),
                            'Complete': done.toDouble()
                          },
                          animationDuration: Duration(seconds: 3),
                          chartType: ChartType.ring,
                        )),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: mytodos.length,
                itemBuilder: (context, index) {
                  return TodoWidget(
                      onpress: () async {
                        await functions.deletetodo(mytodos[index].id);

                        loadmodel();
                      },
                      isDone: mytodos[index].isdone,
                      toggle: (bool? value) async {
                        await functions.updatetodostatus(
                            mytodos[index].id,
                            mytodos[index].title,
                            mytodos[index].description,
                            value ?? false);
                        loadmodel();
                      },
                      title: mytodos[index].title,
                      description: mytodos[index].description);
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppConstant.primary,
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SingleChildScrollView(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                'ADD YOU\'R TODO',
                                style: TextStyle(
                                    fontFamily: AppConstant.primaryfonts,
                                    color: AppConstant.textPrimary,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: titleController,
                              cursorColor: AppConstant.textPrimary,
                              style: TextStyle(
                                  color: AppConstant.textPrimary,
                                  fontFamily: AppConstant.primaryfonts,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppConstant.background)),
                                  hintText: 'Title',
                                  hintStyle: TextStyle(
                                      color: AppConstant.textPrimary,
                                      fontFamily: AppConstant.primaryfonts,
                                      fontWeight: FontWeight.bold),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppConstant.background))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: descriptionController,
                              cursorColor: AppConstant.textSecondary,
                              style: TextStyle(
                                  color: AppConstant.textSecondary,
                                  fontFamily: AppConstant.primaryfonts,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppConstant.background)),
                                  hintText: 'Note',
                                  hintStyle: TextStyle(
                                      color: AppConstant.textSecondary,
                                      fontFamily: AppConstant.primaryfonts,
                                      fontWeight: FontWeight.bold),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppConstant.background))),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppConstant.background),
                                onPressed: () async {
                                  String title = titleController.text.trim();
                                  String description =
                                      descriptionController.text.trim();
                                  await functions.posttodo(title, description);
                                  titleController.clear();
                                  descriptionController.clear();
                                  loadmodel();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      fontFamily: AppConstant.primaryfonts,
                                      color: AppConstant.textSecondary,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                      ),
                      height: 300,
                      decoration: BoxDecoration(
                          color: AppConstant.primary,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                );
              });
        },
        child: Icon(
          Icons.add,
          color: AppConstant.textPrimary,
        ),
      ),
    );
  }
}

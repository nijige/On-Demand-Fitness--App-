import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:training_diet_app/data/workout_data.dart';
import 'package:training_diet_app/screens/welcom_view.dart';
import 'package:training_diet_app/screens/workout_page.dart';
import 'mode.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Category> catego = [
    Category(
      imagUrl: "assets/images/emily.png",
      name: "Yoga exercises",
    ),
    Category(
      imagUrl: "assets/images/sule.png",
      name: "Example exercises",
    ),
    Category(
      imagUrl: "assets/images/alexsandra.png",
      name: "Example exercises",
    ),
  ];

  void _goToHomeView() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WelcomView()),
    );
  }

  void _goToOtherScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OtherScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/image3.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0, left: 20),
          child: Column(
            children: [
              // Resto do seu código...

              GestureDetector(
                onTap: _goToHomeView, // Navega para outra tela
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Text(
                        "Popular Workout",
                        style: GoogleFonts.lato(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: catego.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: _goToOtherScreen, // Navega para outra tela
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: [
                              Container(
                                height: 172,
                                width: 141,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(catego[index].imagUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                catego[index].name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// create

class OtherScreen extends StatefulWidget {
  @override
  State<OtherScreen> createState() => _OtherScreenState();
}

class _OtherScreenState extends State<OtherScreen> {
  // text controller
  @override
  void initState() {
    super.initState();
    Provider.of<WorkoutData>(context, listen: false).initalizeWorkoutList();
  }

  final newWorkoutNameController = TextEditingController();
  void createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create new workout"),
        content: TextField(
          controller: newWorkoutNameController,
        ),
        actions: [
          //save button
          MaterialButton(
            onPressed: save,
            child: const Text("save"),
          ),
          //cancel Button
          MaterialButton(
            onPressed: cancel,
            child: const Text("cancel"),
          )
        ],
      ),
    );
  }

  // go to workout page
  void goToWorkoutPage(String workoutName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutPage(
          workoutName: workoutName,
        ),
      ),
    );
  }

// save workout
  void save() {
    // get workout name from text controller
    String newWorkoutName = newWorkoutNameController.text;
    // add workout to workoutdata list
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);
    // pop dialog box
    Navigator.pop(context);
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newWorkoutNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text('On Demand Fitness'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewWorkout,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: value.getWorkoutList().length,
          itemBuilder: (context, index) => ListTile(
            title: Text(value.getWorkoutList()[index].name),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () =>
                  goToWorkoutPage(value.getWorkoutList()[index].name),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:training_diet_app/models/exercise.dart';

import '../models/workout.dart';
import 'hive_database.dart';

class WorkoutData extends ChangeNotifier {
  final db = HiveDatabase();
  /*
  WORKOUT DATA STRUCTURES
  - This overall list contains the different workouts
  - Each workout has a name, and list of exercises
  */
  List<Workout> workoutList = [
    //defaut workout
    Workout(name: "Upper Body", exercises: [
      Exercise(name: "Biceps Curls", weight: "10", reps: "10", sets: "3")
    ]),
    Workout(name: "Lower Bodys", exercises: [
      Exercise(name: "Squats", weight: "10", reps: "10", sets: "3")
    ]),
  ];

  // if there
  void initalizeWorkoutList() {
    if (db.previousDataExists()) {
      workoutList = db.readFromDatabase();
    } else {
      db.saveToDatabase(workoutList);
    }
  }

  //get the list of workouts
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  // get length of a given workout
  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

  // add a workout
  void addWorkout(String name) {
    //add a new workout with a blank list of exercises
    workoutList.add(Workout(name: name, exercises: []));
    notifyListeners();
    //save to database
    db.saveToDatabase(workoutList);
  }

  // add an exercise to a workout
  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    // find the relevant workout
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    relevantWorkout.exercises.add(
        Exercise(name: exerciseName, weight: weight, reps: reps, sets: sets));
    notifyListeners();
  }

  // check off exercise
  void CheckOffExercise(String workoutName, String exerciseName) {
    //find  relevant workout and relevant exercise in that workout
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);
    // Check off boolean to show user completed the exercise
    relevantExercise.isCompleted = !relevantExercise.isCompleted;
    notifyListeners();
  }

  // get length of a given workout
  //return relevant workout object, given  a workout name
  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);
    return relevantWorkout;
  }

  //return relevant exercise object, given a workout name + exercise name

  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    // find relevant workout first
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    //then find the relevant exercise in that workout
    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);
    return relevantExercise;
  }
}

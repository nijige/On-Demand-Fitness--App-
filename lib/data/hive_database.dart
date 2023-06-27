import 'package:hive/hive.dart';
import 'package:training_diet_app/datetime/date_time.dart';
import 'package:training_diet_app/models/exercise.dart';

import '../models/workout.dart';

class HiveDatabase {
  // reference our hive box
  final _myBox = Hive.box('workout_database');

  // check if there is already  data stored, if not, record the start date
  bool previousDataExists() {
    if (_myBox.isEmpty) {
      print("previeus data does Not exist");
      _myBox.put("START_DATE", todaysDateYYYYMMDD());
      return false;
    } else {
      print("previeus data does exist");
      return true;
    }
  }
  // return start date as yyymmdd

  String getStarDate() {
    return _myBox.get("START_DATE");
  }

  // write data
  void saveToDatabase(List<Workout> workouts) {
    // convert workout objects int lists of strings so that we can save in hive
    final workoutList = convertObjectToWorkoutList(workouts);
    final exerciseList = convertObjectToExerciseList(workouts);

    /*
    check if any exercises have been done
    we will put a 0 or 1 each yyymmdd date
    */

    if (exerciseCompleted(workouts)) {
      _myBox.put("COMPLETION_STATUS_${todaysDateYYYYMMDD()}", 1);
    } else {
      _myBox.put("COMPLETION_STATUS${todaysDateYYYYMMDD()}", 0);
    }

    // save int hive

    _myBox.put("WORKOUTS", workoutList);
    _myBox.put("EXERCISES", exerciseList);

    // "COMPLETION_STATUS_20230129 -> 0"
  }

  // read data, and return a list of workouts
  List<Workout> readFromDatabase() {
    List<Workout> mySavedWorkouts = [];
    List<String> workoutNames = _myBox.get("WORKOUTS");
    final exerciseDetails = _myBox.get("EXERCISES");

    // create workout objects
    for (int i = 0; i < workoutNames.length; i++) {
      //each workout can have multiple exercises
      List<Exercise> exercisesInEachWorkout = [];

      for (int j = 0; j < exerciseDetails[i].length; j++) {
        //so add each exercise int a lis
        exercisesInEachWorkout.add(
          Exercise(
            name: exerciseDetails[i][j][0],
            weight: exerciseDetails[i][j][1],
            reps: exerciseDetails[i][j][2],
            sets: exerciseDetails[i][j][3],
            isCompleted: exerciseDetails[i][j][4] == "true" ? true : false,
          ),
        );
      }
      //create individual workout
      Workout workout =
          Workout(name: workoutNames[i], exercises: exercisesInEachWorkout);
      // add individual workout to overall list
      mySavedWorkouts.add(workout);
    }
    return mySavedWorkouts;
  }

  // check if any exercises have been done

  // return completion status of a given data yyymmdd

  bool exerciseCompleted(List<Workout> workouts) {
    //go thru each workout
    for (var workout in workouts) {
      for (var exercise in workout.exercises) {
        if (exercise.isCompleted) {
          return true;
        }
      }
    }
    return false;
  }

// return completion  status of a given  date  yyyymmdd

  int getCompletionStatus(String yyyymmdd) {
    // return 0 or 1, if null then return 0
    int completionStatus = _myBox.get("COMPLETION_STATUS$yyyymmdd") ?? 0;
    return completionStatus;
  }

  List<String> convertObjectToWorkoutList(List<Workout> workouts) {
    List<String> workoutList = [];
    for (int i = 0; i < workouts.length; i++) {
      workoutList.add(
        workouts[i].name,
      );
    }
    return workoutList;
  }

  // converts workout objects into a list -> eg. [upperbody , lowerbody]
  List<List<List<String>>> convertObjectToExerciseList(List<Workout> workouts) {
    List<List<List<String>>> exerciseList = [
      /*
  Upper Body
  [[biceps, 10kg, 10 reps, 3sets], [triceps, 20kg, 10reps, 3sets]],


  Lower Body
  [[squats, 25kg, 10reps,3sets], [legraise,30kg, 10 reps, 3 sets] [calf, 10kg, 10reps, 3sets]]
  */
    ];

    // go through each workout

    for (int i = 0; i < workouts.length;) {
      List<Exercise> exercisesInWorkout = workouts[i].exercises;
      List<List<String>> individualWorkout = [];

      for (int j = 0; j < exercisesInWorkout.length; j++) {
        List<String> individualExercise = [];
        individualExercise.addAll([
          exercisesInWorkout[j].name,
          exercisesInWorkout[j].weight,
          exercisesInWorkout[j].reps,
          exercisesInWorkout[j].sets,
          exercisesInWorkout[j].isCompleted.toString(),
        ]);
        individualWorkout.add(individualExercise);
      }
      exerciseList.add(individualWorkout);
    }
    return exerciseList;
  }
}

// converts the exercises in a worksout object into a list of strings

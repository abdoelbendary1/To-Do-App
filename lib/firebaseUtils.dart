import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app1/model/task.dart';

class FireBaseUtils {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTaskToFireStore(Task task) {
    var taskCollectionRef = getTasksCollection();
    var taskDocRef = taskCollectionRef.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static Future<List<Task>> getAllTasks() async {
    //return list of querySnapshot
    QuerySnapshot<Task> data =
        await getTasksCollection().orderBy("dateTime").get();
    //return list of tasks
    List<Task> tasksList = data.docs.map((doc) => doc.data()).toList();
    return tasksList;
  }

  static Future<void> deleteTaskFromList(Task task) {
    return getTasksCollection().doc(task.id).delete();
  }
}

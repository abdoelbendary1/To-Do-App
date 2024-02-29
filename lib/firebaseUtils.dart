import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app1/model/task.dart';
import 'package:todo_app1/model/user.dart';

class FireBaseUtils {
  static CollectionReference<Task> getTasksCollection(String? uID) {
    return getUsersCollection()
        .doc(uID)
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTaskToFireStore(Task task, String? uID) {
    var taskCollectionRef = getTasksCollection(uID);
    var taskDocRef = taskCollectionRef.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static Future<List<Task>> getAllTasks(String? uID) async {
    //return list of querySnapshot
    QuerySnapshot<Task> data = await getTasksCollection(uID)
        .orderBy("dateTime", descending: true)
        .get();
    //return list of tasks
    List<Task> tasksList = data.docs.map((doc) => doc.data()).toList();
    return tasksList;
  }

  static Future<void> deleteTaskFromList(Task task, String? uID) {
    return getTasksCollection(uID).doc(task.id).delete();
  }

  // static Future<void> updateTaskFromList(Task task) {
  //   return getTasksCollection().doc(task.id).update({"title": task.title});
  // }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromJson(snapshot.data()),
          toFirestore: (user, options) => user.toJson(),
        );
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uID) async {
    var querySnapshot = await getUsersCollection().doc(uID).get();
    return querySnapshot.data();
  }
}

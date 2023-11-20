import 'package:firebasebase/model/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasebase/model/base_model.dart';

class HomeScreenController extends GetxController {
  var isLoading = false.obs;
  var wordLIst = <WordModel>[].obs;
  var isEdition = false.obs;
  var cardHeight = 100.0.obs;

  // Control de entrada de texto
  TextEditingController titleController = TextEditingController();
  TextEditingController meaningController = TextEditingController();
  var isNewRegister = false.obs;

  Future<void> getData() async  {
    try{
      QuerySnapshot words = await
          FirebaseFirestore.instance.collection('word_bank').orderBy('title').get();
      wordLIst.clear();
      words.docs.forEach((element) {
        wordLIst
        .add(WordModel(element['title'], element['meaning'], element.id));
        print(element.id);
      });
      isLoading.value = false;
    }
    catch (e) {
      Get.snackbar('Error', '${e.toString()}');
    }
  }
  // TODO 1: Create a function to add data to firebase
  Future<void> SendData()async {
    var collection = FirebaseFirestore.instance.collection('word_bank');
    WordModel someData = WordModel('Cemeneterio de mascota', 'meaning', 'id');
    collection.add(someData.toJson());
  }
  // TODO 2 : Create a function to add data to firebase
  Future<void>  updateData(String docId, WordModel model)async {
    var collection = FirebaseFirestore.instance.collection('word_bank');
    collection.doc(docId).update(model . toJson());
  }
  //Delete data
  Future<void>  deleteData(String docId)async {
    var collection = FirebaseFirestore.instance.collection('word_bank');
    collection.doc(docId).delete();
  }
}


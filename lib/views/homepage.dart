import 'package:firebasebase/controller/home_screen_controller.dart';
import 'package:firebasebase/model/base_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';



class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        initState: (_) {},
        builder: (homeScreenController) {
          homeScreenController.getData();
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed:(){
                homeScreenController.SendData();
                homeScreenController.wordLIst.refresh();
              },
              child: const Icon(Icons.add),
            ),

            appBar: AppBar(
              backgroundColor: Colors.yellow,
              title: Text("Firebase TEST"),
            ),
            body: Center(
              child: homeScreenController.isLoading.value == true
                  ? const CircularProgressIndicator()
                  : Obx(
                    () => ListView.separated(
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(
                                () => SizedBox(
                              height:
                              homeScreenController.cardHeight.value,
                              width: double.infinity,
                              child: Card(
                                color: Colors.deepOrangeAccent.shade100,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Text(homeScreenController
                                            .wordLIst[index].title!, style: TextStyle(fontSize: 24),),
                                        Text(homeScreenController
                                            .wordLIst[index].meaning!,style: TextStyle(fontSize: 24)),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Visibility(
                                      visible: homeScreenController
                                          .isEdition.value,
                                      child:  Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceAround,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Expanded(
                                              child: TextField(
                                                controller: homeScreenController.titleController,
                                                decoration: InputDecoration(
                                                    hintText:
                                                    "Update Title"),
                                              ),
                                            ),

                                            SizedBox(
                                              height: 10,
                                            ),
                                            Expanded(
                                              child: TextField(
                                                controller: homeScreenController.meaningController,
                                                decoration: InputDecoration(
                                                    hintText:
                                                    "Update Meaning"),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            FloatingActionButton(
                                                onPressed:() {
                                                  WordModel updateModel =
                                                  WordModel(homeScreenController.titleController.text,
                                                    homeScreenController.meaningController.text,
                                                    homeScreenController.wordLIst[index].id!,
                                                  );

                                                  homeScreenController.updateData(homeScreenController.wordLIst[index].id!,
                                                      updateModel);
                                                  homeScreenController.refresh();
                                                } ,
                                                child:const Icon(
                                                    Icons.update)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            homeScreenController.deleteData(
                                              homeScreenController.wordLIst[index].id!,
                                            );
                                            homeScreenController.refresh();
                                          },
                                          icon: const Icon(Icons.delete),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            homeScreenController.isEdition
                                                .toggle();
                                            homeScreenController
                                                .cardHeight.value =
                                            homeScreenController
                                                .isEdition.value
                                                ? 150
                                                : 100;

                                            print(homeScreenController
                                                .isEdition.value);
                                            // homeScreenController.updateData(
                                            //     homeScreenController
                                            //         .wordList[index].id);
                                          },
                                          icon: const Icon(Icons.update),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ));
                    },
                    separatorBuilder: (BuildContext context, index) {
                      return const Divider(
                          thickness: 2, color: Colors.black);
                    },
                    itemCount:
                    homeScreenController.wordLIst.value.length),
              ),
            ),
          );
        });
  }
}
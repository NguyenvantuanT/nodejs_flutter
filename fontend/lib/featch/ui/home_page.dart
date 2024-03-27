import 'package:flutter/material.dart';
import 'package:fontend/featch/Repo/repos.dart';
import 'package:fontend/featch/components/my_alertdialog.dart';
import 'package:fontend/featch/components/my_textbutton.dart';
import 'package:fontend/featch/ui/search_page.dart';
import 'package:fontend/model/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Repo repo = Repo();

  final TextEditingController userController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController updateAgeController = TextEditingController();
  final TextEditingController updateUserController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UserConnect"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SearchPage())),
              icon: const Icon(Icons.search))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return MyAlertDialog(
                title: "Add new user",
                userController: userController,
                ageController: ageController,
                action: [
                  MyTextButton(
                    text: "Cancel",
                    onPressed: () => Navigator.pop(context),
                  ),
                  MyTextButton(
                    text: "Yes",
                    onPressed: () async {
                      Navigator.pop(context);
                      final object = UserModel(
                          name: userController.text, age: ageController.text);
                      await repo.postUser(object);
                      setState(() {
                        userController.clear();
                        ageController.clear();
                      });
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: repo.getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return ListTile(
                  title: Text(user.name ?? ""),
                  subtitle: Text('Age: ${user.age}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: IconButton(
                          onPressed: () {
                            repo.deleteUser(user.id.toString());
                            setState(() {});
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ),
                      Container(
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return MyAlertDialog(
                                  title: "Update User",
                                  userController: updateUserController,
                                  ageController: updateAgeController,
                                  action: [
                                    MyTextButton(
                                      text: "Cancel",
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    MyTextButton(
                                      text: "Yes",
                                      onPressed: () async {
                                        final object = UserModel(
                                          name: updateUserController.text,
                                          age: updateAgeController.text,
                                        );
                                        await repo.updateUser(
                                            user.id.toString(), object);
                                        setState(() => Navigator.pop(context));
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          if (snapshot.hasError) {
            return const SizedBox(
              child: Center(
                child: Text("error"),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

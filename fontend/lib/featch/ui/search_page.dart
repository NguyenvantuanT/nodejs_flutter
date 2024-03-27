import 'package:flutter/material.dart';
import 'package:fontend/featch/Repo/repos.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final Repo repo = Repo();

  final TextEditingController searchAgeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search user"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: searchAgeController,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int age = int.tryParse(searchAgeController.text.trim()) ?? 0;
                if (age != 0) {
                  repo.searchUser(age);
                }
                setState(() {});
              },
              child: const Icon(Icons.search),
            ),
            const SizedBox(height: 20),
            FutureBuilder(
              future: repo.searchUser(
                  int.tryParse(searchAgeController.text.trim()) ?? 21),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Đã xảy ra lỗi: ${snapshot.error}');
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final data = snapshot.data![index];
                        return ListTile(
                          title: Text(data.name ?? ""),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

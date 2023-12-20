import 'package:flutter/material.dart';

import '../models/products.dart';
import '../networks/api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Products>> postsProducts = API().getAllProducts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.amber,
      body: Center(
        child: FutureBuilder<List<Products>>(
          future: postsProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final posts = snapshot.data!;
              return buildPosts(posts);
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }
}

Widget buildPosts(List<Products> posts) {
  return GridView.builder(
    itemCount: posts.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    scrollDirection: Axis.vertical,
    itemBuilder: (context, index) {
      final post = posts[index];
      return Card(
        elevation: 0,
        color: Colors.white,
        child: Image.network(post.image),

        // color: Colors.grey.shade300,
        // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        // padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        // height: 100,
        // width: double.maxFinite,
        // child: Column(
        //   children: [
        //     Expanded(flex: 1, child: Image.network(post.image)),
        //     const SizedBox(width: 10),
        //     Expanded(flex: 3, child: Text(post.title)),
        //   ],
        // ),
      );
    },
  );
  // return ListView.builder(
  //   itemCount: posts.length,
  //   itemBuilder: (context, index) {
  // final post = posts[index];
  // return Container(
  //   color: Colors.grey.shade300,
  //   margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
  //   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  //   height: 100,
  //   width: double.maxFinite,
  //   child: Row(
  //     children: [
  //       Expanded(flex: 1, child: Image.network(post.image)),
  //       const SizedBox(width: 10),
  //       Expanded(flex: 3, child: Text(post.title)),
  //     ],
  //   ),
  // );
  //   },
  // );
}

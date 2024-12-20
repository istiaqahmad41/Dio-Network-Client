import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(dia_network_93_demo());
}

//sample 1 dio network client--->>
/*
class dia_network_93_demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Dio dio = Dio();
  String responseData = 'No data fetched yet';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Method to fetch data using Dio
  Future<void> fetchData() async {
    try {
      final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
      setState(() {
        responseData = response.data.toString();
      });
    } catch (e) {
      setState(() {
        responseData = 'Failed to fetch data: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dio GET Request Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(responseData),
        ),
      ),
    );
  }
}

*/
//-------listview load



class dia_network_93_demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dio List Example',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Dio dio = Dio();
  List<dynamic> posts = []; // To store the fetched list of posts
  bool isLoading = true;    // To indicate loading state

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Method to fetch data from the API
  Future<void> fetchData() async {
    try {
      Response response = await dio.get('https://jsonplaceholder.typicode.com/posts');
      setState(() {
        posts = response.data;  // Assign response data to the list
        isLoading = false;      // Stop loading
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dio List and Cards'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())  // Show a loading indicator while fetching data
          : ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostCard(post: posts[index]);  // Custom Card for each post
        },
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final dynamic post;

  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              post['title'],
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              post['body'],
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
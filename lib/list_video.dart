import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListVideo extends StatefulWidget {
  const ListVideo({super.key, required this.title});

  final String title;

  @override
  State<ListVideo> createState() => _ListVideoState();
}

class _ListVideoState extends State<ListVideo> {
  var data = <dynamic>[];

  @override
  void initState() {
    super.initState();
    getListVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            var item = data[index];
            return Container(
              child: Column(
                children: [
                  Image.network(item['videoThumbnails'][0]['url']),
                  Text(item['title']),
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: getListVideo,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Future<void> getListVideo() async {
    var url = Uri.https('youtube138.p.rapidapi.com', 'v2/trending');
    var response = await http.get(url, headers: {
      'x-rapidapi-host': 'youtube138.p.rapidapi.com',
      'x-rapidapi-key': '9b3fd0a0a3msh833ceaa9072e913p1662cdjsn5657ac089d9c'
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    data.clear();
    data.addAll(jsonDecode(response.body)['list']);
    setState(() {

    });
  }
}

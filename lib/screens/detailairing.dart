import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class DetailAiring extends StatefulWidget {
  final int item;
  final String anime;
  const DetailAiring({Key? key, required this.item, required this.anime})
      : super(key: key);

  @override
  State<DetailAiring> createState() => _DetailAiringState();
}

class _DetailAiringState extends State<DetailAiring> {
  late Future<AiringItem> detailEpisodes;

  @override
  void initState() {
    super.initState();
    detailEpisodes = fetchAiringItem(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.cyan[300], title: Text(widget.anime)),
      body: SingleChildScrollView(
        child: FutureBuilder<AiringItem>(
            future: detailEpisodes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            snapshot.data!.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Score: ${snapshot.data!.score}',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Broadcast: ${snapshot.data!.broadcast}',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[600]),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Text(
                              snapshot.data!.synopsis,
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.justify,
                            )
                          ],
                        ),
                      ),
                    ]);
              } else if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong :('));
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}

class AiringItem {
  final int mal_id;
  final String title;
  final String synopsis;
  final String image;
  final num score;
  final String broadcast;

  AiringItem(
      {required this.mal_id,
      required this.title,
      required this.synopsis,
      required this.image,
      required this.score,
      required this.broadcast});

  factory AiringItem.fromJson(Map<String, dynamic> json) {
    return AiringItem(
        mal_id: json['mal_id'],
        title: json['title'],
        synopsis: json['synopsis'],
        image: json['image_url'],
        score: json['score'],
        broadcast: json['broadcast']);
  }
}

Future<AiringItem> fetchAiringItem(id) async {
  final response =
      await http.get(Uri.parse('https://api.jikan.moe/v3/anime/$id'));

  if (response.statusCode == 200) {
    var synopsisJson = jsonDecode(response.body);
    return AiringItem.fromJson(synopsisJson);
  } else {
    throw Exception('Failed to load episodes');
  }
}

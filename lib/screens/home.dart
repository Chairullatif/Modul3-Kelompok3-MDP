import 'package:flutter/material.dart';
import 'package:mod3_kel03/screens/detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mod3_kel03/screens/about.dart';
import 'package:mod3_kel03/screens/detailairing.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Show>> shows;
  late Future<List<AiringShow>> airingshows;

  @override
  void initState() {
    super.initState();
    shows = fetchShows();
    airingshows = fetchAiringShows();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[300],
        title: const Text('Anime List'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const About()));
              },
              icon: const Icon(
                Icons.group,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 20,
            alignment: Alignment.center,
            child: const Text("Top Airing", textAlign: TextAlign.center),
          ),
          SizedBox(
            width: double.infinity,
            child: FutureBuilder(
              builder: (context, AsyncSnapshot<List<AiringShow>> snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: 250,
                    child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) => Card(
                              color: Colors.white,
                              child: InkWell(
                                child: Container(
                                  height: 200,
                                  width: 150,
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Image.network(
                                            snapshot.data![index].airimageUrl,
                                            height: 200,
                                            width: 150,
                                            fit: BoxFit.cover,
                                            alignment: Alignment.topCenter,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(6),
                                            height: 170,
                                            width: 150,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Opacity(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                          .grey[
                                                                      700]),
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                Icons.star,
                                                                size: 20,
                                                                color: Colors
                                                                    .yellow,
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Center(
                                                                child: Text(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .airscore
                                                                      .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      opacity: 0.7,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                          snapshot.data![index].airtitle,
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailAiring(
                                                item: snapshot
                                                    .data![index].airmalId,
                                                anime: snapshot
                                                    .data![index].airtitle,
                                              )));
                                },
                              ),
                            )),
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong :('));
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              future: airingshows,
            ),
          ),
          Container(
            width: double.infinity,
            height: 20,
            alignment: Alignment.center,
            child: Text("Top Anime of All Time", textAlign: TextAlign.center),
          ),
          Expanded(
            child: FutureBuilder(
              builder: (context, AsyncSnapshot<List<Show>> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(snapshot.data![index].imageUrl),
                            ),
                            title: Text(snapshot.data![index].title),
                            subtitle:
                                Text('Score: ${snapshot.data![index].score}'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                      item: snapshot.data![index].malId,
                                      title: snapshot.data![index].title),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong :('));
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              future: shows,
            ),
          )
        ],
      ),
    ));
  }
}

class Show {
  final int malId;
  final String title;
  final String imageUrl;
  final double score;

  Show({
    required this.malId,
    required this.title,
    required this.imageUrl,
    required this.score,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      malId: json['mal_id'],
      title: json['title'],
      imageUrl: json['image_url'],
      score: double.parse(json['score'].toString()),
    );
  }
}

Future<List<Show>> fetchShows() async {
  final response =
      await http.get(Uri.parse('https://api.jikan.moe/v3/top/anime/1'));

  if (response.statusCode == 200) {
    var topShowsJson = jsonDecode(response.body)['top'] as List;
    return topShowsJson.map((show) => Show.fromJson(show)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}

class AiringShow {
  final int airmalId;
  final String airtitle;
  final String airimageUrl;
  final num airscore;

  AiringShow({
    required this.airmalId,
    required this.airtitle,
    required this.airimageUrl,
    required this.airscore,
  });

  factory AiringShow.fromJson(Map<String, dynamic> json) {
    return AiringShow(
      airmalId: json['mal_id'],
      airtitle: json['title'],
      airimageUrl: json['image_url'],
      airscore: json['score'],
    );
  }
}

Future<List<AiringShow>> fetchAiringShows() async {
  final response =
      await http.get(Uri.parse('https://api.jikan.moe/v3/top/anime/1/airing'));

  if (response.statusCode == 200) {
    var topShowsJson = jsonDecode(response.body)['top'] as List;
    return topShowsJson.map((showair) => AiringShow.fromJson(showair)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart';

import 'package:walmax/models/photo.dart';
import 'package:walmax/models/topic.dart';
import 'package:walmax/screens/photos_details_screen.dart';
import 'package:walmax/utilities/config.dart';
import 'package:http/http.dart' as http;

class TopicListScreen extends StatefulWidget {
  final String title;

  const TopicListScreen({Key? key, required this.title}) : super(key: key);

  @override
  _TopicListScreenState createState() => _TopicListScreenState();
}

class _TopicListScreenState extends State<TopicListScreen> {
  late StreamController topicStreamContoller;
  late Stream topicStream;
  var selectedIndex = 0;
  late StreamController _photoUrlStreamContoller;
  late Stream _photoUrlStream;

    getsPhotoUrl(String photoUrls)async {
String finalResult= Config.getAllPhotos(photoUrls);
       Response response= await http.get(Uri.parse(finalResult));
       _photoUrlStreamContoller.add('loading');
       if (response.statusCode == 200) {
         var jsonData = json.decode(response.body);
         List<PhotoUrl> photoUrlsList = [];
         for (var jsonPhotoUrl in jsonData) {
           PhotoUrl  photoUrl = PhotoUrl.formMap(jsonPhotoUrl);
           photoUrlsList.add(photoUrl);
         }

         _photoUrlStreamContoller.add(photoUrlsList);

       } else {
         _photoUrlStreamContoller.add('wrong');
       }
  }

  getAllTopic() async {
    Response response = await http.get(Uri.parse(Config.topicUrl));
    topicStreamContoller.add('loading');
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<Topic> topicsList = [];
      for (var jsonTopic in jsonData) {
        Topic topic = Topic.formMap(jsonTopic);
        topicsList.add(topic);
      }

      topicStreamContoller.add(topicsList);
      getsPhotoUrl(topicsList[0].photos);
    } else {
      topicStreamContoller.add('wrong');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topicStreamContoller = StreamController();
    topicStream = topicStreamContoller.stream;

    topicStreamContoller.add('loading');
    _photoUrlStreamContoller = StreamController();
    _photoUrlStream = _photoUrlStreamContoller.stream;

    getAllTopic();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0x0f0e0023),
            Color(0xff3a1e54),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.white,fontSize: 24,letterSpacing: 2,wordSpacing: 2,),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(

                colors: [
                  // ignore: use_full_hex_values_for_flutter_colors
                  Color(0xf0e0023),
                  Color(0xff3a1e54),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Trending Topics',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,letterSpacing: 2,wordSpacing: 2,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 45,
                child: StreamBuilder(
                  stream: topicStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == 'loading') {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.data == 'wrong') {
                        return const Center(
                          child: Text('something went"t wrong'),
                        );
                      } else {
                        List<Topic> topics = snapshot.data as List<Topic>;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: topics.length,
                          itemBuilder: (context, index) {

                            Topic topic = topics[index];
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;


                                });
                                getsPhotoUrl(topic.photos);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                margin: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                  color: selectedIndex == index
                                      ? Colors.white
                                      : Colors.black,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(
                                  child: Text(
                                    topic.title,
                                    style: TextStyle(
                                      color: selectedIndex == index
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Photo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,letterSpacing: 2,wordSpacing: 2,
                ),
              ),const SizedBox(
                height: 13,
              ),
                Expanded(child: StreamBuilder(
                  stream: _photoUrlStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == 'loading') {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.data == 'wrong') {
                        return const Center(
                          child: Text('something went"t wrong'),
                        );
                      } else {
                        List<PhotoUrl> photoUrls = snapshot.data as List<PhotoUrl>;
                        return  GridView.builder(
                          itemCount: photoUrls.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 7/10,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ), itemBuilder: (context, index) {

                          PhotoUrl photoUrl=photoUrls[index];
                          return InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                return PhotoScreen(photoUrl: photoUrl,);
                              },));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(photoUrl.thumb),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          );
                        },);
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),),
            ],
          ),
        ),
      ),
    );
  }
}

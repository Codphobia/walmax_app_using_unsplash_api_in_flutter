import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:walmax/models/photo.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
class PhotoScreen extends StatefulWidget {
  final PhotoUrl photoUrl;

  const PhotoScreen({Key? key, required this.photoUrl}) : super(key: key);

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  int radioValue = 0;

  onChanged(value)  {
    setState(() async {
      radioValue = value;
      switch (radioValue) {
        case 0:


          File cachedImage = await DefaultCacheManager().getSingleFile(widget.photoUrl.regular);  //image file

          int location = WallpaperManagerFlutter.HOME_SCREEN;  //Choose screen type

          WallpaperManagerFlutter().setwallpaperfromFile(cachedImage, location);
          Future.delayed(Duration.zero,(){
          Navigator.of(context).pop();
          });

          break;
        case 1:
          File cachedImage = await DefaultCacheManager().getSingleFile(widget.photoUrl.regular);  //image file

          int location = WallpaperManagerFlutter.LOCK_SCREEN;  //Choose screen type

          WallpaperManagerFlutter().setwallpaperfromFile(cachedImage, location);
          Future.delayed(Duration.zero,(){
            Navigator.of(context).pop();
          });
          break;
        case 2:
          File cachedImage = await DefaultCacheManager().getSingleFile(widget.photoUrl.regular);  //image file

          int location = WallpaperManagerFlutter.BOTH_SCREENS;  //Choose screen type

          WallpaperManagerFlutter().setwallpaperfromFile(cachedImage, location);
          Future.delayed(Duration.zero,(){
            Navigator.of(context).pop();
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Image.network(
            widget.photoUrl.regular,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            bottom: 100,
            right: 20,
            left: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                    onPressed: () async {
                      bool? result = await GallerySaver.saveImage(widget.photoUrl.full + '.jpg');
                      if (result != null && result == true) {
                        Fluttertoast.showToast(msg: 'Image download');
                      } else {
                        Fluttertoast.showToast(
                            gravity: ToastGravity.SNACKBAR,
                            msg: 'failed');
                      }
                    },
                    child: const Text(
                      'Download',
                      style: TextStyle(color: Colors.white),
                    )),
                OutlinedButton(
                    onPressed: () {
                      showDialog(

                        context: context,
                        builder: (context) {
                          return Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  // ignore: use_full_hex_values_for_flutter_colors
                                  Color(0xf0e0023),
                                  Color(0xff3a1e54),
                                ],
                              ),
                            ),
                            child: AlertDialog(

                              backgroundColor: Colors.transparent,
                              elevation: 0.3,
                              title: const Center(
                                  child: Text('Select as you want zargyea')),
                              actions: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Radio<int>(
                                            value: 0,
                                            groupValue: radioValue,
                                            onChanged: (onChanged)),
                                        Radio<int>(
                                            value: 1,
                                            groupValue: radioValue,
                                            onChanged: (onChanged)),
                                        Radio<int>(
                                            value: 2,
                                            groupValue: radioValue,
                                            onChanged: (onChanged)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Home Screen'),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Lock Screen'),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Both Screen'),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                      setState(() {});
                    },
                    child: const Text(
                      'Set as Wallpaper',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ))
      ],
    );
  }
}

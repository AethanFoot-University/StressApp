import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:stress_app/data/StressLevel.dart';
import 'package:stress_app/tools/unsplash_key.dart';
import 'package:unsplash_api_dart/http.dart';
import 'package:unsplash_api_dart/models/photo.dart';
import 'package:unsplash_api_dart/models/search_photo_result.dart';
import 'package:unsplash_api_dart/unsplash_api_dart.dart';

class  UnsplashGrabber {

    static Future<NetworkToFileImage> GetRandom(String seed) async {
    Unsplash(accessKey: UnsplashKey.accessKey, secret: UnsplashKey.secret, timeout: 0);
    try {

      SearchPhotoResult result = await searchResult(
        clientId: UnsplashKey.accessKey,
        query: 'android',
        page: 1,
      );

      var photo = result.results[Random().nextInt(result.results.length)];

      return NetworkToFileImage(url: photo.urls.regular);

    } catch(e){
      print("Image Grab Failed");
      return null;
    }
  }


    static Widget generateWidget(String seed, String defaultAsset){
      return FutureBuilder<NetworkToFileImage>(
        future: UnsplashGrabber.GetRandom(seed),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Image(image: snapshot.data, fit: BoxFit.fitHeight,);
          } else {
            return Image.asset(
              defaultAsset,
              fit: BoxFit.fitHeight,
            );
          }
        },
      );
  }

}
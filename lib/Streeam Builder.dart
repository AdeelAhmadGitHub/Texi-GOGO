import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'GiftData.dart';

class PeriodicRequester extends StatefulWidget {
  @override
  State<PeriodicRequester> createState() => _PeriodicRequesterState();
}

class _PeriodicRequesterState extends State<PeriodicRequester> {
  GiftData? giftData;
  Stream<http.StreamedResponse> getRandomNumberFact() async* {
    yield* Stream.periodic(Duration(seconds: 10), (_) async {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer 159|xgMcWZ5pa2PRHCMhu5d6ii5UIrBkoCohi8K9y0Pk'
      };
      var request = http.Request(
          'GET',
          Uri.parse(
              'https://memboa.org/api/get-banner?type=Store'));

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      giftData=GiftData.fromJson(jsonDecode(await response.stream.bytesToString()));
print(giftData);
      return response;

    }).asyncMap((event) async {
      print("?????????????????");
      return  event;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<http.StreamedResponse>(
        stream: getRandomNumberFact(),
        builder: (context, snapshot)    {
print("ggggggg");
          if(snapshot.hasData){
            return Center(child: Text(jsonEncode(giftData)));
          }else{
            return  Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

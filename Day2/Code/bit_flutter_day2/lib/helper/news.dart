import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:bit_flutter_day2/models/article_model.dart';
import 'package:http/http.dart' as http;


class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async{

    String url = "https://newsapi.org/v2/everything?q=tesla&from=2022-03-29&sortBy=publishedAt&apiKey=d16956678087411aa11b3a1435cadb09";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element["description"] != null){
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content']
          );
          news.add(articleModel);
        }
      });
    }
  }
}



import 'package:bit_flutter_day2/helper/data.dart';
import 'package:bit_flutter_day2/helper/news.dart';
import 'package:bit_flutter_day2/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:bit_flutter_day2/models/category_model.dart';

class Home extends StatefulWidget {
  //const Home({Key? key}) : super(key: key);


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("BIT"),
            Text("News", style: TextStyle(color: Colors.redAccent),)
          ],
        ),
        elevation: 0.0,
      ),

      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) :



      SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[

              /// Categories
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 70,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                      child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                          return CategoryTile(
                            imageUrl: categories[index].imageUrl,
                            categoryName: categories[index].categoryName,
                          );
                        }),
                      ),
                  ],
                ),
              ),


              /// Blogs
              Container(
                padding: EdgeInsets.only(top: 16),
                child: ListView.builder(
                  itemCount: articles.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index){
                    return BlogTile(
                        imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

class CategoryTile extends StatelessWidget {
  //const CategoryTile({Key? key}) : super(key: key);

  final imageUrl, categoryName;
  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl, width: 120, height: 60, fit: BoxFit.cover,),
            ),
            Container(
              alignment: Alignment.center,
              width: 120, height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26
              ),
              child: Text(categoryName, style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600
              ),),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  //const BlogTile({Key? key}) : super(key: key);

  final String imageUrl, title, desc;

  BlogTile({@required this.imageUrl, @required this.title, @required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl)
          ),
          SizedBox(height: 8,),
          Text(title, style: TextStyle(
            fontSize: 17,
            color: Colors.redAccent
          ),),
          Text(desc, style: TextStyle(
            color: Colors.black54
          ),)
        ],
      ),
    );
  }
}



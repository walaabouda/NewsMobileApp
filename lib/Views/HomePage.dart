import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:projet_wala_soa/Helper/CategoryData.dart';
import 'package:projet_wala_soa/Helper/NewsData.dart';
import 'package:projet_wala_soa/Model/CategoryModel.dart';
import 'package:projet_wala_soa/Model/NewsModel.dart';
import 'package:projet_wala_soa/Views/CategoryPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // get our categories list

  List<CategoryModel> categories = [];

  // get our newslist first

  List<ArticleModel> articles = [];
  bool _loading = true;

  getNews() async {
    News newsdata = News();
    await newsdata.getNews();
    articles = newsdata.datatobesavedin;
    setState(() {
      _loading = false;
    });


  }


  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // this is to bring the row text in center
          children: <Widget>[

            Text("World ",
              style: TextStyle(
                  color: Colors.black
              ),
            ),

            Text("News",
              style: TextStyle(
                  color: Colors.blueAccent
              ),
            ),

          ],
        ),
      ),


      // category widgets
      body: _loading ? Center(
        child: CircularProgressIndicator(

        ),

      ): SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(

            children: <Widget>[
              Container(
                height: 70.0,
                padding: EdgeInsets.symmetric(horizontal: 12.0),

                child: ListView.builder(

                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                    );
                  },

                ),
              ),

              Container(
                child: ListView.builder(
                  itemCount:  articles.length,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true, // add this otherwise an error
                  itemBuilder: (context, index) {

                    return NewsTemplate(
                      urlToImage: articles[index].urlToImage,
                      title: articles[index].title,
                      description: articles[index].description,
                    );


                  } ,
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
  final String categoryName, imageUrl;
  CategoryTile({this.categoryName = '', this.imageUrl = ''});



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryFragment(
            category: categoryName.toLowerCase(),
          ),
        ));

      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[


            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(imageUrl: imageUrl, width: 170, height: 90, fit: BoxFit.cover,)),


            Container(
              alignment: Alignment.center,
              width: 170, height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,


              ),
              child: Text(categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),),
            ),

          ],
        ),
      ),
    );
  }
}

// creating template for news

class NewsTemplate extends StatelessWidget {

  String title, description, url, urlToImage;
  NewsTemplate({this.title = '',
    this.description = '',
    this.url = '',
    this.urlToImage = '',});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(

        children: <Widget>[

          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(imageUrl: urlToImage, width: 380, height: 200, fit: BoxFit.cover,)),

          SizedBox(height: 8),

          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black),),

          SizedBox(height: 8),

          Text(description, style: TextStyle( fontSize: 15.0, color: Colors.grey[800]),),





        ],



      ),
    );
  }
}
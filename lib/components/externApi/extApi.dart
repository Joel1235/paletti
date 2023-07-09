import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/Article.dart';
import '../../services/apiService.dart';
import 'extApi_responsive.dart';

class ExtApi extends StatefulWidget {
  @override
  _ExtApi createState() => _ExtApi();
}

class _ExtApi extends State<ExtApi> {
  List<Article> _articles = [];

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  _fetchArticles() async {
    //get Articles
    List<Article> articles =
        await ApiService().fetchArticlesBySection('automobiles');
    setState(() {
      _articles = articles;
    });
  }

  _buildArticlesGrid(MediaQueryData mediaQuery) {
    //articles are shown in Grid
    List<GridTile> tiles = [];
    _articles.forEach((article) {
      tiles.add(_buildArticleTile(article, mediaQuery));
    });
    return Padding(
      padding: responsivePadding(mediaQuery),
      child: GridView.count(
        crossAxisCount: responsiveNumGridTiles(mediaQuery),
        mainAxisSpacing: 30.0,
        crossAxisSpacing: 30.0,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: tiles,
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _buildArticleTile(Article article, MediaQueryData mediaQuery) {
    return GridTile(
      child: GestureDetector(
        onTap: () => _launchURL(article.url),
        child: Column(
          children: <Widget>[
            Container(
              height: responsiveImageHeight(mediaQuery),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                image: DecorationImage(
                  image: NetworkImage(article.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.center,
              height: responsiveTitleHeight(mediaQuery),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 1),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Text(
                article.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Externe API'),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 80.0),
          Center(
            child: Text(
              'Aktuelle Artikel der Branche',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
          SizedBox(height: 15.0),
          _articles.length > 0
              ? _buildArticlesGrid(mediaQuery)
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }
}

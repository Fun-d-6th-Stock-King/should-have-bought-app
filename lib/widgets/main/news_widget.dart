import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/constant.dart';
import 'package:should_have_bought_app/models/calculator/news_article.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/screens/util/skeleton_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsWidget extends StatefulWidget {
  @override
  _NewsWidgetState createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  void didChangeDependencies() async {
    await Provider.of<CalculatorProvider>(context, listen: false)
        .getHeadliens();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
        builder: (context, calculatorProvider, child) {
      final List<NewsArticle> headlineNews = calculatorProvider.headlineList;
      return headlineNews == null
          ? skeletonText(double.infinity, 280)
          : Container(
              height: 280,
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: 3,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20);
                },
                itemBuilder: (context, index) {
                  return NewsItem(newsItem: headlineNews[index]);
                },
              ),
            );
    });
  }
}

class NewsItem extends StatelessWidget {
  final NewsArticle newsItem;

  const NewsItem({this.newsItem});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await canLaunch(Uri.parse(newsItem.url).toString())
            ? launch(newsItem.url, enableJavaScript: true)
            : throw ('Could not launch ${newsItem.url}');
      },
      child: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  newsItem.company,
                  style: kNewsTitleStyle,
                ),
                SizedBox(
                  width: 215,
                  child: Text(
                    newsItem.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            newsItem.urlToImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      newsItem.urlToImage,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

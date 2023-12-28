import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/pages/net_article/api/article_api.dart';
import 'package:flutter_practice/pages/net_article/views/article_detail_page.dart';

import '../model/article.dart';

class ArticleContent extends StatefulWidget {
  const ArticleContent({Key? key}) : super(key: key);

  @override
  State<ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  List<Article> _articles = [];
  ArticleApi api = ArticleApi();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    print('===start-loadNetWorkData===');
    _loading = true;
    setState(() {});
    _articles = await api.loadArticles(0);
    _loading = false;
    setState(() {});
    print('===finish-loadNetWorkData===');
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
        child: Wrap(
          spacing: 10,
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            CupertinoActivityIndicator(),
            Text(
              "数据加载中，请稍后……",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }
    return EasyRefresh(
      header: const ClassicHeader(
        dragText: "下拉加载",
        armedText: "释放刷新",
        readyText: "开始加载",
        processingText: "正在加载",
        processedText: "刷新成功",
      ),
      onRefresh: _onRefresh,
      onLoad: _onLoad,
      child: ListView.builder(
        itemCount: _articles.length,
        itemBuilder: _buildItemByIndex,
      ),
    );
  }

  void _onRefresh() async {
    _articles = await api.loadArticles(0);
    setState(() {});
  }

  void _onLoad() async {
    int nextPage = _articles.length ~/ 20;
    List<Article> newArticles = await api.loadArticles(nextPage);
    _articles = _articles + newArticles;
    setState(() {});
  }

  Widget _buildItemByIndex(BuildContext context, int index) {
    return ArticleItem(
      article: _articles[index],
      onTap: _jumpToPage,
    );
  }

  void _jumpToPage(Article article) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ArticleDetailPage(article: article),
      ),
    );
  }
}

class ArticleItem extends StatelessWidget {
  final Article article;
  final ValueChanged<Article> onTap;

  const ArticleItem({
    Key? key,
    required this.article,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(article),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    article.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  article.time,
                  style: const TextStyle(color: Colors.black38, fontSize: 12),
                )
              ],
            ),
            const SizedBox(height: 4),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                article.url,
                style: const TextStyle(color: Colors.black38, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

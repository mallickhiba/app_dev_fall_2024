import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_course_2/bloc/news_bloc_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsBloc = BlocProvider.of<NewsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('news.png', height: 30),
            SizedBox(width: 10),
            Text('News App'),
          ],
        ),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsInitial) {
            newsBloc.add(FetchNews());
            return Center(child: Text('Fetching news...'));
          } else if (state is NewsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NewsLoaded) {
            return ListView.builder(
              itemCount: state.news.length,
              itemBuilder: (context, index) {
                final article = state.news[index];
                return NewsTile(article: article);
              },
            );
          } else if (state is NewsError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Container();
        },
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final dynamic article;

  NewsTile({required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: () => showModalBottomSheet(
          context: context,
          builder: (context) => NewsDetailModal(article: article),
        ),
        child: ListTile(
          leading: article['urlToImage'] != null
              ? Image.network(article['urlToImage'],
                  width: 50, fit: BoxFit.cover)
              : Icon(Icons.image),
          title: Text(article['title'] ?? 'No Title'),
          subtitle: Text(article['author'] ?? 'Unknown'),
          trailing: Text(article['publishedAt']?.split('T')[0] ?? ''),
        ),
      ),
    );
  }
}

class NewsDetailModal extends StatelessWidget {
  final dynamic article;

  NewsDetailModal({required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          article['urlToImage'] != null
              ? Image.network(article['urlToImage'])
              : Icon(Icons.image, size: 100),
          SizedBox(height: 10),
          Text(article['title'] ?? 'No Title',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(article['author'] ?? 'Unknown'),
          SizedBox(height: 10),
          Text(article['description'] ?? 'No Description'),
          Text(article['content'] ?? 'No Content'),
          SizedBox(height: 10),
          Text(
              'Published: ${article['publishedAt']?.split('T')[0] ?? 'Unknown'}'),
          ElevatedButton(
            onPressed: () => launchUrl(Uri.parse(article['url'])),
            child: Text('View Article'),
          ),
        ],
      ),
    );
  }
}

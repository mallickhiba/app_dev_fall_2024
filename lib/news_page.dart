import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_course_2/bloc/news_bloc_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final newsBloc = BlocProvider.of<NewsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Headline News',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                Text('Read Top News Today',
                    style: TextStyle(color: Colors.black, fontSize: 12)),
              ],
            ),
            Spacer(),
            Icon(Icons.newspaper, color: Colors.black),
          ],
        ),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsInitial) {
            newsBloc.add(FetchNews());
            return const Center(child: Text('Fetching news...'));
          } else if (state is NewsLoading) {
            return const Center(child: CircularProgressIndicator());
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

  const NewsTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 141, 69, 69).withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        child: InkWell(
          onTap: () => showModalBottomSheet(
            context: context,
            builder: (context) => NewsDetailModal(article: article),
          ),
          child: ListTile(
            leading: article['urlToImage'] != null
                ? Image.network(
                    article['urlToImage'],
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image,
                          size: 80); // Fallback Icon
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child; // Image loaded successfully
                      }
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey,
                        ),
                      );
                    },
                  )
                : const Icon(Icons.image, size: 60),
            title: Text(article['title'] ?? 'No Title'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(article['author'] ?? 'Unknown Author'),
                Text(article['publishedAt']?.split('T')[0] ?? ''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewsDetailModal extends StatelessWidget {
  final dynamic article;

  const NewsDetailModal({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(article['title'] ?? 'No Title',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(article['author'] ?? 'Unknown Author',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            Text(
                'Published: ${article['publishedAt']?.split('T')[0] ?? 'Unknown'}'),
            const SizedBox(height: 10),
            article['urlToImage'] != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      article['urlToImage'],
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image,
                            size: 100); // Fallback Icon
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  )
                : const Icon(Icons.image, size: 100),
            const SizedBox(height: 10),
            Text(article['description'] ?? 'No description is available',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(article['content'] ?? 'No additional content is available'),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () => launchUrl(Uri.parse(article['url'])),
                child: const Text('View Article'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

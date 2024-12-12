import 'package:flutter/material.dart';
import 'package:flutter_news_app/data/datasources/news_remote_datasource.dart';
import 'package:flutter_news_app/ui/provider/news_provider.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // context.read<NewsProvider>().getNews();
  }

  void onSearch() {
    context.read<NewsProvider>().getSearchNews(searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                label: const Text('Search'),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed: onSearch, icon: const Icon(Icons.search)),
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: Consumer<NewsProvider>(builder: (context, state, child) {
              if (state.state.status == StateEnum.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.articles.isEmpty) {
                return const Center(
                  child: Text('No Data'),
                );
              }

              final listArticle = state.articles;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            listArticle[index].urlToImage ??
                                'https://via.placeholder.com/600/121fa4'),
                      ),
                      title: Text(listArticle[index].title ?? ''),
                    ),
                  );
                },
                itemCount: listArticle.length,
              );
            }),
          ),
        ],
      ),
    );
  }
}

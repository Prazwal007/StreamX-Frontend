import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../theme/app_theme.dart';
import '../components/categories_sidebar.dart';

class CategoryFilesPage extends StatelessWidget {
  final String category;
  final String title;

  const CategoryFilesPage({
    super.key,
    required this.category,
    required this.title,
  });

  Future<List<Map<String, dynamic>>> _fetchFiles() async {
    final uri = Uri.parse(
      'http://127.0.0.1:8000/files?category=$category',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load files');
    }

    final List data = jsonDecode(response.body);
    return data.cast<Map<String, dynamic>>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      body: SafeArea(
        child: Row(
          children: [
            const CategoriesSidebar(),
            const VerticalDivider(width: 1),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: _fetchFiles(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              snapshot.error.toString(),
                              style:
                                  const TextStyle(color: Colors.redAccent),
                            ),
                          );
                        }

                        final files = snapshot.data!;

                        if (files.isEmpty) {
                          return const Center(child: Text('No files found'));
                        }

                        return ListView.separated(
                          padding: const EdgeInsets.all(12),
                          itemCount: files.length,
                          separatorBuilder: (_, __) =>
                              const Divider(color: Colors.white12),
                          itemBuilder: (context, index) {
                            final file = files[index];
                            return ListTile(
                              title: Text(file['name']),
                              subtitle: Text(file['path']),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/download_task.dart';

class DownloadsController extends ChangeNotifier {
  final List<DownloadTask> downloads = [];

  static const String httpBase = 'http://127.0.0.1:8000';

  Timer? _pollingTimer;

  Future<void> init() async {
    await refresh();
    _startPolling();
  }

  void _startPolling() {
    _pollingTimer?.cancel();

    _pollingTimer = Timer.periodic(
      const Duration(seconds: 2),
      (_) {
        final hasActive = downloads.any(
          (d) => d.status != DownloadStatus.completed,
        );

        if (hasActive) {
          refresh();
        }
      },
    );
  }

  Future<void> refresh() async {
    try {
      final response = await http.get(Uri.parse('$httpBase/downloads'));

      if (response.statusCode != 200) return;

      final List data = jsonDecode(response.body);

      downloads
        ..clear()
        ..addAll(data.map((e) => DownloadTask.fromJson(e)));

      notifyListeners();
    } catch (_) {
      // Optional: log error
    }
  }

  // -------------------------
  // NEW: Set downloads list directly
  // -------------------------
  void setDownloads(List<DownloadTask> items) {
    downloads
      ..clear()
      ..addAll(items);
    notifyListeners();
  }

  DownloadTask? getById(String id) {
    try {
      return downloads.firstWhere((d) => d.id == id);
    } catch (_) {
      return null;
    }
  }

  void togglePriority(String id) {
    final task = getById(id);
    if (task == null) return;
    task.isPriority = !task.isPriority;
    notifyListeners();
  }

  Future<void> addFromUrl(String url) async {
    final uri = Uri.parse('$httpBase/download').replace(queryParameters: {'url': url});

    final response = await http.post(uri);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      downloads.add(DownloadTask.fromJson(data));
      notifyListeners();
    }
  }

  Future<void> pause(String id) async {
    await http.post(Uri.parse('$httpBase/pause/$id'));
  }

  Future<void> pauseAll() async {
    await http.post(Uri.parse('$httpBase/pause-all'));
  }

   Future<void> resumeAll() async {
    await http.post(Uri.parse('$httpBase/resume-all'));
  }

  Future<void> resume(String id) async {
    await http.post(Uri.parse('$httpBase/resume/$id'));
  }

  Future<void> cancel(String id) async {
    await http.post(Uri.parse('$httpBase/cancel/$id'));
  }

  Future<void> remove(String id) async {
    await http.delete(Uri.parse('$httpBase/$id'));
    downloads.removeWhere((d) => d.id == id);
    notifyListeners();
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }
}

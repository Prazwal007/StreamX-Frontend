import 'package:flutter/material.dart';
import '../models/download_task.dart';

class DownloadsController extends ChangeNotifier {
  final List<DownloadTask> downloads = [];

  // Demo data
  void seedDemo() {
    downloads.addAll([
      DownloadTask(
        id: '1',
        filename: 'File1.mp4',
        totalBytes: 1024 * 1024 * 50,
        progress: 40,
        status: DownloadStatus.downloading,
      ),
      DownloadTask(
        id: '2',
        filename: 'Song.mp3',
        totalBytes: 1024 * 1024 * 5,
        progress: 100,
        status: DownloadStatus.completed,
      ),
      DownloadTask(
        id: '3',
        filename: 'Doc.pdf',
        totalBytes: 1024 * 1024 * 2,
        progress: 0,
        status: DownloadStatus.queued,
      ),
    ]);
  }

  // Get task by ID
  DownloadTask? getById(String id) {
  try {
    return downloads.firstWhere((d) => d.id == id);
  } catch (e) {
    return null;
  }
}

  void togglePriority(String id) {
    final task = getById(id);
    if (task != null) {
      task.isPriority = !task.isPriority;
      notifyListeners();
    }
  }

  // Add new download
  void addFromUrl(String url) {
    final newTask = DownloadTask(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      filename: url.split('/').last,
      totalBytes: 1024 * 1024 * 10, // assume 10MB for demo
      progress: 0,
      status: DownloadStatus.queued,
    );
    downloads.add(newTask);
    notifyListeners();
  }

  // Pause download
  void pause(String id) {
    final task = getById(id);
    if (task != null && task.status == DownloadStatus.downloading) {
      task.status = DownloadStatus.paused;
      notifyListeners();
    }
  }

  // Resume download
  void resume(String id) {
    final task = getById(id);
    if (task != null && (task.status == DownloadStatus.paused || task.status == DownloadStatus.queued)) {
      task.status = DownloadStatus.downloading;
      notifyListeners();
    }
  }

  // Cancel download
  void cancel(String id) {
    final task = getById(id);
    if (task != null && task.status == DownloadStatus.downloading) {
      task.status = DownloadStatus.canceled;
      notifyListeners();
    }
  }

  // Start download (for queued or failed tasks)
  void start(String id) {
    final task = getById(id);
    if (task != null && (task.status == DownloadStatus.queued || task.status == DownloadStatus.failed)) {
      task.status = DownloadStatus.downloading;
      task.progress = 0;
      notifyListeners();
    }
  }

  // Remove download
  void remove(String id) {
    downloads.removeWhere((d) => d.id == id);
    notifyListeners();
  }
}



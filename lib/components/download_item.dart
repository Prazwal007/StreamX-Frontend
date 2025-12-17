import 'package:flutter/material.dart';
import '../models/download_task.dart';

class DownloadItem extends StatelessWidget {
  final DownloadTask task;
  const DownloadItem({super.key, required this.task});

  IconData _icon(DownloadStatus s) {
    switch (s) {
      case DownloadStatus.downloading: return Icons.downloading;
      case DownloadStatus.paused: return Icons.pause_circle;
      case DownloadStatus.completed: return Icons.check_circle;
      case DownloadStatus.failed: return Icons.error;
      case DownloadStatus.queued: return Icons.schedule;
      case DownloadStatus.canceled: return Icons.cancel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: Icon(_icon(task.status), color: Colors.white, size: 32),
        title: Text(task.filename, style: const TextStyle(fontSize: 15)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: task.progress / 100,
              color: const Color(0xFF1DB954),
              backgroundColor: Colors.white12,
            ),
            const SizedBox(height: 6),
            Text("${task.progress}%", style: const TextStyle(fontSize: 12)),
          ],
        ),
        trailing: Icon(Icons.more_vert, color: Colors.white70),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './download_details_modal.dart';
import '../models/download_task.dart';
import '../controllers/downloads_controller.dart';
import '../theme/app_theme.dart';

class DownloadItemCard extends StatelessWidget {
  final DownloadTask task;
  const DownloadItemCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DownloadsController>(context, listen: false);
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () => showDialog(
    context: context,
    builder: (_) => DownloadDetailsModal(taskId: task.id),
  ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              SizedBox(
                width: 48,
                child: Icon(Icons.insert_drive_file, size: 28, color: Colors.white70),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(task.filename, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                        if (task.isPriority) const SizedBox(width: 4),
                        if (task.isPriority) const Icon(Icons.push_pin, color: AppTheme.neon, size: 16),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: task.progress / 100,
                        minHeight: 8,
                        backgroundColor: Colors.white12,
                        valueColor: const AlwaysStoppedAnimation(AppTheme.neon),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text('${task.progress}%  | ${task.totalBytes} bytes',
                        style: const TextStyle(fontSize: 12, color: Colors.white54)),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(task.isPriority ? Icons.push_pin : Icons.push_pin_outlined, color: AppTheme.neon),
                onPressed: () => controller.togglePriority(task.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

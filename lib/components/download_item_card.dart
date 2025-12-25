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
    final percent = (task.progress * 100).toStringAsFixed(1);
    final isCompleted = task.status == DownloadStatus.completed;

    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () => showDialog(
          context: context,
          builder: (_) => DownloadDetailsModal(taskId: task.id),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              SizedBox(
                width: 48,
                child: Icon(
                  Icons.insert_drive_file,
                  size: 28,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          task.filename,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        if (task.isPriority) const SizedBox(width: 4),
                        if (task.isPriority)
                           Icon(Icons.push_pin, color: Theme.of(context).primaryColor, size: 16),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: isCompleted
                            ? 1.0
                            : (task.totalBytes == null ? null : task.progress),
                        minHeight: 8,
                        backgroundColor: Theme.of(context).dividerColor,
                        valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      task.totalBytes == null
                          ? 'Downloading...'
                          : '$percent%  | ${task.totalBytes} bytes',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  task.isPriority
                      ? Icons.push_pin
                      : Icons.push_pin_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () => controller.togglePriority(task.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

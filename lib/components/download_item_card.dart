// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import './download_details_modal.dart';
// import '../models/download_task.dart';
// import '../controllers/downloads_controller.dart';
// import '../theme/app_theme.dart';
// class DownloadItemCard extends StatelessWidget {
//   final DownloadTask task;

//   const DownloadItemCard({super.key, required this.task});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Provider.of<DownloadsController>(context, listen: false);
//     final percent = (task.progress * 100).toStringAsFixed(1);
//     final isCompleted = task.status == DownloadStatus.completed;

//     return Consumer<DownloadsController>(
//     builder: (context, controller, _) {
//       final isCompleted = task.status == DownloadStatus.completed;

//     return Card(
//       color: Theme.of(context).cardColor,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       child: InkWell(
//         onTap: () => showDialog(
//           context: context,
//           builder: (_) => DownloadDetailsModal(taskId: task.id),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//           child: Row(
//             children: [
//               SizedBox(
//                 width: 48,
//                 child: Icon(
//                   Icons.insert_drive_file,
//                   size: 28,
//                   color: Theme.of(context).iconTheme.color,
//                 ),
//               ),
//               Expanded(
//                 flex: 4,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           task.filename,
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyLarge
//                               ?.copyWith(fontWeight: FontWeight.w600),
//                         ),
//                         if (task.isPriority) const SizedBox(width: 4),
//                         if (task.isPriority)
//                            Icon(Icons.push_pin, color: Theme.of(context).primaryColor, size: 16),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(6),
//                       child: LinearProgressIndicator(
//                         value: isCompleted
//                             ? 1.0
//                             : (task.totalBytes == null ? null : task.progress),
//                         minHeight: 8,
//                         backgroundColor: Theme.of(context).dividerColor,
//                         valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       task.totalBytes == null
//                           ? 'Downloading...'
//                           : '$percent%  | ${task.totalBytes} bytes',
//                       style: Theme.of(context).textTheme.bodySmall,
//                     ),
//                   ],
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(
//                   task.isPriority
//                       ? Icons.push_pin
//                       : Icons.push_pin_outlined,
//                   color: Theme.of(context).primaryColor,
//                 ),
//                 onPressed: () => controller.togglePriority(task.id),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   );
//   }
  
//   String _bytesReadable(int b) {
//     if (b < 1024) return '$b B';
//     final kb = b / 1024;
//     if (kb < 1024) return '${kb.toStringAsFixed(1)} KB';
//     final mb = kb / 1024;
//     if (mb < 1024) return '${mb.toStringAsFixed(1)} MB';
//     final gb = mb / 1024;
//     return '${gb.toStringAsFixed(2)} GB';
//   }

// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/download_task.dart';
import '../controllers/downloads_controller.dart';
import './download_details_modal.dart';

// class DownloadItemCard extends StatelessWidget {
//   final DownloadTask task;

//   const DownloadItemCard({super.key, required this.task});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Consumer<DownloadsController>(
//       builder: (context, controller, _) {
//         final isCompleted = task.status == DownloadStatus.completed;

//         return Card(
//           color: theme.cardColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: InkWell(
//             borderRadius: BorderRadius.circular(8),
//             onTap: () => showDialog(
//               context: context,
//               builder: (_) => DownloadDetailsModal(taskId: task.id),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       SizedBox(
//                         width: 48,
//                         child: Icon(
//                           Icons.insert_drive_file,
//                           size: 28,
//                           color: theme.iconTheme.color,
//                         ),
//                       ),

//                       Expanded(
//                         flex: 4,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     task.filename,
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: theme.textTheme.bodyLarge?.copyWith(
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ),
//                                 if (task.isPriority) const SizedBox(width: 6),
//                                 if (task.isPriority)
//                                   Icon(
//                                     Icons.push_pin,
//                                     size: 16,
//                                     color: theme.primaryColor,
//                                   ),
//                               ],
//                             ),
//                             const SizedBox(height: 2),
//                             Text(
//                               task.totalBytes == null
//                                   ? _bytesReadable(task.downloadedBytes)
//                                   : '${_bytesReadable(task.downloadedBytes)} / ${_bytesReadable(task.totalBytes!)}',
//                               style: theme.textTheme.bodySmall,
//                             ),
//                           ],
//                         ),
//                       ),

//                       Expanded(
//                         flex: 1,
//                         child: Text(
//                           task.totalBytes == null
//                               ? '—'
//                               : _bytesReadable(task.totalBytes!),
//                           style: theme.textTheme.bodyMedium,
//                         ),
//                       ),

//                       // Status
//                       Expanded(
//                         flex: 2,
//                         child: Text(
//                           _statusLabel(task),
//                           style: theme.textTheme.bodyMedium,
//                         ),
//                       ),

//                       Expanded(
//                         flex: 1,
//                         child: Text(
//                           _etaLabel(task),
//                           style: theme.textTheme.bodyMedium,
//                         ),
//                       ),

//                       SizedBox(
//                         width: 48,
//                         child: IconButton(
//                           icon: Icon(
//                             task.isPriority
//                                 ? Icons.push_pin
//                                 : Icons.push_pin_outlined,
//                             color: theme.primaryColor,
//                           ),
//                           onPressed: () =>
//                               controller.togglePriority(task.id),
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       const SizedBox(width: 48),
//                       Expanded(
//                         flex: 8, // File (4) + Size (1) + Status (2) + Time (1)
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(4),
//                           child: LinearProgressIndicator(
//                             value: isCompleted
//                                 ? 1.0
//                                 : (task.totalBytes == null
//                                     ? null
//                                     : task.progress),
//                             minHeight: 6,
//                             backgroundColor:
//                                 theme.dividerColor.withValues(alpha:0.4),
//                             valueColor: AlwaysStoppedAnimation(
//                               theme.primaryColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 48),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   String _statusLabel(DownloadTask t) {
//     switch (t.status) {
//       case DownloadStatus.downloading:
//         return 'Downloading';
//       case DownloadStatus.paused:
//         return 'Paused';
//       case DownloadStatus.completed:
//         return 'Completed';
//       case DownloadStatus.failed:
//         return 'Failed';
//       case DownloadStatus.queued:
//         return 'Queued';
//       case DownloadStatus.canceled:
//         return 'Canceled';
//     }
//   }

//   String _bytesReadable(int b) {
//     if (b < 1024) return '$b B';
//     final kb = b / 1024;
//     if (kb < 1024) return '${kb.toStringAsFixed(1)} KB';
//     final mb = kb / 1024;
//     if (mb < 1024) return '${mb.toStringAsFixed(1)} MB';
//     final gb = mb / 1024;
//     return '${gb.toStringAsFixed(2)} GB';
//   }

//   String _etaLabel(DownloadTask task) {
//   final eta = task.eta;

//   if (eta == null) return '—';
//   if (eta <= 0) return 'Done';

//   final minutes = eta ~/ 60;
//   final seconds = eta % 60;

//   if (minutes > 0) {
//     return '${minutes}m ${seconds}s';
//   }
//   return '${seconds}s';
// }

// }
class DownloadItemCard extends StatelessWidget {
  final DownloadTask task;

  const DownloadItemCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<DownloadsController>(
      builder: (context, controller, _) {
        final liveTask = controller.getById(task.id) ?? task;
        final isCompleted =
            liveTask.status == DownloadStatus.completed;

        return Card(
          color: theme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => showDialog(
              context: context,
              builder: (_) =>
                  DownloadDetailsModal(taskId: liveTask.id),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 48,
                        child: Icon(
                          Icons.insert_drive_file,
                          size: 28,
                          color: theme.iconTheme.color,
                        ),
                      ),

                      /// Filename + downloaded
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              liveTask.filename,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              liveTask.totalBytes == null
                                  ? _bytesReadable(
                                      liveTask.downloadedBytes)
                                  : '${_bytesReadable(liveTask.downloadedBytes)} / '
                                    '${_bytesReadable(liveTask.totalBytes!)}',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),

                      /// Size
                      Expanded(
                        flex: 1,
                        child: Text(
                          liveTask.totalBytes == null
                              ? '—'
                              : _bytesReadable(liveTask.totalBytes!),
                        ),
                      ),

                      /// Status
                      Expanded(
                        flex: 2,
                        child: Text(_statusLabel(liveTask)),
                      ),

                      /// ETA
                      Expanded(
                        flex: 1,
                        child: Text(
                          liveTask.eta == null
                              ? '—'
                              : _formatEta(liveTask.eta!),
                        ),
                      ),

                      SizedBox(
                        width: 48,
                        child: IconButton(
                          icon: Icon(
                            liveTask.isPriority
                                ? Icons.push_pin
                                : Icons.push_pin_outlined,
                            color: theme.primaryColor,
                          ),
                          onPressed: () =>
                              controller.togglePriority(liveTask.id),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// Progress bar
                  Row(
                    children: [
                      const SizedBox(width: 48),
                      Expanded(
                        flex: 8,
                        child: LinearProgressIndicator(
                          value: isCompleted
                              ? 1.0
                              : (liveTask.totalBytes == null
                                  ? null
                                  : liveTask.progress),
                          minHeight: 6,
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatEta(int seconds) {
    if (seconds < 60) return '${seconds}s';
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m}m ${s}s';
  }

  String _statusLabel(DownloadTask t) {
    switch (t.status) {
      case DownloadStatus.downloading:
        return 'Downloading';
      case DownloadStatus.paused:
        return 'Paused';
      case DownloadStatus.completed:
        return 'Completed';
      case DownloadStatus.failed:
        return 'Failed';
      case DownloadStatus.queued:
        return 'Queued';
      case DownloadStatus.canceled:
        return 'Canceled';
    }
  }

  String _bytesReadable(int b) {
    if (b < 1024) return '$b B';
    final kb = b / 1024;
    if (kb < 1024) return '${kb.toStringAsFixed(1)} KB';
    final mb = kb / 1024;
    if (mb < 1024) return '${mb.toStringAsFixed(1)} MB';
    final gb = mb / 1024;
    return '${gb.toStringAsFixed(2)} GB';
  }
}

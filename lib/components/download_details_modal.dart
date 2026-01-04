// import 'package:flutter/material.dart';
// import '../models/download_task.dart';
// import '../controllers/downloads_controller.dart';
// import 'package:provider/provider.dart';


// class DownloadDetailsModal extends StatelessWidget {
//   final String taskId;

//   const DownloadDetailsModal({super.key, required this.taskId});

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Theme.of(context).cardColor,
//       child: Container(
//         width: 600,
//         padding: const EdgeInsets.all(16),
//         child: Consumer<DownloadsController>(
//           builder: (context, ctrl, _) {
//             final t = ctrl.getById(taskId)!;
//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   children: [
//                      Icon(Icons.insert_drive_file, size: 28, color: Theme.of(context).focusColor),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Text(
//                         t.filename,
//                         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 _infoRow('File size:', t.totalBytes == null? 'Unknown': _bytesReadable(t.totalBytes!),),
//                 _infoRow('Downloaded:', '${_bytesReadable(t.downloadedBytes)} (${t.progress}%)'),
//                 const SizedBox(height: 12),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(4),
//                   child: LinearProgressIndicator(
//                     value: t.progress / 100,
//                     minHeight: 12,
//                     valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
//                     backgroundColor: Colors.white12,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
//                       onPressed: () {
//                         ctrl.togglePriority(taskId);
//                         Navigator.pop(context);
//                       },
//                       child: const Text('Prioritize'),
//                     ),
//                     const SizedBox(width: 8),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
//                       onPressed: () {
//                         if (t.status == DownloadStatus.downloading) {
//                           ctrl.pause(t.id);
//                         } else {
//                           ctrl.resume(t.id);
//                         }
//                         Navigator.pop(context);
//                       },
//                       child: Text(t.status == DownloadStatus.downloading ? 'Pause' : 'Resume'),
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _infoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 120,
//             child: Text(label, style: const TextStyle(color: Colors.white70)),
//           ),
//           Expanded(child: Text(value, style: const TextStyle(color: Colors.white))),
//         ],
//       ),
//     );
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

class DownloadDetailsModal extends StatelessWidget {
  final String taskId;

  const DownloadDetailsModal({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: theme.cardColor,
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(16),
        child: Consumer<DownloadsController>(
          builder: (context, ctrl, _) {
            final t = ctrl.getById(taskId)!;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.insert_drive_file,
                      size: 28,
                      color: theme.focusColor, // textPrimary
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        t.filename,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                _infoRow(
                  context,
                  'File size:',
                  t.totalBytes == null
                      ? 'Unknown'
                      : _bytesReadable(t.totalBytes!),
                ),
                _infoRow(
                  context,
                  'Downloaded:',
                  '${_bytesReadable(t.downloadedBytes)} (${t.progress*100}%)',
                ),

                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: t.progress,
                    minHeight: 8,
                    valueColor:
                        AlwaysStoppedAnimation(theme.primaryColor), // accent
                    backgroundColor:
                        theme.dividerColor.withValues(alpha:0.3),
                  ),
                ),

                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ctrl.togglePriority(taskId);
                        Navigator.pop(context);
                      },
                      child: const Text('Prioritize'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (t.status == DownloadStatus.downloading) {
                          ctrl.pause(t.id);
                        } else {
                          ctrl.resume(t.id);
                        }
                        Navigator.pop(context);
                      },
                      child: Text(
                        t.status == DownloadStatus.downloading
                            ? 'Pause'
                            : 'Resume',
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _infoRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium, // textSecondary
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyLarge, // textPrimary
            ),
          ),
        ],
      ),
    );
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

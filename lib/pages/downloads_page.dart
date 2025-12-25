// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../models/download_task.dart';
// import '../controllers/downloads_controller.dart';
// import '../components/download_item.dart';
// import '../components/empty_state.dart';

// class DownloadsPage extends StatelessWidget {
//   final DownloadStatus? filter;
//   const DownloadsPage({super.key, this.filter});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<DownloadsController>(
//       builder: (context, ctrl, _) {
//         final items = filter == null
//             ? ctrl.downloads
//             : ctrl.downloads.where((d) => d.status == filter).toList();

//         if (items.isEmpty) return const EmptyState();

//         return ListView.builder(
//           padding: const EdgeInsets.all(12),
//           itemCount: items.length,
//           itemBuilder: (_, i) => DownloadItem(task: items[i]),
//         );
//       },
//     );
//   }
// }

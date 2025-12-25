import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamx/theme/app_theme.dart';
import '../controllers/downloads_controller.dart';
import 'download_item_card.dart';

class DownloadsTable extends StatelessWidget {
  const DownloadsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DownloadsController>(
      builder: (context, ctrl, _) {
        final items = ctrl.downloads;
        return Padding(
          padding: const EdgeInsets.only(right: 18.0, top: 12, bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _tableHeader(context),
              Divider(color: Theme.of(context).primaryColor,),
              const SizedBox(height: 12),
              Expanded(
                child: items.isEmpty
                    ?  Center(child: Text('No downloads', style: TextStyle(color: Theme.of(context).focusColor)))
                    : ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, i) {
                          final t = items[i];
                          return DownloadItemCard(task: t);
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _tableHeader(BuildContext context) {
    return Row(
      children:  [
        SizedBox(width: 48),
        Expanded(flex: 4, child: Text('File Name', style: TextStyle(color: Theme.of(context).focusColor, fontWeight: FontWeight.w600))),
        Expanded(flex: 1, child: Text('Size', style: TextStyle(color: Theme.of(context).focusColor, fontWeight: FontWeight.w600))),
        Expanded(flex: 2, child: Text('Status', style: TextStyle(color: Theme.of(context).focusColor, fontWeight: FontWeight.w600))),
        Expanded(flex: 1, child: Text('Time Left', style: TextStyle(color: Theme.of(context).focusColor, fontWeight: FontWeight.w600))),
        SizedBox(width: 48),
      ],
    );
  }
}

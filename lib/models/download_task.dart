// enum DownloadStatus { queued, downloading, paused, completed, failed, canceled }

// class DownloadTask {
//   final String id;
//   final String filename;
//   final int totalBytes;
//   int downloadedBytes;
//   int progress;
//   DownloadStatus status;
//   bool isPriority;

//   DownloadTask({
//     required this.id,
//     required this.filename,
//     required this.totalBytes,
//     this.downloadedBytes = 0,
//     this.progress = 0,
//     this.status = DownloadStatus.queued,
//     this.isPriority = false,
//   });
// }


enum DownloadStatus {
  queued,
  downloading,
  paused,
  completed,
  failed,
  canceled,
}

DownloadStatus statusFromString(String value) {
  switch (value) {
    case 'downloading':
      return DownloadStatus.downloading;
    case 'completed':
      return DownloadStatus.completed;
    case 'paused':
      return DownloadStatus.paused;
    case 'failed':
      return DownloadStatus.failed;
    case 'canceled':
      return DownloadStatus.canceled;
    default:
      return DownloadStatus.queued;
  }
}

class DownloadTask {
  final String id;
  final String url;
  final String filename;
  final String filePath;

  int downloadedBytes;
  int? totalBytes;

  DownloadStatus status;
  bool isPriority;

  DownloadTask({
    required this.id,
    required this.url,
    required this.filename,
    required this.filePath,
    required this.downloadedBytes,
    required this.totalBytes,
    required this.status,

    this.isPriority = false,
  });

  double get progress {
  if (status == DownloadStatus.completed) return 1.0;
  if (totalBytes == null || totalBytes == 0) return 0;
  return downloadedBytes / totalBytes!;
}


  factory DownloadTask.fromJson(Map<String, dynamic> json) {
    return DownloadTask(
      id: json['id'],
      url: json['url'],
      filename: json['url'].split('/').last,
      filePath: json['file_path'],
      downloadedBytes: json['downloaded'],
      totalBytes: json['total'],
      status: statusFromString(json['status']),
    );
  }
}

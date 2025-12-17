enum DownloadStatus { queued, downloading, paused, completed, failed, canceled }

class DownloadTask {
  final String id;
  final String filename;
  final int totalBytes;
  int downloadedBytes;
  int progress;
  DownloadStatus status;
  bool isPriority;

  DownloadTask({
    required this.id,
    required this.filename,
    required this.totalBytes,
    this.downloadedBytes = 0,
    this.progress = 0,
    this.status = DownloadStatus.queued,
    this.isPriority = false,
  });
}

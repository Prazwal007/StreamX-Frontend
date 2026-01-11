// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../models/download_task.dart';

// class DownloadsController extends ChangeNotifier {
//   final List<DownloadTask> downloads = [];

//   static const String httpBase = 'http://127.0.0.1:8000';

//   Timer? _pollingTimer;

//   Future<void> init() async {
//     await refresh();
//     _startPolling();
//   }

//   void _startPolling() {
//     _pollingTimer?.cancel();

//     _pollingTimer = Timer.periodic(
//       const Duration(seconds: 2),
//       (_) {
//         final hasActive = downloads.any(
//           (d) => d.status != DownloadStatus.completed,
//         );

//         if (hasActive) {
//           refresh();
//         }
//       },
//     );
//   }

//   Future<void> refresh() async {
//     try {
//       final response = await http.get(Uri.parse('$httpBase/downloads'));

//       if (response.statusCode != 200) return;

//       final List data = jsonDecode(response.body);

//       downloads
//         ..clear()
//         ..addAll(data.map((e) => DownloadTask.fromJson(e)));

//       notifyListeners();
//     } catch (_) {
//       // Optional: log error
//     }
//   }

//   // -------------------------
//   // NEW: Set downloads list directly
//   // -------------------------
//   void setDownloads(List<DownloadTask> items) {
//     downloads
//       ..clear()
//       ..addAll(items);
//     notifyListeners();
//   }

//   DownloadTask? getById(String id) {
//     try {
//       return downloads.firstWhere((d) => d.id == id);
//     } catch (_) {
//       return null;
//     }
//   }

//   void togglePriority(String id) {
//     final task = getById(id);
//     if (task == null) return;
//     task.isPriority = !task.isPriority;
//     notifyListeners();
//   }

//   Future<void> addFromUrl(String url) async {
//     final uri = Uri.parse('$httpBase/download').replace(queryParameters: {'url': url});

//     final response = await http.post(uri);

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final data = jsonDecode(response.body);
//       downloads.add(DownloadTask.fromJson(data));
//       notifyListeners();
//     }
//   }

//   Future<void> pause(String id) async {
//     await http.post(Uri.parse('$httpBase/pause/$id'));
//   }

//   Future<void> pauseAll() async {
//     await http.post(Uri.parse('$httpBase/pause-all'));
//   }

//    Future<void> resumeAll() async {
//     await http.post(Uri.parse('$httpBase/resume-all'));
//   }

//   Future<void> resume(String id) async {
//     await http.post(Uri.parse('$httpBase/resume/$id'));
//   }

//   Future<void> cancel(String id) async {
//     await http.post(Uri.parse('$httpBase/cancel/$id'));
//   }

//   Future<void> remove(String id) async {
//     await http.delete(Uri.parse('$httpBase/$id'));
//     downloads.removeWhere((d) => d.id == id);
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     _pollingTimer?.cancel();
//     super.dispose();
//   }
// }


import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/download_task.dart';

class DownloadsController extends ChangeNotifier {
  final List<DownloadTask> downloads = [];

  static const String httpBase = 'http://127.0.0.1:8000';
  static const String wsUrl = 'ws://127.0.0.1:8000/ws/downloads';

  WebSocketChannel? _channel;
  StreamSubscription? _wsSubscription;

  // -------------------------
  // INIT / DISPOSE
  // -------------------------

  Future<void> init() async {
    await _fetchInitial();
    _connectWebSocket();
  }

  @override
  void dispose() {
    _wsSubscription?.cancel();
    _channel?.sink.close();
    super.dispose();
  }

  // -------------------------
  // INITIAL FETCH (ONCE)
  // -------------------------

  Future<void> _fetchInitial() async {
    try {
      final response = await http.get(Uri.parse('$httpBase/downloads'));
      if (response.statusCode != 200) return;

      final List data = jsonDecode(response.body);
      downloads
        ..clear()
        ..addAll(data.map((e) => DownloadTask.fromJson(e)));

      notifyListeners();
    } catch (_) {
      // optional logging
    }
  }

  // -------------------------
  // WEBSOCKET HANDLING
  // -------------------------

  void _connectWebSocket() {
    _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

    _wsSubscription = _channel!.stream.listen(
      _onWsMessage,
      onError: _onWsError,
      onDone: _onWsDone,
    );
  }

  void _onWsMessage(dynamic message) {
    try {
      final data = jsonDecode(message);

      final updated = _fromWsJson(data);

      final index = downloads.indexWhere((d) => d.id == updated.id);

      if (index == -1) {
        // new download
        downloads.add(updated);
      } else {
        // update existing
        downloads[index] = updated;
      }

      notifyListeners();
    } catch (_) {
      // malformed message, ignore
    }
  }

  void _onWsError(Object error) {
    // optional: reconnect with backoff
  }

  void _onWsDone() {
    // optional: reconnect logic
  }

  // -------------------------
  // COMMANDS (HTTP)
  // -------------------------

  Future<void> addFromUrl(String url) async {
    final uri = Uri.parse('$httpBase/download')
        .replace(queryParameters: {'url': url});

    await http.post(uri);
  }

  Future<void> pause(String id) async {
    await http.post(Uri.parse('$httpBase/pause/$id'));
  }

  Future<void> resume(String id) async {
    await http.post(Uri.parse('$httpBase/resume/$id'));
  }

  Future<void> pauseAll() async {
    await http.post(Uri.parse('$httpBase/pause-all'));
  }

  Future<void> resumeAll() async {
    await http.post(Uri.parse('$httpBase/resume-all'));
  }

  Future<void> cancel(String id) async {
    await http.post(Uri.parse('$httpBase/cancel/$id'));
  }

  Future<void> remove(String id) async {
    await http.delete(Uri.parse('$httpBase/$id'));
    downloads.removeWhere((d) => d.id == id);
    notifyListeners();
  }

  // -------------------------
  // HELPERS
  // -------------------------

  DownloadTask? getById(String id) {
    try {
      return downloads.firstWhere((d) => d.id == id);
    } catch (_) {
      return null;
    }
  }

  void togglePriority(String id) async {
    final task = getById(id);
    if (task == null) return;
    
    task.isPriority = !task.isPriority;
    if(task.isPriority){
    await http.post(Uri.parse('$httpBase/downloads/$id/pin'));
    }
    if(!task.isPriority){
      await http.post(Uri.parse('$httpBase/downloads/$id/unpin'));

    }
    notifyListeners();
    
  }


  DownloadTask _fromWsJson(Map<String, dynamic> json) {
    return DownloadTask(
      id: json['id'],
      url: json['url'],
      filename: json['filename'],
      eta: json['eta_seconds'],
      downloadedBytes: json['downloaded'],
      totalBytes: json['total'],
      status: _statusFromString(json['status']),
      filePath: json['file_path'],
      isPriority: json['is_pinned']
    );
  }

  DownloadStatus _statusFromString(String s) {
    switch (s) {
      case 'downloading':
        return DownloadStatus.downloading;
      case 'paused':
        return DownloadStatus.paused;
      case 'completed':
        return DownloadStatus.completed;
      case 'failed':
        return DownloadStatus.failed;
      case 'queued':
        return DownloadStatus.queued;
      case 'canceled':
        return DownloadStatus.canceled;
      default:
        return DownloadStatus.downloading;
    }
  }
}

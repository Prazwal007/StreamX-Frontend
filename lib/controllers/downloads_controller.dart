


// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../models/download_task.dart';

// class DownloadsController extends ChangeNotifier {
//   final List<DownloadTask> downloads = [];

//   static const String httpBase = 'http://127.0.0.1:8000';
//   static const String wsUrl = 'ws://127.0.0.1:8000/ws/downloads';

//   WebSocket? _socket;
//   bool _connected = false;

//   Future<void> init() async {
//     await refresh();
//     _connectWebSocket();
//   }

//   Future<void> refresh() async {
//     final response = await http.get(Uri.parse('$httpBase/downloads'));

//     if (response.statusCode != 200) return;

//     final List data = jsonDecode(response.body);

//     downloads
//       ..clear()
//       ..addAll(data.map((e) => DownloadTask.fromJson(e)));

//     notifyListeners();
//   }


//   void _connectWebSocket() async {
//     if (_connected) return;

//     try {
//       _socket = await WebSocket.connect(wsUrl);
//       _connected = true;

//       _socket!.listen(
//         _onMessage,
//         onDone: _onDisconnected,
//         onError: (_) => _onDisconnected(),
//       );
//     } catch (_) {
//       _scheduleReconnect();
//     }
//   }

//   void _onMessage(dynamic message) {
//     final data = jsonDecode(message);

//     final updated = DownloadTask.fromJson(data);

//     final index = downloads.indexWhere((d) => d.id == updated.id);

//     if (index >= 0) {
//       final old = downloads[index];
//       downloads[index] = updated..isPriority = old.isPriority;
//     } else {
//       downloads.add(updated);
//     }

//     notifyListeners();

//   }

//   void _onDisconnected() {
//     _connected = false;
//     _socket = null;
//     _scheduleReconnect();
//   }

//   void _scheduleReconnect() {
//     Future.delayed(const Duration(seconds: 3), _connectWebSocket);
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
//   final uri = Uri.parse('$httpBase/download')
//       .replace(queryParameters: {'url': url});

//   final response = await http.post(uri);

//   if (response.statusCode == 200 || response.statusCode == 201) {
//     final data = jsonDecode(response.body);
//     downloads.add(DownloadTask.fromJson(data));
//     notifyListeners();
//   }
// }

//   Future<void> pause(String id) async {
//     await http.post(Uri.parse('$httpBase/pause/$id'));
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

//   /* -------------------------
//      CLEANUP
//   ------------------------- */

//   @override
//   void dispose() {
//     _socket?.close();
//     super.dispose();
//   }
// }


import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/download_task.dart';

class DownloadsController extends ChangeNotifier {
  final List<DownloadTask> downloads = [];

  static const String httpBase = 'http://127.0.0.1:8000';

  Timer? _pollingTimer;


  Future<void> init() async {
    await refresh();
    _startPolling();
  }


  void _startPolling() {
  _pollingTimer?.cancel();

  _pollingTimer = Timer.periodic(
    const Duration(seconds: 2),
    (_) {
      final hasActive = downloads.any(
        (d) => d.status != DownloadStatus.completed,
      );

      if (hasActive) {
        refresh();
      }
    },
  );
}


  Future<void> refresh() async {
    try {
      final response =
          await http.get(Uri.parse('$httpBase/downloads'));

      if (response.statusCode != 200) return;

      final List data = jsonDecode(response.body);

      downloads
        ..clear()
        ..addAll(data.map((e) => DownloadTask.fromJson(e)));

      notifyListeners();
    } catch (_) {
      // Optional: log error
    }
  }

  DownloadTask? getById(String id) {
    try {
      return downloads.firstWhere((d) => d.id == id);
    } catch (_) {
      return null;
    }
  }

  void togglePriority(String id) {
    final task = getById(id);
    if (task == null) return;
    task.isPriority = !task.isPriority;
    notifyListeners();
  }

  Future<void> addFromUrl(String url) async {
    final uri = Uri.parse('$httpBase/download')
        .replace(queryParameters: {'url': url});

    final response = await http.post(uri);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      downloads.add(DownloadTask.fromJson(data));
      notifyListeners();
    }
  }

  Future<void> pause(String id) async {
    await http.post(Uri.parse('$httpBase/pause/$id'));
  }

  Future<void> resume(String id) async {
    await http.post(Uri.parse('$httpBase/resume/$id'));
  }

  Future<void> cancel(String id) async {
    await http.post(Uri.parse('$httpBase/cancel/$id'));
  }

  Future<void> remove(String id) async {
    await http.delete(Uri.parse('$httpBase/$id'));
    downloads.removeWhere((d) => d.id == id);
    notifyListeners();
  }

  /* -------------------------
     CLEANUP
  ------------------------- */

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }
}

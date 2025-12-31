// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../controllers/downloads_controller.dart';

// class TopToolbar extends StatefulWidget {
//   const TopToolbar({super.key});

//   @override
//   State<TopToolbar> createState() => _TopToolbarState();
// }

// class _TopToolbarState extends State<TopToolbar> {
//   bool _showSearch = false;
//   final TextEditingController _searchController = TextEditingController();

//   bool _isPlaying = false;

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final controller = Provider.of<DownloadsController>(context, listen: false);

//     return Container(
//       height: 48,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Theme.of(context).canvasColor,
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(10),
//           bottomRight: Radius.circular(10),
//         ),
//       ),
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           // 🎯 CENTER — Animated Pause / Resume
//           GestureDetector(
//             onTap: _togglePlay,
//             onLongPress: _onLongPressPlay,
//             child: Tooltip(
//               message: _isPlaying ? "Pause All" : "Resume All",
//               child: AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 180),
//                 transitionBuilder: (child, animation) {
//                   return ScaleTransition(
//                     scale: animation,
//                     child: FadeTransition(opacity: animation, child: child),
//                   );
//                 },
//                 child: CircleAvatar(
//                   key: ValueKey(_isPlaying),
//                   radius: 18,
//                   backgroundColor: Colors.transparent,
//                   child: Icon(
//                     _isPlaying ? Icons.pause : Icons.play_arrow,
//                     size: 22,
//                     color: Theme.of(context).focusColor,
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // 👉 RIGHT SIDE — Search
//           Positioned(
//             right: 8,
//             child: Row(
//               children: [
//                 if (_showSearch) _searchBox(context),

//                 _toolbarIcon(
//                   icon: Icons.search,
//                   tooltip: "Search File",
//                   onTap: () {
//                     setState(() {
//                       _showSearch = !_showSearch;
//                       if (!_showSearch) _searchController.clear();
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // 🔄 Toggle Play / Pause
//   void _togglePlay() {
//     setState(() {
//       _isPlaying = !_isPlaying;
//     });
//     if (_isPlaying) {
    
//     }
//   }

//   // 🧠 Long Press Behavior
//   void _onLongPressPlay() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(_isPlaying ? "Paused all tasks" : "Resumed all tasks"),
//         duration: const Duration(seconds: 1),
//       ),
//     );
//   }

//   Widget _searchBox(BuildContext context) {
//     return Container(
//       height: 36,
//       width: 200,
//       margin: const EdgeInsets.only(right: 8),
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       alignment: Alignment.center,
//       child: TextField(
//         controller: _searchController,
//         autofocus: true,
//         style: TextStyle(color: Theme.of(context).focusColor, fontSize: 14),
//         decoration: const InputDecoration(
//           hintText: 'Search file...',
//           border: InputBorder.none,
//           isDense: true,
//         ),
//         onChanged: (value) {
//           // TODO: search logic
//         },
//       ),
//     );
//   }

//   Widget _toolbarIcon({
//     required IconData icon,
//     String? tooltip,
//     VoidCallback? onTap,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 6),
//       child: Tooltip(
//         message: tooltip ?? "",
//         waitDuration: const Duration(milliseconds: 300),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(20),
//           onTap: onTap,
//           child: CircleAvatar(
//             radius: 18,
//             backgroundColor: Colors.transparent,
//             child: Icon(icon, size: 20, color: Theme.of(context).focusColor),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/downloads_controller.dart';

class TopToolbar extends StatefulWidget {
  const TopToolbar({super.key});

  @override
  State<TopToolbar> createState() => _TopToolbarState();
}

class _TopToolbarState extends State<TopToolbar> {
  bool _showSearch = false;
  final TextEditingController _searchController = TextEditingController();

  bool _isPlaying = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DownloadsController>(context, listen: false);

    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 🎯 CENTER — Animated Pause / Resume
          GestureDetector(
            onTap: ()=>{
              setState(() {
                _isPlaying = !_isPlaying;}),
              if (!_isPlaying) {
                  controller.pauseAll()
              }
              else{
                  controller.resumeAll()
              }
              
            },
            onLongPress: _onLongPressPlay,
            child: Tooltip(
              message: _isPlaying ? "Pause All" : "Resume All",
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: CircleAvatar(
                  key: ValueKey(_isPlaying),
                  radius: 18,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 22,
                    color: Theme.of(context).focusColor,
                  ),
                ),
              ),
            ),
          ),

          // 👉 RIGHT SIDE — Search
          Positioned(
            right: 8,
            child: Row(
              children: [
                if (_showSearch) _searchBox(context),

                _toolbarIcon(
                  icon: Icons.search,
                  tooltip: "Search File",
                  onTap: () {
                    setState(() {
                      _showSearch = !_showSearch;
                      if (!_showSearch) _searchController.clear();
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔄 Toggle Play / Pause

  // 🧠 Long Press Behavior
  void _onLongPressPlay() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isPlaying ? "Paused all tasks" : "Resumed all tasks"),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Widget _searchBox(BuildContext context) {
    return Container(
      height: 36,
      width: 200,
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: _searchController,
        autofocus: true,
        style: TextStyle(color: Theme.of(context).focusColor, fontSize: 14),
        decoration: const InputDecoration(
          hintText: 'Search file...',
          border: InputBorder.none,
          isDense: true,
        ),
        onChanged: (value) {
          // TODO: search logic
        },
      ),
    );
  }

  Widget _toolbarIcon({
    required IconData icon,
    String? tooltip,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Tooltip(
        message: tooltip ?? "",
        waitDuration: const Duration(milliseconds: 300),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.transparent,
            child: Icon(icon, size: 20, color: Theme.of(context).focusColor),
          ),
        ),
      ),
    );
  }
}

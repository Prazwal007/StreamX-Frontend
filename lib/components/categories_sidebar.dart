// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../theme/app_theme.dart';
// import '../pages/categories_page.dart';
// import '../controllers/categories_controller.dart';

// class CategoriesSidebar extends StatelessWidget {
//   const CategoriesSidebar({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 220,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: AppTheme.bgDark,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//             Row(
//               children: [
//                 _categoryHeader(context, 'Recent', Icons.folder, 'all'),
//                 const Spacer(),
//                 Icon(Icons.arrow_back_ios_sharp)
//               ],
//             ),
//           const SizedBox(height:20),
//           const Divider(color: AppTheme.neon,thickness: 1,),
//           Expanded(
//             child: ListView.separated(
//               itemCount: 6,
//               separatorBuilder: (_, __) => const SizedBox(height: 16),
//               itemBuilder: (context, index) {
//                 final items = [
//                   _categoryItem(context, 'Compressed', Icons.archive, 'compressed'),
//                   _categoryItem(context, 'Documents', Icons.description, 'documents'),
//                   _categoryItem(context, 'Music', Icons.music_note, 'music'),
//                   _categoryItem(context, 'Program', Icons.code, 'program'),
//                   _categoryItem(context, 'Video', Icons.movie, 'video'),
//                   _categoryCollapsible(context, 'Queues', ['Queue 1', 'Queue 2']),
//                 ];
//                 return items[index];
//               },
//             ),
//           ),

//         ],
//       ),
//     );
//   }

//   Widget _categoryItem(
//     BuildContext context,
//     String title,
//     IconData icon,
//     String category,
//   ) {

//     final controller=context.watch<CategoryController>();
//     final isActive = controller.activeCategory==category;

//     return InkWell(
//       onTap: (){
//         controller.setActiveCategory(category);
//         _openCategory(context, category, title);
//         },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 6.0),
//         child: Row(
//           children: [
//             Icon(
//               icon,
//               color: isActive ? AppTheme.neon : Colors.white70,
//             ),
//             const SizedBox(width: 10),
//             Text(
//               title,
//               style: TextStyle(
//                 color: isActive ? AppTheme.neon : Colors.white,
//                 fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _categoryHeader(
//     BuildContext context,
//     String title,
//     IconData icon,
//     String category,
//   ) {
//     final controller=context.watch<CategoryController>();
//     final isActive = controller.activeCategory==category;

//     return InkWell(
//       onTap: (){
//         controller.setActiveCategory(category);
//         _openHome(context);
//       },
//       child: Row(
//         children: [
//           Icon(icon, color: isActive ? AppTheme.neon : AppTheme.surfaceLight),
//           const SizedBox(width: 8),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: isActive ? AppTheme.neon : Colors.white70,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

// Widget _categoryCollapsible( BuildContext context, String title, List<String> items, ) { 
//   return ExpansionTile( collapsedIconColor: Colors.white70, 
//   iconColor: AppTheme.neon, 
//   title: Text(title), 
//   children: items.map((queue) 
//   { 
//     return ListTile( dense: true, title: Text(queue), 
//     onTap: () => _openCategory(context, queue.toLowerCase(), queue), ); 
//     }).toList(), ); }
// }

//   void _openCategory(BuildContext context, String category, String title) {
//     final route = ModalRoute.of(context);

//     final isOnHome = route?.isFirst ?? false;

//     final page = CategoryFilesPage(
//       category: category,
//       title: title,
//     );

//     if (isOnHome) {
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(builder: (_) => page),
//       // );
//       Navigator.push(
//         context,
//         PageRouteBuilder(
//           transitionDuration: const Duration(milliseconds: 250),
//           transitionsBuilder: (_,animation,__,child){
//             return FadeTransition(opacity: animation,child: child,);
//           },
//           pageBuilder: (_,__,___)=>page,),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         PageRouteBuilder(
//           transitionDuration: const Duration(milliseconds: 250),
//           transitionsBuilder: (_,animation,__,child){
//             return FadeTransition(opacity: animation,child: child,);
//           },
//           pageBuilder: (_,__,___)=>page,),
//       );
//     }
//   }


//   void _openHome(BuildContext context) {
//   Navigator.popUntil(context, (route) => route.isFirst);
//   }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/app_theme.dart';
import '../pages/categories_page.dart';
import '../controllers/categories_controller.dart';

class CategoriesSidebar extends StatelessWidget {
  const CategoriesSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CategoryController>();
    final isCollapsed = controller.isSidebarCollapsed;

    return AnimatedContainer(
      clipBehavior: Clip.hardEdge,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      width: isCollapsed ? 80 : 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildHeader(context, controller, isCollapsed),
          const SizedBox(height: 12),
          Divider(color: Theme.of(context).primaryColor, thickness: 1),
          const SizedBox(height: 12),
          Expanded(child: _buildCategoriesList(context, isCollapsed)),
        ],
      ),
    );
  }

  // ───────────────── HEADER ─────────────────

  Widget _buildHeader(
  BuildContext context,
  CategoryController controller,
  bool isCollapsed,
) {
  final isActive = controller.activeCategory == 'all';

  return SizedBox(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: Icon(
            Icons.folder,
            color: isActive ? Theme.of(context).primaryColor : Colors.white70,
          ),
          onPressed: () {
            controller.setActiveCategory('all');
            _openHome(context);
          },
        ),

        if (!isCollapsed)
          Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
            child:Text(
              "Recent",
              overflow: TextOverflow.ellipsis,
            ),
            onTap:(){
              controller.setActiveCategory('all');
            _openHome(context);
            }
            ),
          ),
        ),
        
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          splashRadius: 8,
          onPressed: controller.toggleSidebar,
          icon: AnimatedRotation(
            duration: const Duration(milliseconds: 250),
            turns: isCollapsed ? 0.5 : 0,
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 14,
            ),
          ),
        ),
      ],
    ),
  );
}



  Widget _buildCategoriesList(
    BuildContext context,
    bool isCollapsed,
  ) {
    return ListView.separated(
      itemCount: 5,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final items = [
          _categoryItem(context, 'Compressed', Icons.archive, 'compressed', isCollapsed),
          _categoryItem(context, 'Documents', Icons.description, 'documents', isCollapsed),
          _categoryItem(context, 'Music', Icons.music_note, 'music', isCollapsed),
          _categoryItem(context, 'Program', Icons.code, 'program', isCollapsed),
          _categoryItem(context, 'Video', Icons.movie, 'video', isCollapsed),
          // _categoryCollapsible(context, 'Queues', ['Queue 1', 'Queue 2'], isCollapsed),
        ];
        return items[index];
      },
    );
  }

  Widget _categoryItem(
    BuildContext context,
    String title,
    IconData icon,
    String category,
    bool isCollapsed,
  ) {
    final controller = context.watch<CategoryController>();
    final isActive = controller.activeCategory == category;

    return Tooltip(
      message: isCollapsed ? title : '',
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: () {
          controller.setActiveCategory(category);
          _openCategory(context, category, title);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              Icon(
                icon,
                color: isActive ? Theme.of(context).primaryColor: Theme.of(context).focusColor,
              ),
              if (!isCollapsed) ...[
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isActive ? Theme.of(context).primaryColor : Theme.of(context).focusColor,
                      fontWeight:
                          isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Widget _categoryCollapsible(
  //   BuildContext context,
  //   String title,
  //   List<String> items,
  //   bool isCollapsed,
  // ) {
  //   if (isCollapsed) {
  //     return Center(
  //       child: IconButton(
  //         padding: EdgeInsets.zero,
  //         constraints: const BoxConstraints(),
  //         tooltip: title,
  //         icon: const Icon(Icons.queue, color: Colors.white70),
  //         onPressed: () {
  //           context.read<CategoryController>().setSidebarCollapsed(false);
  //         },
  //       ),
  //     );
  //   }

  //   return ExpansionTile(
  //     collapsedIconColor: Colors.white70,
  //     iconColor: AppTheme.neon,
  //     title: Text(title),
  //     children: items.map((queue) {
  //       return ListTile(
  //         dense: true,
  //         title: Text(queue),
  //         onTap: () =>
  //             _openCategory(context, queue.toLowerCase(), queue),
  //       );
  //     }).toList(),
  //   );
  // }

  void _openCategory(
    BuildContext context,
    String category,
    String title,
  ) {
    final route = ModalRoute.of(context);
    final isOnHome = route?.isFirst ?? false;

    final page = CategoryFilesPage(
      category: category,
      title: title,
    );

    final routeBuilder = PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) =>
          FadeTransition(opacity: animation, child: child),
    );

    if (isOnHome) {
      Navigator.push(context, routeBuilder);
    } else {
      Navigator.pushReplacement(context, routeBuilder);
    }
  }

  void _openHome(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:iba_course_2/bloc/juice_bloc/juice_bloc.dart';
// import 'package:flutter/material.dart';

// class JuicePage extends StatelessWidget {
//   const JuicePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text(
//           'Details',
//           style: TextStyle(fontSize: 16, color: Colors.grey),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.share),
//             onPressed: () {},
//           ),
//         ],
//         elevation: 0,
//         backgroundColor: const Color.fromARGB(255, 197, 121, 146),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header Section
//           const Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [],
//             ),
//           ),
//           const Divider(),

//           // Juice List
//           Expanded(
//             child: BlocBuilder<JuiceBloc, JuiceState>(
//               builder: (context, state) {
//                 final juiceDetails = state.juice as Map<String, dynamic>? ?? {}; 
//                 return Text(juiceDetails['name']); 
//   },
// );

//                 if (state is JuiceLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is JuiceLoaded) {
//                   final juice = state.juice as Map<String, dynamic>? ?? {};
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16.0, vertical: 8.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.3),
//                             blurRadius: 6,
//                             offset: const Offset(0, 4),
//                           )
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             // juice['imageUrl'] != null &&
//                             //         juice['imageUrl'].isNotEmpty
//                             //     ? CircleAvatar(
//                             //         backgroundImage:
//                             //             NetworkImage(juice['imageUrl']),
//                             //         radius: 25,
//                             //       )
//                             //     : const CircleAvatar(
//                             //         radius: 25,
//                             //         child: Icon(Icons.image),
//                             //       ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     juice['name'],
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     (juice['grams']),
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 } else if (state is JuiceError) {
//                   return Center(child: Text(state.message));
//                 }
//                 return const Center(child: Text('No juices found.'));
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

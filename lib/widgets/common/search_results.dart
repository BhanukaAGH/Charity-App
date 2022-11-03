// import '../widgets/home/curve_painter.dart';
// import '../widgets/home/slider.dart';

// class ViewSingleFundraiserScreen extends StatefulWidget {
//   const ViewSingleFundraiserScreen({super.key});

//   @override
//   State<ViewSingleFundraiserScreen> createState() => _ViewSingleFundraiserScreenState();
// }

// class _ViewSingleFundraiserScreenState extends State<ViewSingleFundraiserScreen> {
//     @override
//   Widget build(BuildContext context) {
//     var alreadySaved=false;
//     return Scaffold(
//         appBar: AppBar(
//         elevation: 2,
//         leading: IconButton(
//           tooltip: 'Back',
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//         ),
//         title: Text(
//           'Fundraiser',
//           style: GoogleFonts.urbanist(
//             fontSize: 24,
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//           ),
//         ),
//            actions: [
//           ActionButton2(
//             onPressed: () {
//             Fluttertoast.showToast(
//                   msg: "Shared",  // message
//                   toastLength: Toast.LENGTH_SHORT, // length
//                   gravity: ToastGravity.CENTER,    // location
//                   timeInSecForIosWeb: 1// duration
//               );
//             },
//             icons: Icons.share,
//           ),
//           const SizedBox(width: 12),
//           ActionButton2(
//             onPressed: () {
//                 alreadySaved=true;
//             },
//             icons: (alreadySaved? Icons.bookmark: Icons.bookmark_border),
//           ),
//           const SizedBox(width: 12),
//         ],
//         backgroundColor: secondaryColor,
//         centerTitle: true,
        
//       ),
//              body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               width: double.infinity,
//               height: MediaQuery.of(context).size.height / 10.2,
//               // child: CustomPaint(
//               //   painter: CurvePainter(),
//               //   child: Column(
//               //     mainAxisAlignment: MainAxisAlignment.start,
//               //     children: [
//               //     ],
//               //   ),
//               // ),
//             ),
//             Container(
//               transform: Matrix4.translationValues(0.0, -28.0, 0.0),
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Results Found',
//                     style: GoogleFonts.urbanist(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               transform: Matrix4.translationValues(0.0, -26.0, 0.0),
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: const CategoryList(),
//             ),
//           ],
//         ),
//       ),
//     );
    
//   }

// }

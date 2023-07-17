//import 'package:flutter/material.dart';
//
//class ExploreScreen extends StatefulWidget {
//  const ExploreScreen({super.key});
//
//  @override
//  State<ExploreScreen> createState() => _ExploreScreenState();
//}
//
//class _ExploreScreenState extends State<ExploreScreen> {
//  @override
//  Widget build(BuildContext context) {
//    return const Scaffold(body: Text("Keşfet"),);
//  }
//}
import 'package:flutter/material.dart';
import 'package:your_app/where_to_find_page.dart';
import 'package:your_app/opinions_page.dart';
import 'package:your_app/got_it_page.dart';
import 'package:your_app/is_it_good_page.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<String> popularPhotos = [
    'https://example.com/photo1.jpg',
    'https://example.com/photo2.jpg',
    'https://example.com/photo3.jpg',
    // ... diğer fotoğraflar
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keşfet'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton(
                "#NerdeBulurum",
                Color(0xFFF72585),
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WhereToFindPage(),
                    ),
                  );
                },
              ),
              _buildButton(
                "#SizceHangisi",
                Color(0xFF7209B7),
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OpinionsPage(),
                    ),
                  );
                },
              ),
              _buildButton(
                "#BunuAldım",
                Color(0xFF3A0CA3),
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GotItPage(),
                    ),
                  );
                },
              ),
              _buildButton(
                "OlmuşMu",
                Color(0xFF4361EE),
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IsItGoodPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: popularPhotos.length,
              itemBuilder: (context, index) {
                String photoUrl = popularPhotos[index];
                if (index % 2 == 0) {
                  return Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(photoUrl),
                    ),
                  );
                } else {
                  return Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(photoUrl),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

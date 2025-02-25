
import 'package:flutter/material.dart';

class AnimeDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Постер
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black54, Colors.transparent],
              ),
            ),
          ),
          // Кнопка назад и избранное
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
                IconButton(icon: Icon(Icons.favorite_border, color: Colors.white), onPressed: () {}),
              ],
            ),
          ),
          // Контент
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Naruto', style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.bold)),
                    Row(children: [Text('★ 8.5', style: TextStyle(color: Colors.amber)), SizedBox(width: 8), Text('TV • 24 ep')]),
                    Wrap(spacing: 8, children: [Chip(label: Text('Action')), Chip(label: Text('Adventure'))]),
                    SizedBox(height: 16),
                    Text('Description...', style: TextStyle(fontFamily: 'Roboto')),
                    SizedBox(height: 16),
                    ElevatedButton(onPressed: () {}, child: Text('Episodes')),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
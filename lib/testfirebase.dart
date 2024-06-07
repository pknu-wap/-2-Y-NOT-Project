import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageGridScreen(),
    );
  }
}

class ImageGridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Grid')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('book').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          var images = snapshot.data!.docs;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: images.length,
            itemBuilder: (context, index) {
              var image = images[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageDetailScreen(imageId: image.id),
                  ),
                ),
                child: Image.network(image['Image']),
              );
            },
          );
        },
      ),
    );
  }
}

class ImageDetailScreen extends StatelessWidget {
  final String imageId;

  ImageDetailScreen({required this.imageId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Detail')),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('images').doc(imageId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          var imageData = snapshot.data!.data()!;
          return Column(
            children: [
              Image.network(imageData['Image']),
              SizedBox(height: 8.0),
              Text(imageData['BookTitle']),
            ],
          );
        },
      ),
    );
  }
}

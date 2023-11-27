import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:galeria_reales/models/image_model.dart';

class ImageDetailsScreen extends StatelessWidget {
  final ImageModel image;

  ImageDetailsScreen({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Imagen'),
      ),
      body: Container(
        child: PhotoViewGallery.builder(
          itemCount: 1,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(image.largeImageURL),
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 2,
            );
          },
          scrollPhysics: BouncingScrollPhysics(),
          backgroundDecoration: BoxDecoration(
            color: Colors.black,
          ),
          pageController: PageController(),
        ),
      ),
    );
  }
}

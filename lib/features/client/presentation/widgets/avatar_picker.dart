import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AvatarPicker extends StatelessWidget {
  final String? currentImagePath;
  final Function(File) onImageSelected;

  const AvatarPicker({
    super.key,
    this.currentImagePath,
    required this.onImageSelected,
  });

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 800,
      maxHeight: 800,
    );
    
    if (image != null) {
      onImageSelected(File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              image: currentImagePath != null
                  ? DecorationImage(
                      image: FileImage(File(currentImagePath!)),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: currentImagePath == null
                ? Icon(
                    Icons.person,
                    size: 50,
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                  )
                : null,
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: IconButton(
                icon: const Icon(Icons.camera_alt, size: 20),
                color: Colors.white,
                onPressed: _pickImage,
                constraints: const BoxConstraints(
                  minWidth: 36,
                  minHeight: 36,
                ),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

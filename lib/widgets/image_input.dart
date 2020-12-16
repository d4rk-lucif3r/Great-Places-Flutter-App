import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storeImage;
  Future<void> _takePicture() async {
    try {
      final imageFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );
      if (imageFile != null) {
        var fileImage = File(imageFile.path);
        setState(() {
          _storeImage = fileImage;
        });
        final appDir = await syspath.getApplicationDocumentsDirectory();
        final fileName = path.basename(fileImage.path);
        final savedImage = await fileImage.copy('${appDir.path}/$fileName');
        widget.onSelectImage(savedImage);
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.amberAccent),
          ),
          child: _storeImage != null
              ? Image.file(
                  _storeImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Added',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: FlatButton.icon(
          focusColor: Colors.amberAccent,
          onPressed: _takePicture,
          icon: Icon(Icons.camera),
          label: Text('Take Image'),
          textColor: Theme.of(context).primaryColor,
        )),
      ],
    );
  }
}

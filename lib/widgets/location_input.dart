import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  Future<void> _getCurrentLocation() async {
    final locaData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: locaData.latitude,
      longitude: locaData.longitude,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
            border: Border.all(
          width: 2,
          color: Colors.amberAccent,
        )),
        height: 170,
        width: double.infinity,
        alignment: Alignment.center,
        child: _previewImageUrl == null
            ? Text(
                'No Location Chosen!!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              )
            : Image.network(
                _previewImageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton.icon(
            icon: Icon(Icons.location_on),
            label: Text('Current Location'),
            onPressed: _getCurrentLocation,
            textColor: Theme.of(context).primaryColor,
          ),
          FlatButton.icon(
            icon: Icon(Icons.map),
            label: Text('Select Location'),
            onPressed: () {},
            textColor: Theme.of(context).primaryColor,
          ),
        ],
      )
    ]);
  }
}

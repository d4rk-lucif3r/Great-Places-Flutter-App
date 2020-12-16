import 'package:flutter/material.dart';
import 'package:places_app/providers/great_places.dart';
import './add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlacesScreen.routeName),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<GreatPlaces>(
          child: Center(
            child: const Text(
              'Got no Places yet start adding some!',
              style: TextStyle(color: Colors.white),
            ),
          ),
          builder: (ctx, placesData, ch) => placesData.items.length <= 0
              ? ch
              : ListView.builder(
                  itemCount: placesData.items.length,
                  itemBuilder: (ctx, index) => Container(
                        margin: EdgeInsets.all(8),
                        child: ClipRRect(
                          
                          borderRadius: BorderRadius.circular(10),
                          child: ListTile(
                            
                            tileColor: Colors.white,
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(placesData.items[index].image),
                            ),
                            title: Text(placesData.items[index].title),
                            onTap: () {},
                          ),
                        ),
                      ))),
    );
  }
}

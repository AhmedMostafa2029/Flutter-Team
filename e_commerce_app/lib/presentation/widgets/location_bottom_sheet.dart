// location_bottom_sheet.dart
import 'package:e_commerce_app/data/models/locations_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationBottomSheet extends StatelessWidget {
  const LocationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Text(
              'Locations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(height: 1, thickness: 2),
          Expanded(
            child: Consumer<LocationsModel>(
              builder: (context, locationsModel, child) {
                final locations = locationsModel.locations;

                return ListView.builder(
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                      ),
                      child: ListTile(
                        title: Text(locations[index]),
                        onTap: () {
                          locationsModel.updateSelectedLocation(index);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                // showModalBottomSheet(
                //   context: context,
                //   builder: (context) => const AddLocationBottomSheet(),
                // );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                margin: const EdgeInsets.only(bottom: 16, right: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('Add Location'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

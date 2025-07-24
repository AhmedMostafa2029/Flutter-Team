
import 'package:e_commerce_app/data/models/locations_model.dart';
import 'package:e_commerce_app/presentation/widgets/home/cart_icon_with_count.dart';
import 'package:e_commerce_app/presentation/widgets/cart/location_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Delivery address",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Consumer<LocationsModel>(
                  builder: (context, locationsModel, child) {
                    return Text(
                      locationsModel.selectedLocation,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    );
                  },
                ),
                SizedBox(width: 5),
                GestureDetector(
                  child: Icon(IconsaxPlusLinear.arrow_down, size: 20),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return LocationBottomSheet();
                      },
                    );
                  },
                ),
              ],
            ),
            Row(
              children: const [
                CartIconWithCount(),
                Icon(IconsaxPlusLinear.notification, size: 28),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

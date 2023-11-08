import 'package:expede/src/core/ui/app_icons.dart';
import 'package:expede/src/core/ui/constants.dart';
import 'package:expede/src/model/customer_model.dart';
import 'package:flutter/material.dart';

class HomeCustomersTile extends StatelessWidget {
  final CustomerModel customer;

  const HomeCustomersTile({super.key, required this.customer});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      width: 200,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorsConstants.grey,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: switch (customer.avatar) {
            //       final avatar? => NetworkImage(avatar),
            //       _ => const AssetImage(ImageConstants.avatar)
            //     } as ImageProvider,
            //   ),
            // ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  customer.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/schedule', arguments: customer);
                      },
                      child: const Text('AGENDAR'),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/customer/schedule', arguments: customer);
                      },
                      child: const Text('VER AGENDA'),
                    ),
                    const Icon(
                      AppIcons.penEdit,
                      size: 16,
                      color: ColorsConstants.brow,
                    ),
                    const Icon(
                      AppIcons.trash,
                      size: 16,
                      color: ColorsConstants.red,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:expede/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class HomeFeaturesSystem extends StatelessWidget {
  const HomeFeaturesSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                await Navigator.of(context)
                    .pushNamed('/home/browser/customers');
                // ref.invalidate(getMeProvider);
                // ref.invalidate(homeAdmVmProvider);
              },
              child: const Feature(
                name: 'Clientes',
                image: ImageConstants.client,
              ),
            ),
            InkWell(
              onTap: () async {
                await Navigator.of(context)
                    .pushNamed('/home/browser/employees');
                // ref.invalidate(getMeProvider);
                // ref.invalidate(homeAdmVmProvider);
              },
              child: const Feature(
                name: 'Usuarios',
                image: ImageConstants.client,
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () async {
            await Navigator.of(context).pushNamed('/employee/register');
            // ref.invalidate(getMeProvider);
            // ref.invalidate(homeAdmVmProvider);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  await Navigator.of(context)
                      .pushNamed('/home/browser/shipments');
                  // ref.invalidate(getMeProvider);
                  // ref.invalidate(homeAdmVmProvider);
                },
                child: const Feature(
                  name: 'Carregamento',
                  image: ImageConstants.shipments,
                ),
              ),
              InkWell(
                onTap: () async {
                  await Navigator.of(context)
                      .pushNamed('/home/browser/items_shipment');
                  // ref.invalidate(getMeProvider);
                  // ref.invalidate(homeAdmVmProvider);
                },
                child: const Feature(
                  name: 'Cargas',
                  image: ImageConstants.boxBoarding,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () async {
            await Navigator.of(context).pushNamed('/employee/register');
            // ref.invalidate(getMeProvider);
            // ref.invalidate(homeAdmVmProvider);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  await Navigator.of(context)
                      .pushNamed('/mqtt/conected');
                  // ref.invalidate(getMeProvider);
                  // ref.invalidate(homeAdmVmProvider);
                },
                child: const Feature(
                  name: 'Mqtt',
                  image: ImageConstants.shipments,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Feature extends StatelessWidget {
  final String name;
  final String image;
  const Feature({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    // final Feature() = widget;

    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10),
      width: 160,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorsConstants.grey,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    image,
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

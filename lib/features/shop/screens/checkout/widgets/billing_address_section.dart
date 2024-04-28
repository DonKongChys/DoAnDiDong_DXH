import 'package:TShop/common/widgets/texts/section_heading.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:flutter/material.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(title: 'Shipping Address', buttonTitle: 'Change', onPressed: (){}),
        Text('Doan Ngoc Tuan', style: Theme.of(context).textTheme.bodyLarge),

        Row(
          children: [
            const Icon(Icons.phone, color: Colors.grey, size: 16),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text('0399999999', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(width: TSizes.spaceBtwItems / 2),

         Row(
          children: [
            const Icon(Icons.location_history, color: Colors.grey, size: 16),
            const SizedBox(width: TSizes.spaceBtwItems),
            Expanded(child: Text('KTX Khu A, phuong Linh Trung, Thu Duc, TP HCM', style: Theme.of(context).textTheme.bodyMedium, softWrap: true)),
          ],
        ),
      ],
    );
  }
}
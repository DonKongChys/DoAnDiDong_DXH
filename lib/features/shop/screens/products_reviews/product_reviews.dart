import 'package:TShop/common/widgets/appbar/appbar.dart';
import 'package:TShop/common/widgets/layouts/grid_layout.dart';
import 'package:TShop/common/widgets/products/ratings/rating_indicator.dart';
import 'package:TShop/features/personalization/controllers/user_controller.dart';
import 'package:TShop/features/shop/controllers/review_controller.dart';
import 'package:TShop/features/shop/screens/products_reviews/widgets/rating_progress_indicator.dart';
import 'package:TShop/features/shop/screens/products_reviews/widgets/user_review_card.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController reviewController = TextEditingController();
    double userRating = 0.0;
    final controller = Get.put(ReviewController());
    return Scaffold(
      /// -- Appbar;
      appBar: const TAppBar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true,
      ),

      /// --  Body
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                      "Ratings and reviews are verified and are from people who use the same type of same type of device that you use."),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  /// User Rating Input
                  const Text(
                    "Đánh giá cho sản phẩm này:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      userRating = rating;
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// User Review Input
                  const Text(
                    "Viết góp ý của bạn:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TextField(
                    controller: reviewController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: "Mô tả trải nghiệm của bạn...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Submit Button
                  ElevatedButton(
                    onPressed: () {
                      final review = reviewController.text;
                      if (userRating > 0 && review.isNotEmpty) {
                        controller.addReview(review, userRating.toString());
                      }
                    },
                    child: const Text("Gửi"),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Overall Product Ratings
                  const TOverallProductRating(),
                  const TRatingBarIndicator(
                    rating: 3.5,
                  ),
                  Text(
                    "12.61",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  /// User Reviews List

                  // const UserReviewCard(),
                  Obx(() {
                    // final allUsers = controller.featureUsers;

                    final allReviews = controller.allReviews.reversed.toList();

                    return SingleChildScrollView(
                      child: Column(
                        children: allReviews.map((review) {
                          return UserReviewCard(review: review);
                        }).toList(),
                      ),
                    );
                  }),
                ],
              ))),
    );
  }
}

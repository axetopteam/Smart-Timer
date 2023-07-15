import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/purchasing/adapty_extensions.dart';

class ProductContainer extends StatelessWidget {
  const ProductContainer({
    required this.product,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final AdaptyPaywallProduct product;
  final bool isSelected;
  final void Function(AdaptyPaywallProduct) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(product),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white10,
          border: isSelected
              ? Border.all(
                  color: context.color.accent,
                  width: 3,
                  strokeAlign: BorderSide.strokeAlignOutside,
                )
              : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: isSelected ? null : context.color.secondaryText,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${product.localizedPrice ?? ''} / ${product.readbleSubscriptionPeriod ?? ''}',
              style: context.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  String get title {
    if (product.isUnlim) {
      return 'Billed once';
    } else {
      final localizedSubscriptionPeriod = product.introductoryDiscount?.localizedSubscriptionPeriod;

      if (product.trialIsAvailable) {
        return '$localizedSubscriptionPeriod free trial';
      } else {
        return 'Subscription';
      }
    }
  }
}

class ProductContainerPlaceholder extends StatelessWidget {
  const ProductContainerPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.black,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Subscription',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: context.color.secondaryText,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '',
              style: context.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

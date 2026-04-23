import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_assets/extensions/extensions.dart';
import 'package:shared_assets/widgets/ui/unified_snackbar.dart';

Future<String?> processStripePayment({
  required BuildContext context,
  required String clientSecret,
  required String paymentIntentId,
}) async {
  try {
    // 1. Initialize the Payment Sheet using the secret we already fetched
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: "Freequick",
        style: ThemeMode.light,
        appearance: const PaymentSheetAppearance(
          colors: PaymentSheetAppearanceColors(
            primary: Colors.red,
            background: Colors.white,
          ),
          shapes: PaymentSheetShape(
            borderRadius: 12,
            borderWidth: 0.5,
          ),
          primaryButton: PaymentSheetPrimaryButtonAppearance(
            colors: PaymentSheetPrimaryButtonTheme(
              light: PaymentSheetPrimaryButtonThemeColors(
                background: Colors.redAccent,
                text: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );

    // 2. Display the sheet to the user
    await Stripe.instance.presentPaymentSheet();

    // 3. Verify the payment status
    final paymentIntent =
        await Stripe.instance.retrievePaymentIntent(clientSecret);

    if (paymentIntent.status == PaymentIntentsStatus.Succeeded) {
      final callable = FirebaseFunctions.instanceFor(
        region: 'europe-west1',
      ).httpsCallable('getPaymentMethodType');

      final result = await callable.call({
        'paymentIntentId': paymentIntentId,
      });

      return result.data['paymentMethodType'] as String? ?? 'card';
    }

    unifiedSnackBar(
      context.l10nCustomer.paymentNotCompleted,
      error: true,
    );
    return null;
  } on StripeException catch (_) {
    // Stripe-specific errors (like user cancellation)
    unifiedSnackBar(
      context.l10nCustomer.paymentCancelled,
      error: true,
    );
    return null;
  } catch (e) {
    // General errors
    unifiedSnackBar(
      context.l10nCustomer.paymentFailed(e.toString()),
      error: true,
    );
    return null;
  }
}
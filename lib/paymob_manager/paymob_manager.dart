import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:charity/constant/url.dart';

class PayMobManager {
  Future<String> getPaymentKey({
    required int amount,
    required String currency,
    required String email,
    required String phone,
    required String firstName,
    required String lastName,
  })async{
    try {
      String authenticationToken= await _getAuthenticationToken();

      int orderId= await _getOrderId(
        authenticationToken: authenticationToken,
        amount: (100*amount).toString(),
        currency: currency,
      );

      String paymentKey= await _getPaymentKey(
        authenticationToken: authenticationToken,
        amount: (100*amount).toString(),
        currency: currency,
        orderId: orderId.toString(),
        phone: phone,
        email: email,
        firstName: firstName,
        lastName: lastName,
      );
      return paymentKey;
    } catch (e) {
      log("Exc==========================================");
      log(e.toString());
      throw Exception();
    }
  }

  //this is the first step: authentication step
  //in this step we tell payMob who want to pay
  Future<String> _getAuthenticationToken() async {
    final Response response =
        await Dio().post("https://accept.paymob.com/api/auth/tokens", data: {
      "api_key": URLs.apiKey,
    });
    //note that the token is valid for one hour
    return response.data["token"];
  }

  /*
  * At this step, you will register an order to Accepts database,
  * so that you can pay for it later using a transaction
   Order ID will be the identifier that you will use to link the transaction(s)
  * performed to your system,
  * as one order can have more than one transaction.*/
  Future<int>_getOrderId({
    required String authenticationToken,
    required String amount,
    required String currency,
  })async{
    final Response response=await Dio().post(
        "https://accept.paymob.com/api/ecommerce/orders",
        data: {
          "auth_token":  authenticationToken,
          "amount_cents":amount, //  >>(STRING)<<
          "currency": currency,//Not Req
          "delivery_needed": "false",
          "items": [],
        }
    );
    return response.data["id"];  //INTEGER
  }

  /*At this step, you will obtain a payment_key token.
  This key will be used to authenticate your payment request
  It will be also used for verifying your transaction request metadata.*/
  Future<String> _getPaymentKey({
    required String authenticationToken,
    required String orderId,
    required String amount,
    required String currency,
    required String email,
    required String phone,
    required String firstName,
    required String lastName,
  }) async{
    final Response response=await Dio().post(
        "https://accept.paymob.com/api/acceptance/payment_keys",
        data: {
          //ALL OF THEM ARE REQUIRED
          "expiration": 3600,

          "auth_token": authenticationToken,//From First Api
          "order_id": orderId,//From Second Api  >>(STRING)<<
          "integration_id": URLs.cardPaymentMethodIntegrationId,//Integration Id Of The Payment Method

          "amount_cents": amount,
          "currency": currency,

          "billing_data": {
            //Have To Be Values
            "first_name": firstName,
            "last_name": lastName,
            "email": email,
            "phone_number": phone,

            //Can Set "NA"
            "apartment": "NA",
            "floor": "NA",
            "street": "NA",
            "building": "NA",
            "shipping_method": "NA",
            "postal_code": "NA",
            "city": "NA",
            "country": "NA",
            "state": "NA"
          },
        }
    );
    return response.data["token"];
  }


}

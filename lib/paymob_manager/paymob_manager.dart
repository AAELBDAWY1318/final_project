import 'dart:developer';

import 'package:charity/constant/api_constants.dart';
import 'package:charity/dio_helper/dio_helper.dart';
import 'package:dio/dio.dart';

class PayMobManager {
  Future<void> getAuthToken() async {
    try {
      Response response =
          await DioHelper.postData(url: ApiContest.getAuthToken, data: {
        'api_key': ApiContest.paymentApiKey,
      });
      String authToken = response.data['token'];
      ApiContest.paymentFirstToken = authToken;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String> getOrderRegistrationID({
    required String amount,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    String visaUrl = '';
    try {
      Response response =
          await DioHelper.postData(url: ApiContest.getOrderId, data: {
        'auth_token': ApiContest.paymentFirstToken,
        "delivery_needed": "false",
        "amount_cents": amount,
        "currency": "EGP",
        "items": [],
      });
      int id = response.data['id'];
      ApiContest.paymentOrderId = id.toString();
      visaUrl =  ApiContest.visaUrl + await getPaymentRequest(amount, firstName, lastName, email, phone);
    } catch (e) {
      log(e.toString());
    }
    return visaUrl;
  }

  Future<String> getPaymentRequest(
    String amount,
    String firstName,
    String lastName,
    String email,
    String phone,
  ) async {
    String finalToken = '';
    try{
      Response response = await DioHelper.postData(
        url: ApiContest.getPaymentRequest,
        data: {
          "auth_token": ApiContest.paymentFirstToken,
          "amount_cents": amount,
          "expiration": 3600,
          "order_id": ApiContest.paymentOrderId,
          "billing_data": {
            "apartment": "NA",
            "email": email,
            "floor": "NA",
            "first_name": firstName,
            "street": "NA",
            "building": "NA",
            "phone_number": phone,
            "shipping_method": "NA",
            "postal_code": "NA",
            "city": "NA",
            "country": "NA",
            "last_name": lastName,
            "state": "NA"
          },
          "currency": "EGP",
          "integration_id": ApiContest.integrationIdCard,
          "lock_order_when_paid": "false"
        },
      );
      ApiContest.finalToken = response.data['token'];
      log('Final token 🚀 ${ApiContest.finalToken}');
      log('url 🚀 ${ApiContest.visaUrl}');
      finalToken = ApiContest.finalToken;
    }catch(e){
      log(e.toString());
    }
    return finalToken;
  }
}

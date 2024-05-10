class ApiContest {
  static const String baseUrl = 'https://accept.paymob.com/api';
  static const String paymentApiKey = "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T1RjMU16Z3hMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuZHZpZHBWTXI2akFyRnloek5TaU5maFh5YW5uT2piSzlvWnFVdnJyRXRUQXFuU3N2QnF6MFdQZG5QbXd0Wlc0RW1qNHF6cFhEakYzeVV4bGNlOENsYWc=";
  static const String getAuthToken = '/auth/tokens';
  static const getOrderId = '/ecommerce/orders';
  static const getPaymentRequest = '/acceptance/payment_keys';
  static String visaUrl =
      '$baseUrl/acceptance/iframes/844975?payment_token=';
  static String paymentFirstToken = '';

  static String paymentOrderId = '';

  static String finalToken = '';

  static const String integrationIdCard = '4571272';

}
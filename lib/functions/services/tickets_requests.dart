import 'dart:convert';

import 'package:event_brite_app/models/order_model.dart';
import 'package:event_brite_app/models/returned_order_model/returned_order_model.dart';
import 'package:event_brite_app/models/ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/api.dart';
import '../../providers/token_provider.dart';

class Tickets {
  Future<List<TicketModel>> getTicketClasses(BuildContext context, eventId) async {
    String? token = Provider.of<TokenModel>(context).token;
    List<dynamic> dataUnFiltered = await Api().get(
        url: 'https://event-us.me:8000/booking/events/$eventId/ticket-classes/',
        token:
            'CustomToken $token');
    List<TicketModel> tickets = [];
    for (int i = 0; i < dataUnFiltered.length; i++) {
      tickets.add(TicketModel.fromJson(dataUnFiltered[i]));
    }
    return tickets;
  }

  Future<bool> checkPromocode(String promocode, BuildContext context, eventId) async {
    String? token = Provider.of<TokenModel>(context).token;
    Map<String, dynamic> promocodeValidationUnjsoned = await Api().get(
        url:
            'https://event-us.me:8000/booking/events/$eventId/promocode/?promocode=$promocode',
        token:
            'CustomToken $token');
    bool promocodeValidation = promocodeValidationUnjsoned['is_valid_promocode'];
    return promocodeValidation;
  }

  Future<Map<String, dynamic>> postOrderRequest(
      List<Map<String, dynamic>> order_items, String promocode, int eventId, BuildContext context) async {
        String? token = Provider.of<TokenModel>(context).token;
    Map results = await Api().post(
        url:
            'https://event-us.me:8000/booking/event/$eventId/orders/?ticket_class_id',
        body: {'order_items': order_items,
                'promocode': promocode,
        },
        token:
            'CustomToken $token');
    //print(results.toString());
    Map<String, dynamic> ret = results['response'];
    // List<ReturnedOrderModel> ret = (results["response"]['tickets'] as List).map((e) {
    //   return ReturnedOrderModel.fromJson(e);
    // }).toList();
    // // await Future.delayed(const Duration(seconds: 5));
    return ret;
  }

  Future<Map<String, dynamic>> getOrderDetails(int orderId) async {
    Future<Map<String, dynamic>> orderSummary = await Api().get(
        url: 'https://event-us.me:8000/booking/order$orderId/order_items/',
        token:
            'CustomToken 3743b5ecba1461fcbf9ba874653ea8dc6792bd1a58ef656133dc71321f148332');
    return orderSummary;
  }
}

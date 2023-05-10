import 'package:equatable/equatable.dart';

class OrderItemsGetModel extends Equatable {
	final int? ticketClassId;
	final int? quantity;
	final int? orderId;
	final int? userId;
	final int? eventId;
	final int? ticketPrice;

	const OrderItemsGetModel({
		this.ticketClassId, 
		this.quantity, 
		this.orderId, 
		this.userId, 
		this.eventId, 
		this.ticketPrice, 
	});

	factory OrderItemsGetModel.fromJson(Map<String, dynamic> json) {
		return OrderItemsGetModel(
			ticketClassId: json['ticket_class_id'] as int?,
			quantity: json['quantity'] as int?,
			orderId: json['order_id'] as int?,
			userId: json['user_id'] as int?,
			eventId: json['event_id'] as int?,
			ticketPrice: json['ticket_price'] as int?,
		);
	}



	Map<String, dynamic> toJson() => {
				'ticket_class_id': ticketClassId,
				'quantity': quantity,
				'order_id': orderId,
				'user_id': userId,
				'event_id': eventId,
				'ticket_price': ticketPrice,
			};

	@override
	List<Object?> get props {
		return [
				ticketClassId,
				quantity,
				orderId,
				userId,
				eventId,
				ticketPrice,
		];
	}
}

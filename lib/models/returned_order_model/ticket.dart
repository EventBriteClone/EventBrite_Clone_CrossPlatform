import 'package:equatable/equatable.dart';

class Ticket extends Equatable {
	final int? ticketClassId;
	final int? quantity;
	final int? orderId;
	final int? ticketPrice;
	final int? userId;
	final int? eventId;

	const Ticket({
		this.ticketClassId, 
		this.quantity, 
		this.orderId, 
		this.ticketPrice, 
		this.userId, 
		this.eventId, 
	});

	factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
				ticketClassId: json['ticket_class_id'] as int?,
				quantity: json['quantity'] as int?,
				orderId: json['order_id'] as int?,
				ticketPrice: json['ticket_price'] as int?,
				userId: json['user_id'] as int?,
				eventId: json['event_id'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'ticket_class_id': ticketClassId,
				'quantity': quantity,
				'order_id': orderId,
				'ticket_price': ticketPrice,
				'user_id': userId,
				'event_id': eventId,
			};

	@override
	List<Object?> get props {
		return [
				ticketClassId,
				quantity,
				orderId,
				ticketPrice,
				userId,
				eventId,
		];
	}
}

import 'package:equatable/equatable.dart';

class SoldTicketModel extends Equatable {
	final int? id;
	final int? quantitySold;
	final int? capacity;

	const SoldTicketModel({this.id, this.quantitySold, this.capacity});

	factory SoldTicketModel.fromJson(Map<String, dynamic> json) {
		return SoldTicketModel(
			id: json['ID'] as int?,
			quantitySold: json['quantity_sold'] as int?,
			capacity: json['capacity'] as int?,
		);
	}



	Map<String, dynamic> toJson() => {
				'ID': id,
				'quantity_sold': quantitySold,
				'capacity': capacity,
			};

	@override
	List<Object?> get props => [id, quantitySold, capacity];
}

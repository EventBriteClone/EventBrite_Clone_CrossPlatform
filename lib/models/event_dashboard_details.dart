import 'package:equatable/equatable.dart';

class EventDashboardDetails extends Equatable {
	final int? id;
	final int? quantitySold;
	final int? capacity;

	const EventDashboardDetails({this.id, this.quantitySold, this.capacity});

	factory EventDashboardDetails.fromJson(Map<String, dynamic> json) {
		return EventDashboardDetails(
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

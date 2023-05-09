double calculateServiceFee(double ticketPrice) {
  double serviceFee = (ticketPrice * 0.037) + 1.79;
  return double.parse(serviceFee.toStringAsFixed(2));
}

double calculateProcessingFee(double ticketPrice) {
  double processingFee =
      0.029 * (calculateServiceFee(ticketPrice) + ticketPrice);
  return double.parse(processingFee.toStringAsFixed(2));
}

double calculateTicketPriceAfterFees(double ticketPrice) {
  double totalTicketPrice = ticketPrice +
      calculateServiceFee(ticketPrice) +
      calculateProcessingFee(ticketPrice);
  return double.parse(totalTicketPrice.toStringAsFixed(2));
}

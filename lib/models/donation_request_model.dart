class DonationRequest {
  String name;
  String email;
  String description;
  double amount;
  String status;

  DonationRequest({
    required this.name,
    required this.email,
    required this.description,
    required this.amount,
    required this.status,
  });

  // 🧩 Convert model to map (for Firestore use later)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'description': description,
      'amount': amount,
      'status': status,
    };
  }

  // 🔁 Convert Firestore document to model
  factory DonationRequest.fromMap(Map<String, dynamic> map) {
    return DonationRequest(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      description: map['description'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      status: map['status'] ?? 'Pending',
    );
  }
}

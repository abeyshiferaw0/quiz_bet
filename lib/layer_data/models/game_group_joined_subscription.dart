class GameGroupJoinedSubscription{

  final String id;
  final String userName;
  final String fullName;
  final String phoneNumber;


  GameGroupJoinedSubscription({required this.fullName,required this.phoneNumber, required this.id, required this.userName});

  factory GameGroupJoinedSubscription.fromJson(Map<String, dynamic> json) {
    return GameGroupJoinedSubscription(
      id: json["id"],
      userName: json["user_name"],
      fullName: json["full_name"],
      phoneNumber: json["phone_number"],
    );
  }
//

}
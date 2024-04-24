// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:TShop/utils/formatters/formatters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  // Helper func to get full name
  String get fullName => '$firstName $lastName';

  // Helper func to format phone number
  String get formatPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  //Static func to split fullname into first and last name
  static List<String> nameParts(fullName) => fullName.split(' ');

  //Static func to generate username from fullname
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(' ');
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : '';

    String camelCaseUsername = '$firstName$lastName';
    String usernameWithPrefix = 'cwt_$camelCaseUsername'; //cwt is the prefix

    return usernameWithPrefix;
  }

  //Static func to create an empty user model
  static UserModel empty() => UserModel(
      id: '',
      firstName: '',
      lastName: '',
      username: '',
      email: '',
      phoneNumber: '',
      profilePicture: '');

  //Convert model to json  for storing to firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  //Factury method to create UserModel from firebase snapshot
  factory UserModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
          id: document.id,
          firstName: data['FirstName'],
          lastName: data['LastName'],
          username: data['Username'],
          email: data['Email'],
          phoneNumber: data['PhoneNumber'],
          profilePicture: data['ProfilePicture']);
    } else {
      return UserModel.empty();
    }
  }
}

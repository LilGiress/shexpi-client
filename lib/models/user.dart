
import 'package:collection/collection.dart';

import '../models/social_network.dart';
import '../models/address.dart';

enum UserType {
  Regular,
  Courier,
  Admin,
}

enum AddressType { Personal, Book }
enum TransportType {
  Motorcycle,
  Bike,
  Car,
}

enum UserCivility { Mme, M }

class User {
  final String id;
  final String name;
  final String surname;
  final String email;
  final DateTime birthday;
  final String birthPlace;
  final TransportType transportType;
  final String phone;
  final String dialCode;
  final String currency;
  final UserType type;
  final String gender;
  final String photo;
  final String about;
  final bool isOnline;
  final bool isAdmin;
  final bool isCompany;
  final bool disabled;
  final String verificationCode;
  final String authenticationToken;
  final DateTime verifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Address address;
  final List<Address> addresses;
  final String fullName;
  final String fullNameAbr;
  final SocialNetWork socialNetworks;

  User(
      {this.id,
      this.name,
      this.surname,
      this.email,
      this.birthday,
      this.birthPlace,
      this.transportType,
      this.phone,
      this.dialCode,
      this.currency,
      this.type,
      this.gender,
      this.photo,
      this.about,
      this.isOnline,
      this.isAdmin,
      this.isCompany,
      this.disabled,
      this.verificationCode,
      this.authenticationToken,
      this.verifiedAt,
      this.createdAt,
      this.updatedAt,
      this.address,
      this.addresses,
      this.fullName,
      this.fullNameAbr,
      this.socialNetworks});

  factory User.fromJSON(Map<String, Object> jsonMap) {
    List<Address> _getUserAddresses(List<dynamic> jsonMapAddress) {
      List<Address> _addresses = [];

      jsonMapAddress.forEach((element) {
        _addresses.add(Address.fromJSON(element as Map<String, dynamic>));
      });

      return _addresses;
    }

    final List<Address> addressesResult = jsonMap['addresses'] != null
        ? _getUserAddresses(jsonMap['addresses'])
        : null;

    Address _findAddressByType(String type) {
      return addressesResult.firstWhereOrNull((add) => add.type == type);
    }

    final personalAddress =
        jsonMap['addresses'] != null ? _findAddressByType('personal') : null;

    UserType getUserType(String type) {
      switch (type) {
        case 'admin':
          return UserType.Admin;
          break;
        case 'regular':
          return UserType.Regular;
          break;
        default:
          return UserType.Courier;
      }
    }

    TransportType getTransportType(String type) {
      switch (type) {
        case 'motorcycle':
          return TransportType.Motorcycle;
          break;
        case 'car':
          return TransportType.Car;
          break;
        default:
          return TransportType.Bike;
      }
    }

    String getUserGender(String genre) {
      switch (genre) {
        case 'f':
          return 'femme';
          break;
        case 'm':
          return 'homme';
          break;
        default:
          return 'homme';
      }
    }

    SocialNetWork _getUserSocialNetwork(Map<String, dynamic> jsonMapSocial) {
      return SocialNetWork.fromJSON(jsonMapSocial);
    }

    final _socialNetworksResult = jsonMap['socialNetworks'] != null
        ? _getUserSocialNetwork(jsonMap['socialNetworks'])
        : [];

    return User(
      id: jsonMap['id'].toString(),
      name: jsonMap['name'],
      surname: jsonMap['surname'],
      email: jsonMap['email'],
      birthday: jsonMap['birthday'] != null
          ? DateTime.parse(jsonMap['birthday']).toLocal()
          : null,
      birthPlace: jsonMap['birth_place'],
      transportType: getTransportType(jsonMap['transport_type']),
      phone: jsonMap['phone'],
      dialCode: jsonMap['dial_code'],
      currency: jsonMap['currency'],
      type: getUserType(jsonMap['type']),
      gender: getUserGender(
        jsonMap['gender']!=null?jsonMap['gender']!=null:'m'
        ),
      photo: jsonMap['photo'],
      about: jsonMap['about'],
      //isOnline: jsonMap['isOnline'] ? jsonMap['isOnline'] : false,
      isAdmin: jsonMap['isAdmin'],
      isCompany: jsonMap['isCompany'],
      disabled: jsonMap['disabled'],
      verificationCode: jsonMap['verificationCode'],
      authenticationToken: jsonMap['authenticationToken'],
      verifiedAt: jsonMap['verifiedAt'] != null
          ? DateTime.parse(jsonMap['verifiedAt'])
          : null,
      createdAt: jsonMap['createdAt'] != null
          ? DateTime.parse(jsonMap['createdAt'])
          : null,
      updatedAt: jsonMap['updatedAt'] != null
          ? DateTime.parse(jsonMap['updatedAt'])
          : null,
      address: personalAddress,
      addresses: addressesResult,
      fullName: jsonMap['full_name'],
      fullNameAbr: jsonMap['full_name_abr'],
      //socialNetworks: SocialNetWork.fromJSON(jsonMap['socialNetworks'])
    );
  }
}

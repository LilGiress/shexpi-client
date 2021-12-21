

enum AddressType { Personal, Book }

class SocialNetWork {

  final String linkedin;
  final String facebook;
  final String twitter;
  final String instagram;

  SocialNetWork({this.linkedin, this.facebook, this.twitter, this.instagram});

  factory SocialNetWork.fromJSON(Map<String, dynamic> jsonData){

    return SocialNetWork(
      linkedin: jsonData['linkedin'],
      facebook: jsonData['facebook'],
      twitter: jsonData['twitter'],
      instagram: jsonData['instagram'],
    );
  }
}
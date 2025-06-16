import 'dart:convert';

class User{
  //define fields
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;
  final String token;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.password,
    required this.token,
  });

  //Serialization:Convert User object to a Map
//Map: A Map is a collection if Key-value pairs
//why: Converting to a map is an intermediate step that makes it easier to serialize
//the object to formates like Json for storage or transmission.

Map<String,dynamic> toMap(){
  return <String,dynamic>{
    "id":id,
    "fullName":fullName,
    "email":email,
    "state":state,
    "city":city,
    "locality":locality,
    "password":password,
    "token":token,
  };
}

  //Serialization :Convert Map to a Json String
  //This method directly encodes the data from the Map into a Json String
  //The Json.encode() function convert a dart object(such as map or list)
  //into a json string representation, making it suitable for communication
  //between diffrent systems.


  String  toJson()=> json.encode(toMap());


  //Deserialization: Convert a Map to a User Object
  //purpose- Manipulation and user : Once the data is converted a to a User object
  //it can be esily manipulated and use within the application for ex
  // we might want to display the user's fullname,email etc on the Ui. or we might
  //want to save the data locally.

  //the factory contructor takes a Map(Usually obtained from a Json object)
  //and convert it into a user object.if field is not presend in th,
  //it default to an empty string.

  //fromMap: This constructor take a Map<String,dynamic> and convrt into a User Object
  //its useful when you already have the data in map format
  factory User.fromMap(Map<String,dynamic>map){
    return User(
        id: map['_id'] as String? ??"",
        fullName: map['fullName'] as String? ??"",
        email:map['email'] as String? ??"",
        state: map['state'] as String? ??"",
        city:map['city'] as String? ??"",
        locality:map['locality'] as String? ??"",
        password: map['password'] as String? ??"",
        token: map['token'] as String? ??"",
    );
  }

  //fromJson: this factory constructor takes json String and decodes into a Map<String ,Dynamic>
  //and than uses from Map to convert that Map into a User Object .

  factory User.fromJson(String source)=>User.fromMap(jsonDecode(source)as Map<String,dynamic>);


}
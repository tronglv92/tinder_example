class Profile {
  Profile({this.name, this.id, this.age, this.profile});

  final String name;
  final String id;
  final int age;
  final String profile;
}

List<Profile> profiles = [
  Profile(
    id: "1",
    name: "Caroline",
    age: 24,
    profile: "assets/profiles/1.jpeg",
  ),
  Profile(
    id: "2",
    name: "Jack",
    age: 30,
    profile: "assets/profiles/2.jpeg",
  ),
  Profile(
    id: "3",
    name: "Caroline",
    age: 21,
    profile: "assets/profiles/3.jpeg",
  ),
  Profile(
    id: "4",
    name: "Caroline",
    age: 40,
    profile: "assets/profiles/4.jpg",
  ),

];

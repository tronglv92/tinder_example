class Profile {
  Profile({this.name, this.id, this.age, this.profiles});

  final String name;
  final String id;
  final int age;
  final List<String> profiles;
}

List<Profile> profiles = [
  Profile(
    id: "1",
    name: "Caroline",
    age: 24,
    profiles: ["assets/profiles/1.jpeg","assets/profiles/5.jpeg","assets/profiles/6.jpeg","assets/profiles/7.jpeg"],
  ),
  Profile(
    id: "2",
    name: "Jack",
    age: 30,
    profiles: ["assets/profiles/2.jpeg","assets/profiles/8.jpeg"],
  ),
  Profile(
    id: "3",
    name: "Caroline",
    age: 21,
    profiles: ["assets/profiles/3.jpeg"],
  ),
  Profile(
    id: "4",
    name: "Caroline",
    age: 40,
    profiles: ["assets/profiles/4.jpg","assets/profiles/5.jpeg","assets/profiles/6.jpeg","assets/profiles/7.jpeg"],
  ),
];

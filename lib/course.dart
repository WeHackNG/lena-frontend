import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';


/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Course {
  Course(this.id, this.title, this.meets);

  String id;
  String title;
  String meets;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
import 'package:json_annotation/json_annotation.dart';
import 'package:lena_frontend/course.dart';

part 'courseList.g.dart';


/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
class CourseList {
  CourseList(this.title, this.courses);

  String title;
  List<Course> courses;

  factory CourseList.fromJson(Map<String, dynamic> json) => _$CourseListFromJson(json);

  Map<String, dynamic> toJson() => _$CourseListToJson(this);
}
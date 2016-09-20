@testable import Strategy
import XCTest

class StrategyTests: XCTestCase {
  var students = [Student]()
  
  override func setUp() {
    let george = Student(
      firstName: "George",
      lastName: "Costanza",
      grades: [Assignment(score: 35), Assignment(score: 55), Assignment(score: 70)]
    )
    let homer = Student(
      firstName: "Homer",
      lastName: "Simpson",
      grades: [Assignment(score: 10), Assignment(score: 33), Assignment(score: 18)]
    )
    let zapp = Student(
      firstName: "Zapp",
      lastName: "Brannigan",
      grades: [Assignment(score: 60), Assignment(score: 100), Assignment(score: 30)]
    )
    students.append(george)
    students.append(homer)
    students.append(zapp)
  }

  func testItCanSwapSortingTypes() {
    let insertionSorter = InsertionSorter<Student>(comparison: Classroom.highestGradeSort())
    var classroom = Classroom(students: students, sorter: insertionSorter)
    classroom.sortIt()
    XCTAssertEqual(classroom.students.map({ $0.firstName }), ["Zapp", "George", "Homer"])

    classroom.sorter.comparison = Classroom.firstNameSort()
    classroom.sortIt()
    XCTAssertEqual(classroom.students.map({ $0.firstName }), ["George", "Homer", "Zapp"])
  }

  func testItCanSwapSorters() {
    let bubbleSorter = BubbleSorter<Student>(comparison: Classroom.highestGradeSort())
    var classroom = Classroom(students: students, sorter: bubbleSorter)

    classroom.sortIt()
    XCTAssertEqual(classroom.students.map({ $0.firstName }), ["Zapp", "George", "Homer"])

    let quickSorter = QuickSorter<Student>(comparison: Classroom.firstNameSort())
    classroom.sorter = quickSorter
    classroom.sortIt()
    XCTAssertEqual(classroom.students.map({ $0.firstName }), ["George", "Homer", "Zapp"])
  }
}

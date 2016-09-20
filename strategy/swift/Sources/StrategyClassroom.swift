class Sorter<T> {
  var comparison: ((T, T) -> Bool)

  init(comparison: @escaping ((T, T) -> Bool)) {
    self.comparison = comparison
  }

  func sortIt(_ array: inout [T]) {}
}

class InsertionSorter<T>: Sorter<T> {
  override func sortIt(_ array: inout [T]) {
    array.insertionSort(comparison)
  }
}

class BubbleSorter<T>: Sorter<T> {
  override func sortIt(_ array: inout [T]) {
    array.bubbleSort(comparison)
  }
}

class MergeSorter<T>: Sorter<T> {
  override func sortIt(_ array: inout [T]) {
    array.mergeSort(comparison)
  }
}

class QuickSorter<T>: Sorter<T> {
  override func sortIt(_ array: inout [T]) {
    array.quickSort(comparison)
  }
}

struct Student {
  let firstName: String
  let lastName: String
  var grades: [Gradable]
}

protocol Gradable {
  var score: Int { get }
}

struct Assignment: Gradable {
  let score: Int
}

struct Classroom {
  var students: [Student]
  var sorter: Sorter<Student>
  mutating func sortIt() {
    sorter.sortIt(&students)
  }
}

extension Classroom {
  static func highestGradeSort() -> (Student, Student) -> Bool {
    let comparison: (Student, Student) -> Bool = { (a: Student, b: Student) in
      let aGrade = a.grades.reduce(0, { $0 + $1.score }) / a.grades.count
      let bGrade = b.grades.reduce(0, { $0 + $1.score }) / b.grades.count
      return aGrade > bGrade
    }
    return comparison
  }

  static func firstNameSort() -> (Student, Student) -> Bool {
    let comparison: (Student, Student) -> Bool = { (a: Student, b: Student) in
      return a.firstName < b.firstName
    }
    return comparison
  }
}

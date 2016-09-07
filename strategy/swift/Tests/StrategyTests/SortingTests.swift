@testable import Strategy
import XCTest

class SortingTests: XCTestCase {
  let testArrays = [
    [11, 14, 0, 1, 2, 5, 9, 3, 20, 100, 7],
    [1, 2, 3, 4],
    [0],
    []
  ]

  let answerArrays = [
    [0, 1, 2, 3, 5, 7, 9, 11, 14, 20, 100],
    [1, 2, 3, 4],
    [0],
    []
  ]

  func testInsertionSort() {
    for i in (0..<testArrays.count) {
      var copy = testArrays[i]
      XCTAssertEqual(copy.insertionSort(), answerArrays[i])
    }
  }

  func testMergeSort() {
    for i in (0..<testArrays.count) {
      var copy = testArrays[i]
      XCTAssertEqual(copy.mergeSort(), answerArrays[i])
    }
  }
}

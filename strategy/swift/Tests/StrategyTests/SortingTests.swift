@testable import Strategy
import XCTest

class SortingTests: XCTestCase {
  let testArrays = [
    [11, 14, 0, 3, 1, 2, 5, 9, 3, 20, 100, 7],
    [1, 2, 3, 4],
    [0],
    []
  ]

  let answerArrays = [
    [0, 1, 2, 3, 3, 5, 7, 9, 11, 14, 20, 100],
    [1, 2, 3, 4],
    [0],
    []
  ]

  func testInsertionSort() {
    for i in (0..<testArrays.count) {
      var copy = testArrays[i]
      copy.insertionSort({a, b in a < b})
      XCTAssertEqual(copy, answerArrays[i])
    }
  }

  func testInsertionSortDescending() {
    for i in (0..<testArrays.count) {
      var copy = testArrays[i]
      copy.insertionSort({a, b in a > b})
      XCTAssertEqual(copy, answerArrays[i].reversed())
    }
  }

  func testInsertionSortPerformance() {
    measure() {
      var numbers = (0...1000).map({_ in arc4random() })
      numbers.insertionSort({a, b in a < b})
    }
  }
  
  func testBubbleSort() {
    for i in (0..<testArrays.count) {
      var copy = testArrays[i]
      copy.bubbleSort({a, b in a < b})
      XCTAssertEqual(copy, answerArrays[i])
    }
  }
  
  func testBubbleSortDescending() {
    for i in (0..<testArrays.count) {
      var copy = testArrays[i]
      copy.bubbleSort({a, b in a > b})
      XCTAssertEqual(copy, answerArrays[i].reversed())
    }
  }
  
  func testBubbleSortPerformance() {
    measure() {
      var numbers = (0...1000).map({_ in arc4random() })
      numbers.bubbleSort({a, b in a < b})
    }
  }

  func testMergeSort() {
    for i in (0..<testArrays.count) {
      var copy = testArrays[i]
      copy.mergeSort({a, b in a < b })
      XCTAssertEqual(copy, answerArrays[i])
    }
  }

  func testMergeSortDescending() {
    for i in (0..<testArrays.count) {
      var copy = testArrays[i]
      copy.mergeSort({a, b in a > b})
      XCTAssertEqual(copy, answerArrays[i].reversed())
    }
  }

  func testMergeSortPerformance() {
    measure() {
      var numbers = (0...1000).map({_ in arc4random() })
      numbers.mergeSort({a, b in a < b})
    }
  }
  
  func testQuickSort() {
    for i in (0..<testArrays.count) {
      var copy = testArrays[i]
      copy.quickSort({a, b in a < b })
      XCTAssertEqual(copy, answerArrays[i])
    }
  }
  
  func testQuickSortDescending() {
    for i in (0..<testArrays.count) {
      var copy = testArrays[i]
      copy.quickSort({a, b in a > b })
      XCTAssertEqual(copy, answerArrays[i].reversed())
    }
  }
  
  func testQuickSortPerformance() {
    measure() {
      var numbers = (0...1000).map({_ in arc4random() })
      numbers.quickSort({a, b in a < b})
    }
  }
}

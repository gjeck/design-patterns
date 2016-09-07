public extension Array {
  public typealias Comparison = (Element, Element) -> Bool

  public mutating func insertionSort(_ compare: Comparison) {
    if count <= 1 { return }
    for i in (1..<count) {
      var j = i
      while j > 0 && compare(self[j], self[j - 1]) {
        swap(&self[j - 1], &self[j])
        j -= 1
      }
    }
  }

  public mutating func mergeSort(_ compare: Comparison) {
    if count <= 1 { return }
    let half = count / 2
    var left = Array(self[0..<half])
    left.mergeSort(compare)
    var right = Array(self[half..<count])
    right.mergeSort(compare)
    self = merge(left: left, right: right, compare: compare)
  }

  private func merge(left: [Element], right: [Element], compare: Comparison) -> [Element] {
    var result = [Element]()
    var leftReader = 0
    var rightReader = 0

    while leftReader < left.count && rightReader < right.count {
      if compare(left[leftReader], right[rightReader]) {
        result.append(left[leftReader])
        leftReader += 1
      } else {
        result.append(right[rightReader])
        rightReader += 1
      }
    }
    
    for i in (leftReader..<left.count) {
      result.append(left[i])
    }

    for i in (rightReader..<right.count) {
      result.append(right[i])
    }

    return result
  }
}

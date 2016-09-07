public extension Array where Element: Comparable  {
  public typealias Comparison<T> = (T, T) -> Bool

  public static func ascendingCompare(_ left: Element, _ right: Element) -> Bool {
    return left < right
  }

  public mutating func insertionSort() -> [Element] {
    if count <= 1 { return self }
    for i in (1..<count) {
      var j = i
      while j > 0 && self[j] < self[j - 1] {
        swap(&self[j - 1], &self[j])
        j -= 1
      }
    }
    return self
  }

  public mutating func mergeSort() -> [Element] {
    if count <= 1 { return self }
    let half = count / 2
    var left = Array(self[0..<half])
    var right = Array(self[half..<count])
    return merge(left: left.mergeSort(), right: right.mergeSort())
  }

  private func merge(left: [Element], right: [Element]) -> [Element] {
    var result = [Element]()
    var leftReader = 0
    var rightReader = 0

    while leftReader < left.count && rightReader < right.count {
      if right[rightReader] < left[leftReader] {
        result.append(right[rightReader])
        rightReader += 1
      } else if right[rightReader] == left[leftReader] {
        result.append(left[leftReader])
        leftReader += 1
        result.append(right[rightReader])
        rightReader += 1
      } else {
        result.append(left[leftReader])
        leftReader += 1
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

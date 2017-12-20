public extension Array {
  public typealias Comparison = (Element, Element) -> Bool

  public mutating func insertionSort(_ compare: Comparison) {
    if count <= 1 { return }
    for i in (1..<count) {
      var j = i
      while j > 0 && compare(self[j], self[j - 1]) {
        swapAt(j - 1, j)
        j -= 1
      }
    }
  }
  
  public mutating func bubbleSort(_ compare: Comparison) {
    if count <= 1 { return }
    for i in (0..<count) {
      for j in (0..<count) {
        if compare(self[i], self[j]) {
          swapAt(i, j)
        }
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
  
  public mutating func quickSort(_ compare: Comparison) {
    if count <= 1 { return }
    quickSort(compare, lo: 0, hi: count - 1)
  }
  
  private mutating func quickSort(_ compare: Comparison, lo: Int, hi: Int) {
    if lo < hi {
      let p = partition(compare, lo: lo, hi: hi)
      quickSort(compare, lo: lo, hi: p - 1)
      quickSort(compare, lo: p + 1, hi: hi)
    }
  }
  
  private mutating func partition(_ compare: Comparison, lo: Int, hi: Int) -> Int {
    let pivot = self[hi]
    var i = lo
    for j in (lo..<hi) {
      if compare(self[j], pivot) {
        if i != j {
          swapAt(i, j)
        }
        i += 1
      }
    }
    if i != hi {
      swapAt(i, hi)
    }
    return i
  }
}

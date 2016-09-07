class Student
    include Comparable

    attr_reader :first, :last
    attr_accessor :grade

    def initialize(first, last, grade)
        @first = first
        @last = last
        @grade = grade
    end

    def <=>(other)
        self.grade <=> other.grade
    end
end

class ClassRoom

    attr_reader :students
    attr_accessor :sorter

    def initialize(students, sorter)
        @students = students
        @sorter = sorter
    end

    def sort_class_grades()
        return sorter.sort_it(students)
    end
end

class InsertionSorter
    def sort_it(items)
	return items if items.length <= 1
        for i in (1...items.length)
            j = i
            while j > 0 and items[j-1] > items[j]
                items[j], items[j-1] = items[j-1], items[j]
                j -= 1
            end
        end
        return items
    end
end

class MergeSorter
    def sort_it(items)
        return items if items.length <= 1
        mid = items.length / 2
        left = sort_it(items[0..(mid-1)])
        right = sort_it(items[mid..-1])
        return merge(left, right)
    end

    def merge(a, b)
        result = []
        left = 0
        right = 0
        while left < a.length and right < b.length
            if a[left] < b[right]
                result << a[left]
                left += 1
            else
                result << b[right]
                right += 1
            end
        end
        (left...a.length).each {|i| result << a[i]}
        (right...b.length).each {|i| result << b[i]}
        return result
    end
end

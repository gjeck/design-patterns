require 'test/unit'
require_relative 'school'

class SchoolTest < Test::Unit::TestCase
    def setup
        @students = [
            Student.new('George', 'Bluth', 95),
            Student.new('Lionel', 'Hutz', 90),
            Student.new('Troy', 'McClure', 100),
            Student.new('Barry', 'Zuckerkorn', 70),
        ]
        @classroom = ClassRoom.new(@students, nil)
        @insertsorter = InsertionSorter.new()
        @mergesorter = MergeSorter.new()
        @scores_ascending = [70, 90, 95, 100]
    end

    def test_insertionsorter
        @classroom.sorter = @insertsorter
        sorted_class = @classroom.sort_class_grades()
        sorted_class.each_with_index do |student, i|
            assert_equal(@scores_ascending[i], student.grade)
        end
    end

    def test_mergesorter
        @classroom.sorter = @mergesorter
        sorted_class = @classroom.sort_class_grades()
        sorted_class.each_with_index do |student, i|
            assert_equal(@scores_ascending[i], student.grade)
        end
    end
end

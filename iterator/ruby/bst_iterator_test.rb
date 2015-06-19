require 'test/unit'
require_relative 'bst_iterator'

class BinarySearchTreeIteratorTest < Test::Unit::TestCase

    def setup
        @bst = BinarySearchTree.new
    end

    def test_add_contains
        assert_equal(false, @bst.contains?(:a))
        @bst.add(:a)
        assert_equal(true, @bst.contains?(:a))
    end

    def test_add_contains_array
        assert_equal(false, @bst.contains?(:a))
        to_add = [:e, :c, :a, :b, :d, :f]
        to_test = to_add + [:z, :fun]
        @bst.add_array(to_add)

        result = to_test.map {|v| @bst.contains?(v)}
        expected = [true, true, true, true, true, true, false, false]
        assert_equal(expected, result)
    end

    def test_delete
        @bst.add_array([:e, :a, :b, :c])
        @bst.delete(:b)
        assert_equal(false, @bst.contains?(:b))
    end

    def test_add_delete_count
        assert_equal(0, @bst.length)
        @bst.add_array([1, 2, 3, 4, 5])
        assert_equal(5, @bst.length)

        @bst.delete(3)
        assert_equal(4, @bst.length)
    end

    def test_iterator
        to_add = (0..100).to_a.shuffle
        @bst.add_array(to_add)

        expected = to_add.sort
        i = 0
        @bst.each do |v|
            assert_equal(expected[i], v)
            i += 1
        end
    end

end

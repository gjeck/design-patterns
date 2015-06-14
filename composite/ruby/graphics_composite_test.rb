require 'test/unit'
require_relative 'graphics_composite'

class GraphicCompositeTest < Test::Unit::TestCase

    def setup
        # Create a set of points forming a triangle
        @point_a = GraphicPoint.new(Point.new(0,0))
        @point_b = GraphicPoint.new(Point.new(3,9))
        @point_c = GraphicPoint.new(Point.new(12,0))
        @point_composite = GraphicComposite.new('Points', Point.new(0,0))
    end

    def test_point_composite_names
        assert_equal('Points', @point_composite.name)
        assert_equal('Point', @point_a.name)
    end

    def test_point_composite_center
        assert_equal(0, @point_composite.center.x)
        assert_equal(0, @point_composite.center.y)

        @point_composite.add_child(@point_a, @point_b, @point_c)
        assert_equal(5, @point_composite.center.x)
        assert_equal(3, @point_composite.center.y)
    end

    def test_point_composite_translate
        @point_composite.add_child(@point_a, @point_b, @point_c)
        @point_composite.translate(5, 1)
        assert_equal(10, @point_composite.center.x)
        assert_equal(4, @point_composite.center.y)
    end

    def test_point_composite_add_remove
        p_a = GraphicPoint.new(Point.new(0,0))
        p_b = GraphicPoint.new(Point.new(0,2))

        @point_composite.add_child(p_a, p_b)
        assert_equal(0, @point_composite.center.x)
        assert_equal(1, @point_composite.center.y)

        @point_composite.remove_child(p_a)
        assert_equal(0, @point_composite.center.x)
        assert_equal(2, @point_composite.center.y)
    end

end

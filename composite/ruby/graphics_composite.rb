# A short note: this highly simplified example only
# works with integer math. No floats allowed :)

# Component class 
class GraphicShape

    attr_accessor :parent, :center
    attr_reader :name

    def initialize(name, center, parent=nil)
        @name = name
        @center = center
        @parent = parent
    end

    def translate(x, y)
        center.x += x
        center.y += y
    end

end

# Composite class
class GraphicComposite < GraphicShape

    def initialize(name, center, children=[])
        super(name, center)
        @center = center
        @children = children
    end

    def translate(x, y)
        @children.each do |child|
            child.center.x += x
            child.center.y += y
        end
        @center.x += x
        @center.y += y
    end

    def add_child(*kids)
        kids.each do |kid|
            @children << kid
            kid.parent = self
        end
        @center = calc_center
    end

    def remove_child(*kids)
        kids.each do |kid|
            @children.delete(kid)
            kid.parent = nil
        end
        @center = calc_center
    end

    def calc_center
        if @children.length == 0
            return Point.new(@center.x, @center.y)
        elsif @children.length == 1
            child = @children[0]
            return Point.new(child.center.x, child.center.y)
        else
            x_sum = @center.x
            y_sum = @center.y
            @children.each do |child|
                x_sum += child.center.x
                y_sum += child.center.y
            end
            x = x_sum / @children.length
            y = y_sum / @children.length
            return Point.new(x, y)
        end
    end

end

# Leaf class
class GraphicPoint < GraphicShape

    def initialize(center, parent=nil)
        super('Point', center, parent)
    end

end

# Helper class
class Point

    attr_accessor :x, :y

    def initialize(x, y)
        @x = x
        @y = y
    end

end


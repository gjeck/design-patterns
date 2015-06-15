class Node

    attr_accessor :item, :count, :left, :right

    def initialize(item, left=nil, right=nil)
        @item = item
        @left = left
        @right = right
        @count = 1
    end

end

class BinarySearchTree

    attr_reader :length

    def initialize()
        @root = nil
        @length = 0
    end

    def add(item)
        if @root == nil
            @root = insert(@root, item)
        else
            insert(@root, item)
        end
        @length += 1
    end

    def add_array(items)
        items.each {|item| add(item)}
    end

    def delete(item)
        n = find(@root, item)
        if n
            remove(n)
            @length -= 1
        end
    end

    def contains?(item)
        return find(@root, item) ? true : false
    end

    def count(item)
        n = find(@root, item)
        return n ? n.count : 0
    end

    def min
        min = find_min(@root)
        return min == nil ? nil : min.item
    end

    def max
        max = find_max(@root)
        return max == nil ? nil : max.item
    end

    def insert(node, item)
        if node == nil
            return Node.new(item)
        elsif item == node.item
            node.count += 1
            return node
        elsif item < node.item
            if node.left
                return insert(node.left, item)
            else
                return node.left = insert(node.left, item)
            end
        else
            if node.right
                return insert(node.right, item)
            else
                return node.right = insert(node.right, item)
            end
        end
    end

    def remove(node)
        if node.left and node.right
            way = @length % 2 == 0
            swap = way ? find_min(node.right) : find_max(node.left)
            node.item = swap.item
            node.count = swap.count
            remove(swap)
        elsif node.left
        elsif node.right
            node = node.right
        else
            node = nil
        end
        return node
    end

    def find(node, item)
        if node == nil
            return nil
        elsif item == node.item
            return node
        elsif item < node.item
            find(node.left, item)
        else
            find(node.right, item)
        end
    end

    def find_parent(node, item)
        if node == nil
            return nil
        elsif node.left == item or node.right == item
            return node
        elsif item < node.item
            find_parent(node.left, item)
        else
            find_parent(node.right, item)
        end
    end

    def find_min(node)
        while node and node.left
            node = node.left
        end
        return node
    end

    def find_max(node)
        while node and node.right
            node = node.right
        end
        return node
    end

    private :insert, :remove, :find, :find_min, :find_max

end

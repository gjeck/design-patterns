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
        @root = insert(@root, item)
    end

    def add_array(items)
        items.each {|item| add(item)}
    end

    def delete(item)
        @root = remove(@root, item)
    end

    def contains?(item)
        return find(@root, item) ? true : false
    end

    def count(item)
        n = find(@root, item)
        return n ? n.count : 0
    end

    def min
        min, _ = find_min(@root)
        return min.nil? ? nil : min.item
    end

    def max
        max, _ = find_max(@root)
        return max.nil? ? nil : max.item
    end

    def insert(node, item)
        if node.nil?
            node = Node.new(item)
            @length += 1
        elsif item == node.item
            node.count += 1
        elsif item < node.item
            node.left = insert(node.left, item)
        else
            node.right = insert(node.right, item)
        end
        return node
    end

    def remove(node, item)
        found, parent = find(node, item)
        unless found.nil?
            remove_node(found, parent)
            @length -= 1
        end
        return node
    end

    def remove_node(node, parent)
        if node.left and node.right
            way = @length % 2 == 0
            swap, swp_parent = way ? find_min(node.right, node) : find_max(node.left, node)
            node.item = swap.item
            node.count = swap.count
            remove_node(swap, swp_parent)
        elsif node.left
            node.item = node.left.item
            node.count = node.left.count
            unless parent.nil?
                if parent.left == node
                    parent.left = node.left
                else
                    parent.right = node.left
                end
            end
        elsif node.right
            node.item = node.right.item
            node.count = node.right.count
            unless parent.nil?
                if parent.right == node
                    parent.right = node.right
                else
                    parent.left = node.right
                end
            end
        else
            unless parent.nil?
                if parent.left == node
                    parent.left = nil
                else
                    parent.right = nil
                end
            end
            node = nil
        end
        return node
    end

    def find(node, item, parent=nil)
        if node.nil?
            return nil
        elsif item == node.item
            return node, parent
        elsif item < node.item
            find(node.left, item, node)
        else
            find(node.right, item, node)
        end
    end

    def find_min(node, parent=nil)
        while node and node.left
            parent = node
            node = node.left
        end
        return node, parent
    end

    def find_max(node, parent=nil)
        while node and node.right
            parent = node
            node = node.right
        end
        return node, parent
    end

    private :insert, :remove, :remove_node, :find, :find_min, :find_max

end

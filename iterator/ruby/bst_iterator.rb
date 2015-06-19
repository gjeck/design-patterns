class Node
    include Comparable
    attr_accessor :item, :count, :left, :right

    def initialize(item, left=nil, right=nil)
        @item = item
        @left = left
        @right = right
        @count = 1
    end

    def <=>(other)
        @item <=> other.item
    end

end

class BinarySearchTree

    attr_reader :length

    def initialize()
        @root = nil
        @length = 0
    end

    def add(item)
        @root = insert(@root, Node.new(item))
    end

    def add_array(items)
        items.each {|item| add(item)}
    end

    def delete(item)
        @root = remove(@root, Node.new(item))
    end

    def contains?(item)
        return find(@root, Node.new(item)) ? true : false
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

    def insert(root, node)
        if root.nil?
            root = node
            @length += 1
        elsif node == root
            root.count += 1
        elsif node < root
            root.left = insert(root.left, node)
        else
            root.right = insert(root.right, node)
        end
        return root
    end

    def remove(root, node)
        found, parent = find(root, node)
        unless found.nil?
            if parent.nil?
                root = remove_node(found, parent)
            else
                remove_node(found, parent)
            end
            @length -= 1
        end
        return root
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
            node.right = node.left.right
            node.left = node.left.left
        elsif node.right
            node.item = node.right.item
            node.count = node.right.count
            node.left = node.right.left
            node.right = node.right.right
        else
            if parent
                if parent.left == node
                    parent.left = nil
                else
                    parent.right = nil
                end
            else
                node = nil
            end
        end
        return node
    end

    def find(root, node, parent=nil)
        if root.nil?
            return nil
        elsif node == root
            return root, parent
        elsif node < root
            find(root.left, node, root)
        else
            find(root.right, node, root)
        end
    end

    def find_min(root, parent=nil)
        while root and root.left
            parent = root
            root = root.left
        end
        return root, parent
    end

    def find_max(root, parent=nil)
        while root and root.right
            parent = root
            root = root.right
        end
        return root, parent
    end

    private :insert, :remove, :remove_node, :find, :find_min, :find_max

end

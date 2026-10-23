class Node
    attr_accessor :data, :left, :right

    def initialize (data)
        @data = data
        @left = nil
        @right = nil
    end
end

class Tree
    attr_accessor :root

    def initialize(array)
        @root = build_tree(array)
    end

    def include?(value, node = @root)
        return false if node.nil?
        return true if node.data == value

        if value < node.data
            include?(value, node.left)
        else
            include?(value, node.right)
        end
    end

    def insert(value)
        @root = insert_rec(@root, value)
    end

    def pretty_print(node = @root, prefix = '', left: true)
        return unless node

        pretty_print(node.right, "#{prefix}#{left ? '│   ' : '    '}", left: false)
        puts "#{prefix}#{left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{left ? '    ' : '│   '}", left: true)
    end

    def delete(value)
        @root = delete_rec(@root, value)
    end

    def level_order
        return enum_for(:level_order) unless block_given?
        return self if @root.nil?

        queue = [@root]

        until queue.empty?
            current = queue.shift
            yield current.data

            queue << current.left if current.left
            queue << current.right if current.right
        end

        self
    end

    def level_order_rec
        return enum_for(:level_order_rec) unless block_given?
        return self if @root.nil?

        height = tree_height(@root)
        (1..height).each do |level|
            traverse_level(@root, level) { |val| yield val }
        end

        self
    end

    def inorder(&block)
        return enum_for(:inorder) unless block_given?
        inorder_rec(@root, &block)
        self
    end

    def preorder(&block)
        return enum_for(:preorder) unless block_given?
        preorder_rec(@root, &block)
        self
    end

    def postorder(&block)
        return enum_for(:postorder) unless block_given?
        postorder_rec(@root, &block)
        self
    end

    def height(value)
        node = find_node(@root, value)
        return nil if node.nil?
        compute_height(node)
    end

    def depth(value)
        compute_depth(@root, value, 0)
    end

    def balanced?
        balanced_rec(@root).first
    end

    def rebalance
        sorted_values = inorder.to_a
        @root = build_tree(sorted_values)
        self
    end

    private 

    def build_tree(array)
        sorted_array = array.uniq.sort

        build(sorted_array, 0, sorted_array.length - 1)
    end
        
    def build(array, start_idx, end_idx)
        return nil if start_idx > end_idx

        mid = (start_idx + end_idx) / 2

        node = Node.new(array[mid])

        node.left = build(array, start_idx, mid - 1)
        node.right = build(array, mid + 1, end_idx)

        node
    end

    def insert_rec(node, value)
        return Node.new(value) if node.nil?

        return node if node.data == value

        if value < node.data
            node.left = insert_rec(node.left, value)
        else
            node.right = insert_rec(node.right, value)
        end

        node
    end

    def delete_rec(node, value)
        return nil if node.nil?

        if value < node.data
            node.left = delete_rec(node.left, value)
        elsif value > node.data
            node.right = delete_rec(node.right, value)
        else
            return nil if node.left.nil? && node.right.nil?
            return node.right if node.left.nil?
            return node.left if node.right.nil?

            successor_value = min_value(node.right)
            node.data = successor_value
            node.right = delete_rec(node.right, successor_value)
        end
        
        node
    end

    def min_value(node)
        current = node
        current = current.left until current.left.nil?
        current.data
    end

    def tree_height(node)
        return 0 if node.nil?
        1 + [tree_height(node.left), tree_height(node.right)].max
    end

    def traverse_level(node, level, &block)
        return if node.nil?
        if level == 1
            yield node.data
        elsif level > 1
            traverse_level(node.left, level - 1, &block)
            traverse_level(node.right, level - 1, &block)
        end
    end

    def inorder_rec(node, &block)
        return if node.nil?
        inorder_rec(node.left, &block)
        yield node.data
        inorder_rec(node.right, &block)
    end

    def preorder_rec(node, &block)
        return if node.nil?
        yield node.data
        preorder_rec(node.left, &block)
        preorder_rec(node.right, &block)
    end

    def postorder_rec(node, &block)
        return if node.nil?
        postorder_rec(node.left, &block)
        postorder_rec(node.right, &block)
        yield node.data
    end

    def find_node(node, value)
        return nil if node.nil?
        return node if node.data == value
        if value < node.data
            find_node(node.left, value)
        else
            find_node(node.right, value)
        end
    end

    def compute_height(node)
        return -1 if node.nil?

        left_height = compute_height(node.left)
        right_height = compute_height(node.right)

        1 + [left_height, right_height].max
    end

    def compute_depth(node, value, current_depth)
        return nil if node.nil?
        return current_depth if node.data == value
        if value < node.data
            compute_depth(node.left, value, current_depth + 1)
        else
            compute_depth(node.right, value, current_depth + 1)
        end
    end

    def balanced_rec(node)
        return [true, 0] if node.nil?

        left_balanced, left_height = balanced_rec(node.left)
        right_balanced, right_height = balanced_rec(node.right)

        is_balanced = left_balanced && right_balanced && (left_height - right_height).abs <= 1

        height = 1 + [left_height, right_height].max
        [is_balanced, height]
    end
end
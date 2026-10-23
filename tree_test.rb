require_relative 'binary_search_tree'

tree = Tree.new(Array.new(15) { rand(1..100) })

puts "=== INITIAL TREE ==="
tree.pretty_print

puts "\nIs the tree balanced? #{tree.balanced?}"
puts "-" * 40

print "Level order: "
tree.level_order { |val| print "#{val} " }
puts

print "Preorder:    "
tree.preorder { |val| print "#{val} " }
puts

print "Postorder:   "
tree.postorder { |val| print "#{val} " }
puts

print "Inorder:     "
tree.inorder { |val| print "#{val} " }
puts
puts "=" * 40

[105, 120, 150, 200, 300, 400].each { |num| tree.insert(num) }

puts "\n=== UNBALANCED TREE ==="
tree.pretty_print

puts "\nIs the tree balanced now? #{tree.balanced?}"
puts "-" * 40

tree.rebalance

puts "\n=== TREE AFTER REBALANCING ==="
tree.pretty_print
puts "\nIs the tree balanced after the rebalancing? #{tree.balanced?}"
puts "-" * 40

print "Level order: "
tree.level_order { |val| print "#{val} " }
puts

print "Preorder:    "
tree.preorder { |val| print "#{val} " }
puts

print "Postorder:   "
tree.postorder { |val| print "#{val} " }
puts

print "Inorder:     "
tree.inorder { |val| print "#{val} " }
puts
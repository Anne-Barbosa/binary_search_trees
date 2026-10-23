# Binary Search Trees (BST) in Ruby

This project is part of the **Ruby Programming** curriculum from **The Odin Project**. The goal was to build a balanced Binary Search Tree from scratch using Ruby, complete with node manipulation, depth-first and breadth-first search algorithms, and balancing utilities.

## Features

The project consists of two main classes:

- **`Node`**: Represents an individual node in the tree containing data, a left child pointer, and a right child pointer.
- **`Tree`**: Manages the binary search tree structure with the following methods:
  - `#build_tree`: Takes an array, removes duplicates, sorts it, and builds a balanced BST.
  - `#insert(value)`: Inserts a new value while preserving the BST property.
  - `#delete(value)`: Removes a value handling all three child cases (leaf, one child, two children).
  - `#include?(value)`: Checks if a value exists in the tree.
  - `#level_order`: Breadth-first traversal (supports both iteration and recursion).
  - `#inorder`, `#preorder`, `#postorder`: Depth-first traversals yielding to a block or returning an Enumerator.
  - `#height(value)`: Returns the height of the node containing the given value.
  - `#depth(value)`: Returns the depth of the node containing the given value.
  - `#balanced?`: Checks if the tree is balanced across all nodes.
  - `#rebalance`: Rebalances an unbalanced tree using an inorder traversal array.
  - `#pretty_print`: Visualizes the tree structure directly in the terminal.

## Getting Started

### Prerequisites

Make sure you have Ruby installed on your system.

### Running the Driver Script

1. Clone this repository or copy the files.
2. Run the driver script to see the tree operations in action:
   ```bash
   ruby script.rb
   ```

## Built With

- Ruby (Object-Oriented Programming, Recursion, Blocks, Enumerables)



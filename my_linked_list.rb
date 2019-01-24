class Node
  attr_accessor :value, :next_node

  def initialize(val)
    @value = val
    @next_node = nil
  end
end

class LinkedList
  attr_reader :head, :tail

  def initialize(val)
    @head = Node.new(val)
    @tail = @head
  end

  def add_to_empty?(node)
    return false unless @head.nil?
    @head = node
    @tail = node
    true
  end

  def append(val_for_node)
    node = Node.new(val_for_node)
    return if add_to_empty?(node)
    @tail.next_node = node
    @tail = node
  end

  def prepend(val_for_node)
    old_head = @head
    @head = Node.new(val_for_node)
    @head.next_node = old_head
  end

  def size
    return 0 if @head.nil?
    count = 1
    node = @head
    until list_end?(node)
      count += 1
      node = node.next_node
    end
    count
  end

  def at(idx)
    return nil unless idx.between?(0, size - 1)
    count = 0
    node = @head
    until count == idx
      node = node.next_node
      count += 1
    end
    node
  end

  def empty_list?
    return false if size > 1
    @head = nil
    @tail = nil
    true
  end

  def pop
    old_tail = @tail
    return old_tail if empty_list?
    new_tail = at(size - 2)
    @tail = new_tail
    @tail.next_node = nil
    old_tail
  end

  def shift
    old_head = @head
    @head = at(1)
    old_head
  end

  def contains?(val)
    return false if @head.nil?
    node = @head
    until list_end?(node)
      return true if node.value == val
      node = node.next_node
    end
    false
  end

  def find_idx(val)
    return nil if @head.nil?
    count = 0
    length = size

    while count < length
      node = at(count)
      return count if node.value == val
      count += 1
    end
    nil
  end

  def list_end?(node)
    node == @tail
  end

  def node_to_s(node)
    "#{node.value} -> "
  end

  def insert_at(idx, val_for_node)
    return nil unless idx.between?(0, size)
    if [0, size].include?(idx)
      idx.zero? ? prepend(val_for_node) : append(val_for_node)
      return
    end

    prev_node = at(idx - 1)
    old_node = at(idx)
    new_node = Node.new(val_for_node)
    new_node.next_node = old_node
    prev_node.next_node = new_node
  end

  def remove_at(idx)
    return nil unless idx.between?(0, size - 1)
    if [0, size - 1].include?(idx)
      idx.zero? ? shift : pop
      return
    end
    prev_node = at(idx - 1)
    prev_node.next_node = at(idx).next_node
  end

  def reverse_list
    return self if @head.nil? || @tail.nil?
    node = @tail
    revd_list = LinkedList.new(node.value)
    count = 2
    length = size
    while count <= length
      node = at(length - count)
      revd_list.append(node.value)
      count += 1
    end
    revd_list
  end

  def print_nodes
    if @head.nil?
      puts 'nil'
      return
    end
    node = @head
    str = node_to_s(node)
    until list_end?(node)
      node = node.next_node
      str += node_to_s(node)
    end
    puts str + 'nil'
  end

  private :add_to_empty?, :list_end?, :node_to_s, :empty_list?
end

if $PROGRAM_NAME == __FILE__
  my_list = LinkedList.new(0)
  # p my_list.pop
  my_list.print_nodes
  # my_list.append(0)
  my_list.append(1)
  my_list.print_nodes
  # my_list.pop
  # my_list.print_nodes
  # my_list.append(1)
  # my_list.append(2)
  # my_list.append(3)
  # my_list.pop
  # my_list.print_nodes
  # my_list.print_nodes
  # my_list.shift
  # my_list.append(1)
  # my_list.append(2)
  # my_list.append(3)
  # my_list.append(4)
  # my_list.append(5)
  # my_list.append(6)
  # my_list.append(7)
  # my_list.print_nodes
  # revd = my_list.reverse_list
  # revd.print_nodes
  # my_list.append(1)
  # my_list.append(2)
  # my_list.append(3)
  # my_list.print_nodes
  # my_list.remove_at(2)
  # my_list.print_nodes
  # my_list.prepend(-1)
  # my_list.prepend(-2)
  # my_list.print_nodes
  # p my_list.insert_at(8, 'dog')
  # my_list.insert_at(0, -3)
  # my_list.insert_at(2, 'cat')
  # my_list.print_nodes
  # p my_list.size
  # p my_list.at(4)
  # p my_list.pop
  # my_list.print_nodes
  # p my_list.contains?(-2)
  # p my_list.contains?(5)
  # p my_list.find_idx(2)
  # p my_list.find_idx(-2)
  # p my_list.find_idx(3)
  # p my_list.find_idx(5)
end

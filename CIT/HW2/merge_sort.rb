=begin
Class creates an array filled with random integers.
Provides a method to sort the array with merge sort.
=end
class MergeSort
  attr_accessor :size, :data

  def initialize(size)
    # size of array
    @size = size
    # create array of given size and fill with random integers
    @data = Array.new(@size) {rand(1..100)}
  end

  # calls recursive split method to begin merge sorting
  def sort
    # split entire array
    sort_array(0, @size - 1)
  end

  # splits array, sorts subarrays and merges subarrays into sorted array
  private def sort_array(low, high)
    # test base case; size of array equals 1
    if high - low >= 1 # if not base case
      middle1 = (low + high) / 2 # calculate middle of array
      middle2 = middle1 + 1 # calculate next element over

      # output split step
      puts "split:   #{subarray(low, high)}"
      puts "         #{subarray(low, middle1)}"
      puts "         #{subarray(middle2, high)}"

      # split array in half; sort each half (recursive calls)
      sort_array(low, middle1) # first half of array
      sort_array(middle2, high) # second half of array

      # merge two sorted arrays after split calls return
      merge(low, middle1, middle2, high)
    end
  end

  # merge two sorted subarrays into one sorted subarray
  private def merge(left, middle1, middle2, right)
    left_index = left # index into left subarray
    right_index = middle2 # index into right subarray
    combined_index = left # index into temporary working array
    combined = Array.new(@size) # working array

    # output two subarrays before merging
    puts "merge:   #{subarray(left, middle1)}"
    puts "         #{subarray(middle2, right)}"

    # merge arrays until reaching end of either
    while (left_index <= middle1) and (right_index <= right)
      # place smaller of two current elements into result
      # and move to next space in arrays
      if @data[left_index] < @data[right_index]
        combined[combined_index] = @data[left_index]
        left_index += 1
      else
        combined[combined_index] = @data[right_index]
        right_index += 1
      end
      combined_index += 1
    end

    # if left array is empty
    if left_index == middle2
    # copy in rest of right array
      while right_index <= right
        combined[combined_index] = @data[right_index]
        right_index += 1
        combined_index += 1
      end
    else
    # right array is empty
      # copy in rest of left array
      while left_index <= middle1
        combined[combined_index] = @data[left_index]
        left_index += 1
        combined_index += 1
      end
    end

    # copy values back into original array
    (left..right).each do |i|
      @data[i] = combined[i]
    end

    # output merged array
    puts "         #{subarray(left, right)}"
  end # end method merge

  # method to output certain values in array
  private def subarray(low, high)
    output = ""
    # output spaces for alignment
    (0..low - 1).each {output << "   "}

    # output elements left in array
    (low..high).each {|i| output << " #{@data[i]}"}
    return output
  end # end method subarray

  # method to output the object in string format
  def to_s
    subarray(0, @size - 1)
  end # end method toString
end # end class MergeSort

# create object to perform merge sort
sort_test = MergeSort.new(10)
# print unsorted array
puts "Unsorted:#{sort_test}"
# sort array
sort_test.sort
# print sorted array
puts "Sorted:  #{sort_test}"


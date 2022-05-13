# Uriel Aguilar
# Alvaro Garcia
# Activity: Functional programming 2

defmodule Sorts do


    @doc """
        Insert n in a list
    """
    def insert(list, n), do: do_insert(list, n, [], false)

    # List has been emptied
    defp do_insert([], _n, new_list, inserted) when inserted == true,
        do: Enum.reverse(new_list)

    # Insert n at the last
    defp do_insert([], n, new_list, inserted) when inserted == false,
        do: do_insert([], n, [n | new_list], true) 

    # Insert n
    defp do_insert([head | tail], n, new_list, inserted) when head > n and inserted == false,
        do: do_insert([head | tail], n, [n | new_list], true)

    # Doesn't insert n
    defp do_insert([head | tail], n, new_list, inserted) when inserted == false,
        do: do_insert(tail, n, [head | new_list], false)
        
    # n alrready inserted
    defp do_insert([head | tail], n, new_list, inserted) when inserted == true,
        do: do_insert(tail, n, [head | new_list], true)




    @doc """ 
    Insertion sort 
    """
    def insertion_sort(list), do: do_sort(list, [])
    
    # All elements sorted
    defp do_sort([], new_list), do: new_list

    # Sort
    defp do_sort([head | tail], new_list), 
        do: do_sort(tail, insert(new_list, head))




    @doc """
    Function that rotates list n times
    """
    def rotate_left(list, n) do
        cond do
        #n is positive or zero case
        n >= 0 ->
        cond do
            #if conditions are met, return list
            n == length(list) || n == 0 || length(list) == 0 ->
            list
            #if n is smaller than the list's length, slice list and sort
            n < length(list) ->
            #_a is for avoiding warning
            _a = Enum.slice(list, n..length(list)-1) ++ Enum.slice(list, 0..n-1)
            #if n is bigger than the list's length, obtain the remainder, slice list and sort
            n > length(list) ->
            #_a is for avoiding warning
            _a = Enum.slice(list, (rem(n, length(list)))..length(list)-1) ++ Enum.slice(list, 0..(rem(n, length(list)))-1)
        end
        #n is negative or zero case
        n<0 ->

            cond do
            #if conditions are met, return list
            (n* -1) == length(list) || length(list) == 0 ->
                list
            #if n is smaller than the list's length, slice list and sort. Sort in the other direction
            (n* -1) < length(list) ->
                #_a is for avoiding warning
                _a =  Enum.slice(list, n..length(list)-1) ++ Enum.slice(list, 0..n-1)
            #if n is bigger than the list's length, obtain the remainder, slice list and sort. Sort in the other direction
            (n* -1) > length(list) ->
            #_a is for avoiding warning
            _a =  Enum.slice(list, (rem((n), length(list))), length(list)-1) ++ Enum.slice(list, 0..(rem((n), length(list)))-1)

            end
        end
    end


    

    @doc """
    Encode function adapted from  class exercise
    """
    def encode(list), do: do_encode(list, [], [])
    defp do_encode([], _temp, result),
        do: Enum.reverse(result)
    # The list has only one element
    defp do_encode([head | []], temp, result), 
        #The size of the temporary list plus one and the value are inserted to result 
        do: do_encode([], [], [{(length(temp)+1), head } | result])
    # The first two elements are equal
    defp do_encode([head, head | tail], temp, result),
        do: do_encode([head | tail], [head | temp], result)
    # The first two elements are different
    defp do_encode([head | tail], temp, result),
      #The size of the temporary list plus one and the value are inserted to result 
        do: do_encode(tail, [], [{(length(temp)+1), head } | result])
 

end
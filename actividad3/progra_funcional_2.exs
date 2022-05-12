# Uriel Aguilar
# Alvaro Garcia
# Actividad: Programación funcional parte 2

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

 

end
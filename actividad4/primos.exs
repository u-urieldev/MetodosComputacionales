# Uriel Aguilar, Alvaro Garcia
# Program for calculate the sum of prime numbers

defmodule Hw.Primes do
    @doc """
        Return true if the given number is prime
    """
    def is_prime(n), do: do_is_prime(n, 2)
    defp do_is_prime(n, i) when n < 2 or (rem(n, i) == 0 and n != 2), do: false
    defp do_is_prime(n, i) do
        if i > :math.sqrt(n) do
            true
        else
            do_is_prime(n, i+1)
        end
    end
       

    @doc """
        Return the sum of prime numbers from 1 to n
    """
    def sum_primes(n), do: do_sum_primes(n, 1, 0)
    defp do_sum_primes(n, i, acc) when i > n, do: acc
    defp do_sum_primes(n, i, acc) do
        if is_prime(i) do
            do_sum_primes(n, i+1, acc+i)
        else    
            do_sum_primes(n, i+1, acc)
        end
    end


    @doc """
        Return the sum of prime numbers from 1 to n using parall
    """
    def sum_primes_parall(n, threads \\ System.schedulers), do:
        sum_primes_parall(n - rem(n,threads), threads, do_sum_primes(n, n-rem(n,threads), 0))

    defp sum_primes_parall(n, threads, actual_acc) when rem(n, threads) == 0 do
        range = div(n, threads)
        
        1..threads
        |> Enum.map(&Task.async(fn -> do_sum_primes(&1 * range, 1+(&1-1)*range , 0) end))
        |> Enum.map(&Task.await(&1, :infinity))
        |> Enum.sum()
        |> Kernel.+(actual_acc)
    end
    
    
end

defmodule Measure do
    @doc """  
    Time elixir function 
    https://stackoverflow.com/questions/29668635/how-can-we-easily-time-function-calls-in-elixir
    """
    def timer(function) do
            function
            |> :timer.tc
            |> elem(0)
            |> Kernel./(1_000_000)
    end
end


IO.puts "Sum Primes 10000"
IO.puts Measure.timer(fn -> Hw.Primes.sum_primes(10000) end)
IO.puts "Sum Primes Parallel 10000"
IO.puts Measure.timer(fn -> Hw.Primes.sum_primes_parall(10000) end)

IO.puts("")

IO.puts "Sum Primes 5000000"
IO.puts Measure.timer(fn -> Hw.Primes.sum_primes(5000000) end)
IO.puts "Sum Primes Parallel 5000000"
IO.puts Measure.timer(fn -> Hw.Primes.sum_primes_parall(5000000) end)




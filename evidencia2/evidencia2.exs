# Alvaro
# Uriel A01781698
# Actividad Integradora 5.2: Parall Syntax Highlighter.

#elixir evidencia2.exs to test the program



defmodule Parce do
    @doc """
      Parce a JSON file given and create and 
      html file whit token hightlight syntaxis.
    """
    def json(in_filename, out_filename) do
      new_text = 
        in_filename
        |> File.read!()
        # Match keys
        |> tag_replace(~r/"(\s*[^" [])*"(?=\s*:)|(?!)/,
         "<span class='object-key'>\\g{0}</span>") 
        # Match strings
        |> tag_replace(~r/"(\s*[^" [>])*"(?!<)|(?!)/,
         "<span class='string'>\\g{0}</span>") 
        # Match numbers
        |> tag_replace(~r/-?\d+\.?\d*([eE]?[-\+]?\d+)?(?!.*")/,
         "<span class='number'>\\g{0}</span>") 
        # Match reserved words
        |> tag_replace(~r/(true|false|null)(?!.*")/, 
        "<span class='reserved-word'>\\g{0}</span>")  
        # Match puntuation
        |> tag_replace(~r/(:|,|\[|\]|\{|\})(?![^<]*>|[^<>]*<\/)/, 
        "<span class='puntuation'>\\g{0}</span>") 
      
      createFile(out_filename, new_text)
    end

    defp tag_replace(file, regExp, tag), do: 
      Regex.replace(regExp, file, tag)

    defp createFile(out_file, body), do:
      File.write(out_file, 
        File.read!("sheme/header.html") <> body <> File.read!("sheme/footer.html"))
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


defmodule Main do


@doc """  
      Parce multiple files concurrently
      """
  def multi_json_parall do
      
      tasks = [
    Task.async(fn -> Parce.json("Test_files2/1.json", "Out_files/new1.html") end),
    Task.async(fn -> Parce.json("Test_files2/2.json", "Out_files/new2.html") end),
    Task.async(fn -> Parce.json("Test_files2/3.json", "Out_files/new3.html") end),
    Task.async(fn -> Parce.json("Test_files2/4.json", "Out_files/new4.html") end),
    Task.async(fn -> Parce.json("Test_files2/5.json", "Out_files/new5.html") end),
    Task.async(fn -> Parce.json("Test_files2/6.json", "Out_files/new6.html") end),
    Task.async(fn -> Parce.json("Test_files2/7.json", "Out_files/new7.html") end),
    Task.async(fn -> Parce.json("Test_files2/8.json", "Out_files/new8.html") end),
    Task.async(fn -> Parce.json("Test_files2/9.json", "Out_files/new9.html") end),
    Task.async(fn -> Parce.json("Test_files2/10.json", "Out_files/new10.html") end),
    Task.async(fn -> Parce.json("Test_files2/11.json", "Out_files/new11.html") end)
    ]

    Task.await_many(tasks, :infinity)
      
    end

@doc """  
      Parce multiple files sequentially
      """
def multi_json do
    
  Parce.json("Test_files2/1.json", "Out_files/new1.html")
  Parce.json("Test_files2/2.json", "Out_files/new2.html")
  Parce.json("Test_files2/3.json", "Out_files/new3.html")
  Parce.json("Test_files2/4.json", "Out_files/new4.html")
  Parce.json("Test_files2/5.json", "Out_files/new5.html")
  Parce.json("Test_files2/6.json", "Out_files/new6.html")
  Parce.json("Test_files2/7.json", "Out_files/new7.html")
  Parce.json("Test_files2/8.json", "Out_files/new8.html")
  Parce.json("Test_files2/9.json", "Out_files/new9.html")
  Parce.json("Test_files2/10.json", "Out_files/new10.html")
  Parce.json("Test_files2/11.json", "Out_files/new11.html")
 

    
  end


end



#Measure sequential time
IO.puts "Multi_json"
IO.puts Measure.timer(fn -> Main.multi_json() end)

IO.puts("")

#Measure parallel time
IO.puts "Multi_json_parall"
IO.puts Measure.timer(fn -> Main.multi_json_parall() end)
exit(:shutdown)






# Alvaro
# Uriel A01781698
# Actividad Integradora 5.2: Parall Syntax Highlighter.

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


    @doc """
      Parce multiple json files in secuencial.
      Funcion recive a list with input files 
      and their corresponding output file.  
      Or a list of tuples in form of pairs {input_file, out_putfile}.
    """
    def multi_json(files), do: 
      Enum.map(files, fn par -> json(elem(par,0), elem(par,1)) end )

    def multi_json(infiles, outfiles), do:
      List.zip([infiles, outfiles])
      |> Enum.map(fn par -> json(elem(par,0), elem(par,1)) end )


    @doc """
      Parce multiple json files in parall.
      Funcion recive a list with input files 
      and their corresponding output file.  
      Or a list of tuples in form of pairs {input_file, out_putfile}.
    """
    def multi_json_parall(infiles, outfiles) do
      List.zip([infiles, outfiles])
      |> Enum.map(&Task.start(fn -> json(elem(&1, 0), elem(&1, 1)) end ))
    end

    def multi_json_parall(files) do
      files
      |> Enum.map(&Task.start(fn -> json(elem(&1, 0), elem(&1, 1)) end ))
    end

end


#Parce.json("Test_files/example_1.json", "new.html")

# infile = ["Test_files/example_0.json", "Test_files/example_1.json", "Test_files/example_2.json"]
# outfile = ["Out_files/new0.html", "Out_files/new1.html","Out_files/new2.html"]
# files = [{"Test_files/example_0.json", "Out_files/new0.html"},
#          {"Test_files/example_1.json", "Out_files/new1.html"},
#          {"Test_files/example_2.json", "Out_files/new2.html"}]

# Parce.multi_json(infile, outfile)
# Parce.multi_json(files)

#Parce.multi_json_parall(infile, outfile)
#Parce.multi_json_parall(files)
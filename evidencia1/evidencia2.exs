# Alvaro
# Uriel A01781698
# Actividad Integradora 3.4: Syntax highlighter.

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
        File.read!("header.html") <> body <> File.read!("footer.html"))
    
end

Parce.json("Test_files/example_2.json", "new.html")
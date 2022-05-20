# Alvaro
# Uriel

defmodule Evidencia do
    
    @doc """
      Parce a JSON file given and create and html file whit
      token hightlight syntaxis.
    """
    def parceJSON(in_filename, out_filename) do
      temp1 = File.read!(in_filename)
      # Match keys
      keys1 = Regex.replace(~r/"(\s*[^" [])*"(?=\s*:)|(?!)/,temp1, "<span class='object-key'>\\g{0}</span>") 
      # Match puntuation
      # keys2 = Regex.replace(~r/\{|\}|:|\[|\]|,(?!.*")/,keys1, "<span class='puntuation'>\\g{0}</span>")
      # # Match Numbers
      # keys3 = Regex.replace(~r/-?\d+\.?\d*([eE]?[-\+]?\d+)?(?!.*")/,keys2, "<span class='number'>\\g{0}</span>")
      # # Match Booleans
      # keys4 = Regex.replace(~r/(true|false)(?!.*")/,keys3, "<span class='bool'>\\g{0}</span>")
      # # Match Null
      # keys5 = Regex.replace(~r/null(?!.*")/,keys4, "<span class='null'>\\g{0}</span>")
      # # Match strings
      #keys6 = Regex.replace(~r/[^>]"(\s*[^"])*"|(?!)/,keys5, "<span class='string'>\\g{0}</span>")
      keys2 = Regex.replace(~r/"(\s*[^" [<])*"(?!<)|(?!)/, keys1, "<span class='string'>\\g{0}</span>")
      keys3 = Regex.replace(~r/-?\d+\.?\d*([eE]?[-\+]?\d+)?(?!.*")/,keys2, "<span class='number'>\\g{0}</span>")
      keys4 = Regex.replace(~r/(true|false)(?!.*")/,keys3, "<span class='bool'>\\g{0}</span>")
      keys5 = Regex.replace(~r/(:|,|\[|\]|\{|\})(?![^<]*>|[^<>]*<\/)/,keys4, "<span class='punctuation'>\\g{0}</span>")
      # (:|,|\[|\]|\{|\})(?![^<]*>|[^<>]*<\/)
      File.write(out_filename, keys5)
            
    end
end

Evidencia.parceJSON("Test_files/example_0.json", "new.html")
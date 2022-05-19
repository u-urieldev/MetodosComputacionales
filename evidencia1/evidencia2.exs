# Alvaro
# Uriel

defmodule Evidencia do
    
    @doc """
    Read a file
    """
    def space_to_dash(in_filename, out_filename) do
      temp1 = File.read!(in_filename)
      keys = Regex.replace(~r/"(\s*[^" [])*"(?=\s*:)|(?!)/,temp1, "<span class='object-key'>\\g{0}</span>")
      #para detectar strings una vez remplazaste las keys "(\s*[^" [])*"(?!<)|(?!)
      File.write(out_filename, keys)
      
      
    end
   

end

Evidencia.space_to_dash("Test_files/example_0.json", "new.txt")
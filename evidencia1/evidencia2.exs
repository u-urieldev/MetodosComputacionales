# Alvaro
# Uriel

defmodule Evidencia do
    
    @doc """
    Read a file
    """
    def space_to_dash(in_filename, out_filename) do
      temp1 = File.read!(in_filename)
      temp2 = Regex.replace(~r/(\w+)/,temp1, "<span class = \"clase\">  \\g{1}  <span>")
      File.write(out_filename, temp2)
      
      # temp2 = Regex.replace(~r/\d+/,temp1, "span\\Poison.decode(temp1))
    end
   

end

Evidencia.space_to_dash("Test_files/example_0.json", "new.txt")
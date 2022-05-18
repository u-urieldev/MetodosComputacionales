# Alvaro
# Uriel

defmodule Evidencia do
    
    @doc """
    Read a file
    """
    def space_to_dash(in_filename, out_filename) do

    #Using pipe operator to link the calls
    text =
      in_filename
      |> File.stream!()                       # Lista de strings por linea
      |> Enum.map( &String.split/1 )                          
      |> IO.inspect()
      #|> Enum.map(&(Enum.join(&1, "-")))
      #|> IO.inspect()
      #|> Enum.join("\n")
    File.write(out_filename, text)
  end


  def get_emails(in_filename, out_filename) do
    emails =
      in_filename
      |> File.stream!()
      |> Enum.map(&email_from_line/1)
      #|> IO.inspect()
      |> Enum.filter(&(&1 != nil))
      |> Enum.map(&hd/1)
      |> Enum.join("\n")
    File.write(out_filename, emails)
  end

  def email_from_line(line) do
    Regex.run(~r|\w+(?:\.\w+)*@\w+(?:\.\w+)*\.[a-z]{2,4}|, line)
  end

end

#Evidencia.space_to_dash("Test_files/example_0.json", "new.txt")
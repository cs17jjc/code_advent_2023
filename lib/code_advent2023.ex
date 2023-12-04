defmodule CodeAdvent2023 do

  #Day 1 Part 1
  def getFirstLastDigit(line) do
    digits = List.flatten(Regex.scan(~r/\d/, line))
    String.to_integer(List.first(digits,"0") <> List.last(digits,"0"))
  end
  def mapSumDigits(lines) do
    lines |> Enum.map(&CodeAdvent2023.getFirstLastDigit/1) |> Enum.sum()
  end

  #Day 1 Part 2
  def textOrDigitToDigit(tOrD) do
    if Regex.match?(~r/\d/, tOrD) do
      tOrD
    else
      Map.fetch!(%{"one"=>"1","two"=>"2","three"=>"3","four"=>"4","five"=>"5","six"=>"6","seven"=>"7","eight"=>"8","nine"=>"9"}, tOrD)
    end
  end
  def getFirstLastDigitWithText(line) do
    digit_text = ~w(one two three four five six seven eight nine \\d)
    pattern = digit_text |> Enum.map(fn word -> "(?=(#{word}))" end) |> Enum.join("|")
    textOrDigit = Regex.scan(~r/#{pattern}/, line, capture: :all) |> List.flatten() |> Enum.filter(&(&1 != ""))
    digits = textOrDigit |> Enum.map(&CodeAdvent2023.textOrDigitToDigit/1)
    String.to_integer(List.first(digits,"0") <> List.last(digits,"0"))
  end
  def mapSumDigitsWithText(lines) do
    lines |> Enum.map(&CodeAdvent2023.getFirstLastDigitWithText/1) |> Enum.sum()
  end


end

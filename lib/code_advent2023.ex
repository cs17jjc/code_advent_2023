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

  #Day 2 Part 1
  def parseRBG(rgb) do
    rgb
    |> Enum.map(fn group -> Regex.scan(~r/(\d+)(red|green|blue)/, group) |> Enum.map(fn [_, digits, color] -> {color, digits} end) end)
  end

  def maxSeenRGBInGame(gameString) do
    groups = Regex.replace(~r/\s/u, gameString <> ";0 red 0 blue 0 green", "")
    |> String.split(":")
    |> List.last()
    |> String.split(";")
    |> parseRBG
    |> List.flatten

    maxRed = Enum.filter(groups, fn {colour,_} -> colour == "red" end) |> Enum.map(fn {_,value} -> String.to_integer(value) end) |> Enum.max()
    maxGreen = Enum.filter(groups, fn {colour,_} -> colour == "green" end) |> Enum.map(fn {_,value} -> String.to_integer(value) end) |> Enum.max()
    maxBlue = Enum.filter(groups, fn {colour,_} -> colour == "blue" end) |> Enum.map(fn {_,value} -> String.to_integer(value) end) |> Enum.max()
    {maxRed, maxGreen, maxBlue}
  end

  def everyColourSmallerThan(rgb,r,g,b) do
    ans = elem(rgb,0) <= r && elem(rgb,1) <= g && elem(rgb,2) <= b
  end

end

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

  #Day 3 Part 1
  def genMap(input) do
    linesHigh = String.length(hd(String.split(input, ~r/\r?\n/)))
    shiftedWasDigit = tl(String.graphemes(String.replace(input,~r/\r?\n/,"") <> ".")) |> Enum.map(fn d -> String.match?(d, ~r/^\d$/) end)
    Enum.with_index(String.graphemes(String.replace(input,~r/\r?\n/,"")))
    |> Enum.zip(shiftedWasDigit) |> Enum.map(fn {{a,b},c} -> {a,c,b} end)
    |> Enum.filter(fn {c,_,_} -> c != "." end)
    |> Enum.map(fn {c,b,i} -> {c,b,i,rem(i,linesHigh),trunc(i/linesHigh)} end)
  end

  def reduceLocation(curr,acc) do
    if length(acc) == 0 do
      [{elem(curr,0),[{elem(curr,3),elem(curr,4)}],elem(curr,2)}]
    else
      prev = List.last(acc)
      if elem(prev,2)+1 == elem(curr,2) do
        #this is next digit in number
        new = {elem(prev,0)<>elem(curr,0),elem(prev,1)++[{elem(curr,3),elem(curr,4)}],elem(curr,2)}
        Enum.slice(acc, 0..-2) ++ [new]
      else
        acc ++ [{elem(curr,0),[{elem(curr,3),elem(curr,4)}],elem(curr,2)}]
      end
    end
  end
  def mapToNumbersAndPositions(map) do
    map
    |> Enum.filter(fn {c,_,_,_,_} -> String.match?(c, ~r/^\d$/) end)
    |> Enum.sort(fn {_, _, value1, _, _}, {_, _, value2, _, _} -> value1 <= value2 end)
    |> Enum.reduce([],&CodeAdvent2023.reduceLocation/2)
    |> Enum.map(fn {a,b,_} -> {String.to_integer(a),b} end)
  end

  def mapToPositionsTouchingSymbol(map) do
    map
    |> Enum.filter(fn {c,_,_,_,_} -> String.match?(c, ~r/[^0-9]$/) end)
    |> Enum.map(fn {_,_,_,x,y} -> [{x-1,y-1},{x+0,y-1},{x+1,y-1},{x-1,y+0},{x+1,y+0},{x-1,y+1},{x+0,y+1},{x+1,y+1}] end)
    |> List.flatten()
    |> Enum.uniq()
  end

  def allNumbersTouchingSymbol(map) do
    numbersAndPositions = mapToNumbersAndPositions(map)
    symbolPositions = mapToPositionsTouchingSymbol(map)

    numbersAndPositions
    |> Enum.filter(fn {number,positions} -> Enum.any?(positions,fn p -> Enum.member?(symbolPositions, p) end) end)
    |> Enum.map(fn {n,_} -> n end)
  end

end

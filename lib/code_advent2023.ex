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
  def getImportantChars(input) do
    shifted = ["\n"] ++ Enum.drop(String.graphemes(input),-1)
    lineLength = input |> String.split(~r/\r?\n/, parts: 2) |> hd() |> String.length()
    Enum.zip(String.graphemes(input),shifted)
    |> Enum.filter(fn {c,_} -> !String.match?(c, ~r/[\n\r]/) end)
    |> Enum.with_index |> Enum.map(fn {{a,b},c} -> {a,b,c} end)
    |> Enum.map(fn {curChar,prevChar,index} -> {curChar,prevChar,index,rem(index,lineLength),trunc(index/lineLength)} end)
    |> Enum.filter(fn {c,_,_,_,_} -> !String.match?(c, ~r/[\.]/) end)
  end

  def reduceNumbers(curr,acc) do
    if length(acc) == 0 do
      [{elem(curr,0),[{elem(curr,3),elem(curr,4)}]}]
    else
      prev = List.last(acc)
      #if prev char is digit then this digit is part of number
      if String.match?(elem(curr,1),~r/\d/) do
        new = { elem(prev,0)<>elem(curr,0), elem(prev,1) ++ [{elem(curr,3),elem(curr,4)}]}
        Enum.slice(acc, 0..-2) ++ [new]
      else
        #starting new number
        acc ++ [{elem(curr,0),[{elem(curr,3),elem(curr,4)}]}]
      end
    end
  end
  def getNumbersAndPositions(map) do
    map
    |> Enum.filter(fn {c,_,_,_,_} -> String.match?(c,~r/\d/) end)
    |> Enum.reduce([],&CodeAdvent2023.reduceNumbers/2)
    |> Enum.map(fn {n,p} -> {String.to_integer(n),p} end)
  end

  def mapToPositionsTouchingSymbol(map) do
    map
    |> Enum.filter(fn {c,_,_,_,_} -> String.match?(c, ~r/[^0-9]$/) end)
    |> Enum.map(fn {_,_,_,x,y} -> [{x-1,y-1},{x+0,y-1},{x+1,y-1},{x-1,y+0},{x+1,y+0},{x-1,y+1},{x+0,y+1},{x+1,y+1}] end)
    |> List.flatten()
    |> Enum.uniq()
  end

  def allTouchingSymbol(map) do
  numbersAndPositions = getNumbersAndPositions(map)
  positionsTouchingSymbol = mapToPositionsTouchingSymbol(map)

  numbersAndPositions
  |> Enum.filter(fn {_,positions} -> Enum.any?(positions, fn p -> Enum.member?(positionsTouchingSymbol,p)end ) end)
  |> Enum.map(fn {n,_} -> n end)
  end

end

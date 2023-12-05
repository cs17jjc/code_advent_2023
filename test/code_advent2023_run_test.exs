defmodule CodeAdvent2023Run do
  use ExUnit.Case
  doctest CodeAdvent2023

  @tag :skip
  test "day 1 part 1" do
    day1Path = File.cwd!()<>"/test/resources/day1.txt"
    IO.puts "d1p1 answer: #{String.split(File.read!(day1Path),"\n") |> CodeAdvent2023.mapSumDigits()}"
  end

  @tag :skip
  test "day 1 part 2" do
    day1Path = File.cwd!()<>"/test/resources/day1.txt"
    IO.puts "d1p2 answer: #{String.split(File.read!(day1Path),"\n") |> CodeAdvent2023.mapSumDigitsWithText()}"
  end

  @tag :skip
  test "day 2 part 1" do
    day2Path = File.cwd!()<>"/test/resources/day2.txt"
    maxRGBForGames = String.split(File.read!(day2Path),"\n") |> Enum.map(&CodeAdvent2023.maxSeenRGBInGame/1)
    answer = Enum.with_index(maxRGBForGames) |> Enum.filter(fn {rgb,_} -> CodeAdvent2023.everyColourSmallerThan(rgb,12,13,14) end) |> Enum.map(fn {_,idx} -> idx+1 end) |> Enum.sum()
    IO.puts "d2p1 answer: #{answer}"
  end

  @tag :skip
  test "day 2 part 2" do
    day2Path = File.cwd!()<>"/test/resources/day2.txt"
    maxRGBForGames = String.split(File.read!(day2Path),"\n") |> Enum.map(&CodeAdvent2023.maxSeenRGBInGame/1)
    answer = maxRGBForGames |> Enum.map(fn rgb -> elem(rgb,0)*elem(rgb,1)*elem(rgb,2) end) |> Enum.sum()
    IO.puts "d2p2 answer: #{answer}"
  end

  #@tag :skip
  test "day 3 part 1" do
    input = File.read!(File.cwd!()<>"/test/resources/day3.txt")
    IO.puts "d3p1 answer: #{Enum.sum(CodeAdvent2023.allNumbersTouchingSymbol(CodeAdvent2023.genMap(input)))}"
  end

end

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

  @tag :skip
  test "day 3 part 1" do
    day3Path = File.cwd!()<>"/test/resources/day3.txt"
    map = CodeAdvent2023.getImportantChars(File.read!(day3Path))
    answer =  CodeAdvent2023.allTouchingSymbol(map) |> Enum.sum()
    IO.puts "d3p1 answer: #{answer}"
  end

  @tag :skip
  test "day 3 part 2" do
    day3Path = File.cwd!()<>"/test/resources/day3.txt"
    map = CodeAdvent2023.getImportantChars(File.read!(day3Path))
    answer =  CodeAdvent2023.allGearsTouchingTwoNumbers(map) |> Enum.filter(fn numbersTouching -> length(numbersTouching) == 2 end) |> Enum.map(&Enum.product/1) |> Enum.sum
    IO.puts "d3p2 answer: #{answer}"
  end

  @tag :skip
  test "day 4 part 1" do
    day4Path = File.cwd!()<>"/test/resources/day4.txt"
    answer = String.split(File.read!(day4Path),~r/[\n\r]/,trim: true)
    |> Enum.map(&CodeAdvent2023.getWinsForCard/1)
    |> Enum.map(&CodeAdvent2023.getCardPoints/1)
    |> Enum.sum
    IO.puts "d4p1 answer: #{answer}"
  end

  test "day 4 part 2" do
    day4Path = File.cwd!()<>"/test/resources/day4.txt"
    answer = String.split(File.read!(day4Path),~r/[\n\r]/,trim: true)
    |> Enum.map(&CodeAdvent2023.getWinsForCard/1)
    |> CodeAdvent2023.calcCopies
    |> IO.inspect
    |> Enum.map(fn {w,c} -> CodeAdvent2023.getCardPoints(w)*c end)
    |> Enum.sum
    IO.puts "d4p2 answer: #{answer}"
  end

end

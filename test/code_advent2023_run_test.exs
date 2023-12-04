defmodule CodeAdvent2023Run do
  use ExUnit.Case
  doctest CodeAdvent2023

  @tag :skip
  test "day 1 part 1", context do
    day1Path = File.cwd!()<>"/test/resources/day1.txt"
    IO.puts "d1p1 answer: #{String.split(File.read!(day1Path),"\n") |> CodeAdvent2023.mapSumDigits()}"
  end

  #@tag :skip
  test "day 1 part 2", context do
    day1Path = File.cwd!()<>"/test/resources/day1.txt"
    IO.puts "d1p2 answer: #{String.split(File.read!(day1Path),"\n") |> CodeAdvent2023.mapSumDigitsWithText()}"
  end

end

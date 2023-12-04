defmodule CodeAdvent2023Test do
  use ExUnit.Case
  doctest CodeAdvent2023

  setup do
    day1Test = %{"1abc2" => 12, "pqr3stu8vwx" => 38, "a1b2c3d4e5f" => 15, "treb7uchet" => 77}
    day1Part1Path = "/test/resources/day1part1.txt"
    {:ok, day1Test: day1Test, day1Part1Path: day1Part1Path}
  end

  test "test get first and last digit", context do
    testFunc = fn {q,a} ->
      assert CodeAdvent2023.getFirstLastDigit(q) == a
    end
    Enum.each(context[:day1Test],testFunc)
  end

  test "test map sum digits", context do
    answer = Enum.map(context[:day1Test],fn {_,a} -> a end) |> Enum.sum()
    result = Enum.map(context[:day1Test],fn {q,_} -> q end) |> CodeAdvent2023.mapSumDigits()
    assert result == answer
  end

  test "day 1 part 1", context do
    IO.puts "d1p1 answer: #{CodeAdvent2023.day1Part1(File.cwd!()<>context[:day1Part1Path])}"
  end

end

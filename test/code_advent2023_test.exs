defmodule CodeAdvent2023Test do
  use ExUnit.Case
  doctest CodeAdvent2023

  setup do
    day1Part1Test = %{"1abc2" => 12,
    "pqr3stu8vwx" => 38,
    "a1b2c3d4e5f" => 15,
    "treb7uchet" => 77}

    day1Part2Test = %{"two1nine" => 29,
    "eightwothree" => 83,
    "abcone2threexyz" => 13,
    "xtwone3four" => 24,
    "4nineeightseven2" => 42,
    "zoneight234" => 14,
    "7pqrstsixteen" => 76}
    {:ok, day1Part1Test: day1Part1Test, day1Part2Test: day1Part2Test}
  end

  test "test get first and last digit", context do
    testFunc = fn {q,a} ->
      assert CodeAdvent2023.getFirstLastDigit(q) == a
    end
    Enum.each(context[:day1Part1Test],testFunc)
  end

  test "test map sum digits", context do
    answer = Enum.map(context[:day1Part1Test],fn {_,a} -> a end) |> Enum.sum()
    result = Enum.map(context[:day1Part1Test],fn {q,_} -> q end) |> CodeAdvent2023.mapSumDigits()
    assert result == answer
  end

  test "test text or digit to digit" do
    Enum.each(%{"one"=>"1","two"=>"2","three"=>"3","four"=>"4","five"=>"5","six"=>"6","seven"=>"7","eight"=>"8","nine"=>"9"}, fn {q,a} ->
      assert CodeAdvent2023.textOrDigitToDigit(q) == a
      assert CodeAdvent2023.textOrDigitToDigit(a) == a
    end)
  end

  test "test get first and last digit with text", context do
    testFunc = fn {q,a} ->
      assert CodeAdvent2023.getFirstLastDigitWithText(q) == a
    end
    Enum.each(context[:day1Part2Test],testFunc)
  end

  test "test map sum digits with text", context do
    answer = Enum.map(context[:day1Part2Test],fn {_,a} -> a end) |> Enum.sum()
    result = Enum.map(context[:day1Part2Test],fn {q,_} -> q end) |> CodeAdvent2023.mapSumDigitsWithText()
    assert result == answer
  end

end

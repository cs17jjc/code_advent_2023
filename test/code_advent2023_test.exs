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

    day2Part1Test = %{
      "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green" => {4,2,6},
      "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue" => {1,3,4},
      "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red" => {20, 13, 6},
      "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red" => {14,3,15},
      "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green" => {6,3,2}
    }

    day3Part1Test =
   "467..114..\n...*......\n..35..633.\n......#...\n617*......\n.....+.58.\n..592.....\n......755.\n...$.*....\n.664.598.."
    {:ok, day1Part1Test: day1Part1Test, day1Part2Test: day1Part2Test, day2Part1Test: day2Part1Test, day3Part1Test: day3Part1Test}
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

  test "test max seen RGB", context do
    testFunc = fn {q,a} ->
      assert CodeAdvent2023.maxSeenRGBInGame(q) == a
    end
    Enum.each(context[:day2Part1Test],testFunc)
  end

  test "test max all games", context do
    assert Enum.map(context[:day2Part1Test],fn {q,_} -> q end) |> Enum.map(&CodeAdvent2023.maxSeenRGBInGame/1) == Enum.map(context[:day2Part1Test],fn {_,a} -> a end)
  end

  test "test rgb smaller than" do
    assert CodeAdvent2023.everyColourSmallerThan({0,0,0},1,1,1)
    assert !CodeAdvent2023.everyColourSmallerThan({1,1,1},0,0,0)

    assert CodeAdvent2023.everyColourSmallerThan({4, 2, 6},12,13,14)
    assert CodeAdvent2023.everyColourSmallerThan({1, 3, 4},12,13,14)
    assert !CodeAdvent2023.everyColourSmallerThan({20, 13, 6},12,13,14)
    assert !CodeAdvent2023.everyColourSmallerThan({14, 3, 15},12,13,14)
    assert CodeAdvent2023.everyColourSmallerThan({6, 3, 2},12,13,14)
  end

  test "test string to map of coords and char and prevDigitIdx" do
    ans = [
      {"1", true, 0, 0, 0},
      {"2", true, 1, 1, 0},
      {"3", false, 2, 2, 0},
      {"*", false, 7, 2, 1},
      {"8", false, 10, 0, 2}
    ]
    assert CodeAdvent2023.genMap("123..\n..*..\n8....") == ans
  end
  test "test map to numbers and positions" do
    q = [
      {"1", true, 0, 0, 0},
      {"2", true, 1, 1, 0},
      {"3", false, 2, 2, 0},
      {"*", false, 7, 2, 1},
      {"8", false, 10, 0, 2}
    ]
    assert CodeAdvent2023.mapToNumbersAndPositions(q) == [{123, [{0, 0}, {1, 0}, {2, 0}]}, {8, [{0, 2}]}]
  end
  test "test reduce location" do
    assert CodeAdvent2023.reduceLocation({"1", true, 0, 0, 0},[]) == [{"1", [{0, 0}], 0}]
    assert CodeAdvent2023.reduceLocation({"2", true, 1, 1, 0},[{"1", [{0, 0}], 0}]) == [{"12", [{0, 0}, {1, 0}], 1}]
    assert CodeAdvent2023.reduceLocation({"3", true, 2, 1, 0},[{"12", [{0, 0}, {1, 0}], 1}]) == [{"123", [{0, 0}, {1, 0}, {1, 0}], 2}]
    assert CodeAdvent2023.reduceLocation({"8", true, 10, 0, 2},[{"123", [{0, 0}, {1, 0}, {1, 0}], 2}]) == [{"123", [{0, 0}, {1, 0}, {1, 0}], 2}, {"8", [{0, 2}], 10}]
  end
  test "test map to touching symbol positions", context do
    testMap = "...\n.*.\n..."
    assert CodeAdvent2023.mapToPositionsTouchingSymbol(CodeAdvent2023.genMap(testMap)) == [{0, 0}, {1, 0}, {2, 0}, {0, 1}, {2, 1}, {0, 2}, {1, 2}, {2, 2}]
    #IO.inspect CodeAdvent2023.mapToPositionsTouchingSymbol(CodeAdvent2023.genMap(context[:day3Part1Test]))
  end

  test "test all numbers touching symbol" do
    testMap = "123..\n..*..\n....."
    assert CodeAdvent2023.allNumbersTouchingSymbol(CodeAdvent2023.genMap(testMap)) == [123]
    testMap = "1....\n..*..\n....8"
    assert CodeAdvent2023.allNumbersTouchingSymbol(CodeAdvent2023.genMap(testMap)) == []
    testMap = "1...8\n..*..\n..345"
    assert CodeAdvent2023.allNumbersTouchingSymbol(CodeAdvent2023.genMap(testMap)) == [345]
    testMap = "12.48\n..*..\n..345"
    assert CodeAdvent2023.allNumbersTouchingSymbol(CodeAdvent2023.genMap(testMap)) == [12, 48, 345]
  end
  test "test day 3 test input", context do
    ans = [467,35,633,617,592,755,664,598]
    assert CodeAdvent2023.allNumbersTouchingSymbol(CodeAdvent2023.genMap(context[:day3Part1Test])) == ans
    assert Enum.sum(CodeAdvent2023.allNumbersTouchingSymbol(CodeAdvent2023.genMap(context[:day3Part1Test]))) == 4361
  end

end

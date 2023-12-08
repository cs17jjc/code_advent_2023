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

    day4Part1Test = [
    "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53",
    "Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19",
    "Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1",
    "Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83",
    "Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36",
    "Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11"]
    {:ok, day1Part1Test: day1Part1Test, day1Part2Test: day1Part2Test, day2Part1Test: day2Part1Test, day3Part1Test: day3Part1Test, day4Part1Test: day4Part1Test}
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

  test "test get important chars" do
    assert CodeAdvent2023.getImportantChars("123..\n..*..\n.....") == [{"1", "\n", 0, 0, 0}, {"2", "1", 1, 1, 0}, {"3", "2", 2, 2, 0}, {"*", ".", 7, 2, 1}]
    assert CodeAdvent2023.getImportantChars(".....\n..*..\n.....") == [{"*", ".", 7, 2, 1}]
    assert CodeAdvent2023.getImportantChars("..123\n45*..\n.....") == [{"1", ".", 2, 2, 0}, {"2", "1", 3, 3, 0}, {"3", "2", 4, 4, 0}, {"4", "\n", 5, 0, 1}, {"5", "4", 6, 1, 1}, {"*", "5", 7, 2, 1}]
    assert CodeAdvent2023.getImportantChars("*..\n.*.\n..*") == [{"*", "\n", 0, 0, 0}, {"*", ".", 4, 1, 1}, {"*", ".", 8, 2, 2}]
  end

  test "test number reduce" do
    assert CodeAdvent2023.reduceNumbers({"1","2",0,0,0},[]) == [{"1", [{0, 0}]}]
    assert CodeAdvent2023.reduceNumbers({"2","3",1,1,0},[{"1", [{0, 0}]}]) == [{"12", [{0, 0}, {1, 0}]}]
  end

  test "test get numbers" do
    assert CodeAdvent2023.getNumbersAndPositions(CodeAdvent2023.getImportantChars("..123\n45*..\n.....")) == [{123, [{2, 0}, {3, 0}, {4, 0}]}, {45, [{0, 1}, {1, 1}]}]
  end

  test "test map to touching symbol positions" do
    testMap = "...\n.*.\n..."
    assert CodeAdvent2023.mapToPositionsTouchingSymbol(CodeAdvent2023.getImportantChars(testMap)) == [{0, 0}, {1, 0}, {2, 0}, {0, 1}, {2, 1}, {0, 2}, {1, 2}, {2, 2}]
  end

  test "test day 3 test input", context do
    ans = [467,35,633,617,592,755,664,598]
    map = CodeAdvent2023.getImportantChars(context[:day3Part1Test])
    assert CodeAdvent2023.allTouchingSymbol(map) == ans
    assert Enum.sum(CodeAdvent2023.allTouchingSymbol(map)) == 4361
  end

  test "test map to gear positions" do
    testMap = "...\n.*.\n..."
    assert CodeAdvent2023.getTouchingGearPositions(CodeAdvent2023.getImportantChars(testMap)) == [[{0, 0}, {1, 0}, {2, 0}, {0, 1}, {2, 1}, {0, 2}, {1, 2}, {2, 2}]]
  end

  test "test numbers touching gears" do
    testMap = "12..\n..*.\n3..."
    assert CodeAdvent2023.allGearsTouchingTwoNumbers(CodeAdvent2023.getImportantChars(testMap)) == [[12]]
    testMap = "12..\n..*.\n..34"
    assert CodeAdvent2023.allGearsTouchingTwoNumbers(CodeAdvent2023.getImportantChars(testMap)) == [[12, 34]]
  end

  test "test day 3 part 2 test input", context do
    ans = [467,35,633,617,592,755,664,598]
    map = CodeAdvent2023.getImportantChars(context[:day3Part1Test])
    assert CodeAdvent2023.allGearsTouchingTwoNumbers(map) |> Enum.filter(fn numbersTouching -> length(numbersTouching) == 2 end) == [[467, 35], [755, 598]]
    assert CodeAdvent2023.allGearsTouchingTwoNumbers(map) |> Enum.filter(fn numbersTouching -> length(numbersTouching) == 2 end) |> Enum.map(&Enum.product/1) |> Enum.sum == 467835
  end

  test "test parse card line", context do
    context[:day4Part1Test] |> Enum.zip([8,2,2,1,0,0])
    |> Enum.each(fn {q,a} -> assert CodeAdvent2023.getCardPoints(CodeAdvent2023.getWinsForCard(q)) == a end)
  end

  test "test calc copies", context do
    IO.inspect CodeAdvent2023.calcCopies([2,1,0,0])
  end

end

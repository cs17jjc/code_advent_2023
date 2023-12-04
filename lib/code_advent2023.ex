defmodule CodeAdvent2023 do

  def getFirstLastDigit(line) do
    digits = Regex.scan(~r/\d/, line)
    String.to_integer(Enum.at(List.first(digits,[]),0,"0") <> Enum.at(List.last(digits,[]),0,"0"))
  end
  def mapSumDigits(lines) do
    lines |> Enum.map(&CodeAdvent2023.getFirstLastDigit/1) |> Enum.sum()
  end
  def day1Part1(inputPath) do
    String.split(File.read!(inputPath),"\n") |> mapSumDigits
  end
end

defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    # NOTE: My approach -- Completety 100% wrong when using Binaries
    # text |> String.to_charlist |> Enum.map(fn(item)->
    #   if item == 32 do
    #     ' '
    #   else
    #     if Integer.parse(<<item>>) == :error do
    #       <<item + shift>>
    #     else
    #       <<item>>
    #     end
    #   end
    # end) |> Enum.join

    # NOTE: Other appoarch
    text |> to_charlist |> Enum.map(fn(item)-> shift_char(item, shift) end) |> to_string
  end

  defp shift_char(char, shift) when char in ?a..?z do
    shift_char_with_base(char, shift, ?a)
  end

  defp shift_char(char, shift) when char in ?A..?Z do
    shift_char_with_base(char, shift, ?A)
  end

  defp shift_char(char, _) do
    char
  end

  defp shift_char_with_base(char, shift, base) do
    base + rem(char + shift - base, 26)
  end
end


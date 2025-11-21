defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0
      ?A -> 1
      ?C -> 2
      ?G -> 4
      ?T -> 8
      _ -> nil
    end
  end

  @spec decode_nucleotide(any()) :: nil
  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0000 -> ?\s
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
      _ -> nil
    end
  end

  def encode(dna) do
    do_encode(dna, <<>>)
  end

  defp do_encode([], acc), do: acc

  defp do_encode([head | tail], acc) do
    do_encode(tail, <<acc::bitstring, encode_nucleotide(head)::4>>)
  end

  def decode(dna), do: do_decode(dna, '')

  defp do_decode(<<>>, acc), do: acc

  defp do_decode(<<head::4, tail::bitstring>>, acc) do
    do_decode(tail, acc ++ [decode_nucleotide(head)])
  end
end

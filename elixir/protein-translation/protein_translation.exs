defmodule ProteinTranslation do
  @rna_codon %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP",
  }
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    codons = stop_rna(
      rna |> String.codepoints |> Enum.chunk(3) |> Enum.map(fn(item)->
        @rna_codon[Enum.join(item)]
      end)
    )

    if codons |> Enum.reject(fn(x)-> is_nil(x) end) |> Enum.empty? do
      {:error, "invalid RNA"}
    else
      {:ok, codons}
    end
  end

  defp stop_rna(codons) do
    stop_index = Enum.find_index(codons, fn(x)-> x == "STOP" end)
    if stop_index == nil do
      codons
    else
      Enum.slice(codons, 0, stop_index)
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    rna = @rna_codon[codon]
    if is_nil(rna) do
      {:error, "invalid codon"}
    else
      {:ok, rna}
    end

  end
end


{
  for (i = 1; i <= NF; i += 2) {
    if ($i == "GENEID")
      g = $(i+1)
    if ($i == "GENBANK")
      p = $(i+1)
  }
  map[g] = p
}
END {
  for (g in map)
    printf "%s\t%s\n", g, map[g]
}

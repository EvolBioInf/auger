/^\[/ {
  if (/\[Term\]/)
    term = 1
  else
    term = 0
}
term && /^id:/ {
  printf "%s", $2
}
term && /^name:/ {
  printf "\t%s", $2
  for (i = 3; i <= NF; i++)
    printf " %s", $i
}
term && /^namespace: / {
  printf "\t%s\n", $2
}

/^\[/ {
  if (/\[Term\]/)
    term = 1
  else
    term = 0
}
term && /^id:/ {
  printf "id"
}
term && /^name:/ {
  printf "name"
}
term && /^namespace: / {
  printf "namespace\n"
}

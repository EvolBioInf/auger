BEGIN {
  tmpl = ".\t%s\t%s\t.\t.\t%s\t.\t%s\n"
}
{
  printf tmpl, $2, $1, $3, $4
}

# check for a string match, including regex
match () {
  echo "$1" | grep -E "$2" &> /dev/null
}

# argument format is:
# --foo bar --zzz aaa
# splits argument string on `--` separator then attempts to
# find desired key and return associated value
# shellcheck disable=SC2001
arg() {
  local key=$1
  shift
  local args=$*

  local kvp=$(echo "$args" | grep -o "\--$key \S*")
  echo "${kvp:${#key}+3}" | sed 's/ *$//'
}

# print output over same line
print() {
  [ -z "$bolt_print_buffer" ] && let bolt_print_buffer=0
  local line=$*
  local let i=0
  local pad=
  while [ $i -lt $bolt_print_buffer ];
  do
    pad="${pad} "
    let i=i+1
  done
  let bolt_print_buffer=${#line}
  echo -ne "$pad\r$line\r"
}

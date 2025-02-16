echo "Making small-font..."
foo=$($(dirname "$0")/write-char-widths.sh)
echo -ne "\E[1A\E[2K"
echo -ne "Made small-font"
echo "Making icons..."
foo=$($(dirname "$0")/write-sizes.sh)
echo -ne "\E[1A\E[2K"
echo -ne "Made icons"
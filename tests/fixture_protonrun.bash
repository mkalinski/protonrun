# Ensure protonrun exec is available
if [[ ! -x ./protonrun ]]; then
	echo 'ERROR: protonrun executable must be in working directory' >&2
	exit 1
fi

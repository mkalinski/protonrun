[[ -n $BATS_TEST_FILENAME ]] || exit

declare -g protonrun_exec="${BATS_TEST_FILENAME%/*/*/*/*}/bin/protonrun"

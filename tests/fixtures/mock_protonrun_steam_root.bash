mock_protonrun_steam_root() {
	# Sanity check that bats sets this variable.
	[[ -d $BATS_TEST_TMPDIR ]]
	declare -gx PROTONRUN_STEAM_ROOT="$BATS_TEST_TMPDIR/Steam"
	mkdir -p "$PROTONRUN_STEAM_ROOT"
}

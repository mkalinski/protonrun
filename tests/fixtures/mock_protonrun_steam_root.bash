mock_protonrun_steam_root() {
	[[ -d $BATS_TEST_TMPDIR ]] || return

	declare -gx PROTONRUN_STEAM_ROOT="$BATS_TEST_TMPDIR/Steam"
	mkdir -p "$PROTONRUN_STEAM_ROOT"
}

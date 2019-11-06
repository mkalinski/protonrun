load fixture_protonrun
load fixture_mock_steam
load fixture_error_prefix

setup() {
	make_steam_root_dir
}

teardown() {
	clear_steam_root_mock
}

@test '--list fails when root is empty' {
	run ./protonrun --list
	[[ $status -eq 1 ]]
	[[ $output == $ERROR_PREFIX*'is not a directory' ]]
}

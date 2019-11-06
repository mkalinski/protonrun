load fixture_protonrun
load fixture_mock_steam

setup() {
	mock_steam_root <<-'EOF'
	EOF
}

teardown() {
	clear_steam_root_mock
}

@test '--list outputs nothing when there are no apps' {
	run ./protonrun --list
	[[ $status -eq 0 ]]
	[[ -z $output ]]
}

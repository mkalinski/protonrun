load ../../fixtures/mock_protonrun_steam_apps.bash

setup() {
	mock_protonrun_steam_apps <<-EOF
	EOF
}

@test '--list outputs nothing when there are no apps' {
	run ./protonrun --list
	[[ $status -eq 0 ]]
	[[ -z $output ]]
}

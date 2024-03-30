load ../../fixtures/protonrun_exec.bash
load ../../fixtures/mock_protonrun_steam_apps.bash

setup() {
	mock_protonrun_steam_apps <<-EOF
	EOF
}

option_list_outputs_nothing_when_there_are_no_apps() { #@test
	run "$protonrun_exec" --list
	[[ $status -eq 0 ]]
	[[ -z $output ]]
}

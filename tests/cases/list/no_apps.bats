setup() {
	load ../../bats/support/load.bash || return
	load ../../bats/assert/load.bash || return

	load ../../fixtures/protonrun_exec.bash || return
	load ../../fixtures/mock_protonrun_steam_apps.bash || return

	mock_protonrun_steam_apps <<-EOF
	EOF
}

option_list_outputs_nothing_when_there_are_no_apps() { #@test
	run "$protonrun_exec" --list

	assert_success
	refute_output
}

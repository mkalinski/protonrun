setup() {
	load ../../bats/support/load.bash || return
	load ../../bats/assert/load.bash || return

	load ../../fixtures/error_msg_prefix.bash || return
	load ../../fixtures/protonrun_exec.bash || return
	load ../../fixtures/mock_protonrun_steam_root.bash || return

	mock_protonrun_steam_root
}

option_list_fails_when_root_is_empty() { #@test
	run "$protonrun_exec" --list

	assert_failure
	assert_output -p "$error_msg_prefix"
	assert_output -p 'is not a directory'
}

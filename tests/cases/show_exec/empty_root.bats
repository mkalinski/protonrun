setup() {
	load ../../bats/support/load.bash || return
	load ../../bats/assert/load.bash || return

	load ../../fixtures/error_msg_prefix.bash || return
	load ../../fixtures/protonrun_exec.bash || return
	load ../../fixtures/mock_protonrun_steam_root.bash || return

	mock_protonrun_steam_root
}

assert_error_with_usage() {
	assert_failure 2
	assert_line -n 0 "$error_msg_prefix $*"
	assert_line -n 1 Usage:
}

exec_exits_with_error_when_no_arguments_are_given() { #@test
	run "$protonrun_exec"

	assert_error_with_usage 'An argument is required'
}

exec_exits_with_error_when_unknown_option_is_given() { #@test
	run "$protonrun_exec" -0

	assert_error_with_usage 'Unknown option: -0'
}

load ../../fixtures/error_msg_prefix.bash
load ../../fixtures/protonrun_exec.bash
load ../../fixtures/mock_protonrun_steam_root.bash

assert_error_with_usage() {
	[[ $status -eq 2 ]]
	[[ ${lines[0]} == "$error_msg_prefix $*" ]]
	[[ ${lines[1]} == Usage: ]]
}

setup() {
	mock_protonrun_steam_root
}

exec_exits_with_error_when_no_arguments_are_given() { #@test
	run "$protonrun_exec"
	assert_error_with_usage 'An argument is required'
}

exec_exits_with_error_when_unknown_option_is_given() { #@test
	run "$protonrun_exec" -0
	assert_error_with_usage 'Unknown option: -0'
}

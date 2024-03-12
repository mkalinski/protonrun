load ../../constants/error_msg_prefix.bash
load ../../constants/protonrun_exec.bash
load ../../fixtures/mock_protonrun_steam_root.bash

assert_error_with_usage() {
	[[ $status -eq 2 ]]
	[[ ${lines[0]} == "$error_msg_prefix $*" ]]
	[[ ${lines[1]} == Usage: ]]
}

setup() {
	mock_protonrun_steam_root
}

@test 'exits with error when no arguments are given' {
	run "$protonrun_exec"
	assert_error_with_usage 'An argument is required'
}

@test 'exits with error when unknown option is given' {
	run "$protonrun_exec" -0
	assert_error_with_usage 'Unknown option: -0'
}

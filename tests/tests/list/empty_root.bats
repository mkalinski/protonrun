load ../../fixtures/error_msg_prefix.bash
load ../../fixtures/protonrun_exec.bash
load ../../fixtures/mock_protonrun_steam_root.bash

setup() {
	mock_protonrun_steam_root
}

@test '--list fails when root is empty' {
	run "$protonrun_exec" --list
	[[ $status -eq 1 ]]
	[[ $output == $error_msg_prefix*'is not a directory' ]]
}

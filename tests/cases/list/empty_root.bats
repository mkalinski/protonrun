setup() {
	load ../../fixtures/error_msg_prefix.bash || return
	load ../../fixtures/protonrun_exec.bash || return
	load ../../fixtures/mock_protonrun_steam_root.bash || return

	mock_protonrun_steam_root
}

option_list_fails_when_root_is_empty() { #@test
	run "$protonrun_exec" --list
	[[ $status -eq 1 ]]
	[[ $output == $error_msg_prefix*'is not a directory' ]]
}

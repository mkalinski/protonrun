setup() {
	load ../../bats/support/load.bash || return
	load ../../bats/assert/load.bash || return

	load ../../fixtures/protonrun_exec.bash || return
	load ../../fixtures/mock_protonrun_steam_root.bash || return

	mock_protonrun_steam_root
}

option_help_prints_usage_and_does_nothing() { #@test
	run "$protonrun_exec" --help echo foo

	assert_success
	assert_line -n 0 Usage:
	refute_line -n -1 foo
}

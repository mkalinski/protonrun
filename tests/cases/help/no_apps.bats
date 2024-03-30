load ../../fixtures/protonrun_exec.bash
load ../../fixtures/mock_protonrun_steam_root.bash

setup() {
	mock_protonrun_steam_root
}

option_help_prints_usage_and_does_nothing() { #@test
	run "$protonrun_exec" --help echo foo
	[[ $status -eq 0 ]]
	[[ ${lines[0]} == Usage: ]]
	[[ ${lines[-1]} != foo ]]
}

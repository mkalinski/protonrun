load ../../constants/protonrun_exec.bash
load ../../fixtures/mock_protonrun_steam_root.bash

setup() {
	mock_protonrun_steam_root
}

@test '--help option prints usage and does nothing' {
	run "$protonrun_exec" --help echo foo
	[[ $status -eq 0 ]]
	[[ ${lines[0]} == Usage: ]]
	[[ ${lines[-1]} != foo ]]
}

load fixture_protonrun
load fixture_error_prefix

verify_usage_error() {
	[[ $status -eq 2 ]]
	[[ ${lines[0]} == "$ERROR_PREFIX $*" ]]
	[[ ${lines[1]} == Usage: ]]
}

@test 'program exits with error when no arguments' {
	run ./protonrun
	verify_usage_error 'An argument is required'
}

@test 'program exits with error when unknown option is given' {
	run ./protonrun -0
	verify_usage_error 'Unknown option: -0'
}

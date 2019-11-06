load fixture_protonrun

@test '--help option prints usage and does nothing' {
	run ./protonrun --help echo foo
	[[ $status -eq 0 ]]
	[[ ${lines[0]} == Usage: ]]
	[[ ${lines[-1]} != foo ]]
}

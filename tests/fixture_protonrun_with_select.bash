# Run protonrun with the given arguments.
# Then when prompted for selection, input the first argument.
# WARNING: all output is stored in bats variables, but with CRLF line endings!
# Args:
#   $1: string to input when prompted for selection
#   $[2..$]: arguments for protonrun
protonrun_with_select() {
	run env PS3='#? ' expect <(echo '
		set selection_input [lindex $argv 0]
		set protonrun_args [lrange $argv 1 end]

		spawn -noecho "./protonrun" $protonrun_args

		expect $::env(PS3) { send "$selection_input\r" }

		interact
	') -- "$@"
}

# Remove CR characters in input.
# May be necessary when working with protonrun_with_select
remove_cr() {
	tr -d \\r
}

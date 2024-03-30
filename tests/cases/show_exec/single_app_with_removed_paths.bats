load ../../constants/app_1.bash
load ../../fixtures/error_msg_prefix.bash
load ../../fixtures/protonrun_exec.bash
load ../../fixtures/mock_protonrun_steam_apps.bash

setup() {
	mock_protonrun_steam_apps <<-EOF
		$app_1_mock_protonrun_steam_apps_line
	EOF

	declare -gx PROTONRUN_APP_ID="$app_1_id"
}

run_fails_missing_app_dir() {
	declare -r removed="$PROTONRUN_STEAM_ROOT/steamapps/compatdata/$app_1_id"
	rm -r "$removed"

	run "$@"

	[[ $status -eq 1 ]]
	[[ $output == "$error_msg_prefix $removed is not a directory" ]]
}

run_fails_missing_version_file() {
	declare -r removed="$PROTONRUN_STEAM_ROOT/steamapps/compatdata/$app_1_id/version"
	rm "$removed"

	run "$@"

	[[ $status -eq 1 ]]
	# The first line could be a bash built-in error message.
	[[ ${lines[-1]} == "$error_msg_prefix Could not read proton version from: $removed" ]]
}

run_fails_missing_prefix_dir() {
	declare -r removed="$PROTONRUN_STEAM_ROOT/steamapps/compatdata/$app_1_id/pfx"
	rm -r "$removed"

	run "$@"

	[[ $status -eq 1 ]]
	[[ $output == "$error_msg_prefix $removed is not a directory" ]]
}

run_fails_missing_proton_dir() {
	declare -r removed="$PROTONRUN_STEAM_ROOT/steamapps/common/Proton $app_1_proton_version"
	rm -r "$removed"

	run "$@"

	[[ $status -eq 1 ]]
	[[ $output == "$error_msg_prefix $removed/dist is not a directory" ]]
}

@test 'command fails without running when app dir is missing' {
	run_fails_missing_app_dir "$protonrun_exec" echo foo
}

@test 'command fails without running when proton version file cannot be read' {
	run_fails_missing_version_file "$protonrun_exec" echo foo
}

@test 'command fails without running when app prefix is missing' {
	run_fails_missing_prefix_dir "$protonrun_exec" echo foo
}

@test 'command fails without running when proton dir is missing' {
	run_fails_missing_proton_dir "$protonrun_exec" echo foo
}

@test '--show fails if app dir is missing' {
	run_fails_missing_app_dir "$protonrun_exec" --show
}

@test '--show fails when proton version file cannot be read' {
	run_fails_missing_version_file "$protonrun_exec" --show
}

@test '--show fails when app prefix is missing' {
	run_fails_missing_prefix_dir "$protonrun_exec" --show
}

@test '--show fails when proton dir is missing' {
	run_fails_missing_proton_dir "$protonrun_exec" --show
}

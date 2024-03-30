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

exec_fails_without_running_when_app_dir_is_missing() { #@test
	run_fails_missing_app_dir "$protonrun_exec" echo foo
}

exec_fails_without_running_when_proton_version_file_cannot_be_read() { #@test
	run_fails_missing_version_file "$protonrun_exec" echo foo
}

exec_fails_without_running_when_app_prefix_is_missing() { #@test
	run_fails_missing_prefix_dir "$protonrun_exec" echo foo
}

exec_fails_without_running_when_proton_dir_is_missing() { #@test
	run_fails_missing_proton_dir "$protonrun_exec" echo foo
}

option_show_fails_if_app_dir_is_missing() { #@test
	run_fails_missing_app_dir "$protonrun_exec" --show
}

option_show_fails_when_proton_version_file_cannot_be_read() { #@test
	run_fails_missing_version_file "$protonrun_exec" --show
}

option_show_fails_when_app_prefix_is_missing() { #@test
	run_fails_missing_prefix_dir "$protonrun_exec" --show
}

option_show_fails_when_proton_dir_is_missing() { #@test
	run_fails_missing_proton_dir "$protonrun_exec" --show
}

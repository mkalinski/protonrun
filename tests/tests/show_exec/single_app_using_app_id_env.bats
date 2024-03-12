load ../../constants/app_1.bash
load ../../constants/protonrun_exec.bash
load ../../fixtures/assert_env_printout.bash
load ../../fixtures/mock_protonrun_steam_apps.bash

setup() {
	mock_protonrun_steam_apps <<-EOF
		$app_1_mock_protonrun_steam_apps_line
	EOF

	declare -gx PROTONRUN_APP_ID="$app_1_id"
}

@test 'exits with error code from command being run' {
	run "$protonrun_exec" sh -c 'exit 100'

	[[ $status -eq 100 ]]
}

@test 'sets up env vars and PATH for the app with PROTONRUN_APP_ID' {
	run "$protonrun_exec" env

	[[ $status -eq 0 ]]
	assert_env_printout "$app_1_id" "$app_1_proton_version" <<< "$output"
}

@test 'with --show prints exported values before execution' {
	run "$protonrun_exec" --show echo foo

	[[ $status -eq 0 ]]
	[[ ${lines[-1]} == foo ]]
	assert_env_printout "$app_1_id" "$app_1_proton_version" <<< "$output"
}

@test '--show prints exported values when no command' {
	run "$protonrun_exec" --show

	[[ $status -eq 0 ]]
	assert_env_printout "$app_1_id" "$app_1_proton_version" <<< "$output"
}

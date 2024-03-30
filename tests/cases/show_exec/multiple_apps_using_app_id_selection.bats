load ../../constants/app_1.bash
load ../../constants/app_2.bash
load ../../fixtures/protonrun_exec.bash
load ../../fixtures/assert_env_printout
load ../../fixtures/mock_protonrun_steam_apps.bash

setup() {
	# App definitions in reverse order, to show sorting.
	mock_protonrun_steam_apps <<-EOF
		$app_2_mock_protonrun_steam_apps_line
		$app_1_mock_protonrun_steam_apps_line
	EOF
}

exec_selects_app_using_prompt_when_PROTONRUN_APP_ID_not_set() { #@test
	PS3= run "$protonrun_exec" env <<< 2

	[[ $status -eq 0 ]]
	[[ ${lines[0]} == "1) $app_1_id \"$app_1_name\"" ]]
	[[ ${lines[1]} == "2) $app_2_id \"$app_2_name\"" ]]
	assert_env_printout "$app_2_id" "$app_2_proton_version" <<< "$output"
}

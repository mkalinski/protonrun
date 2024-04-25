setup() {
	load ../../bats/support/load.bash || return
	load ../../bats/assert/load.bash || return

	load ../../constants/app_1.bash || return
	load ../../constants/app_2.bash || return
	load ../../fixtures/protonrun_exec.bash || return
	load ../../fixtures/assert_env_printout || return
	load ../../fixtures/mock_protonrun_steam_apps.bash || return

	# App definitions in reverse order, to show sorting.
	mock_protonrun_steam_apps <<-EOF
		$app_2_mock_protonrun_steam_apps_line
		$app_1_mock_protonrun_steam_apps_line
	EOF
}

exec_selects_app_using_prompt_when_PROTONRUN_APP_ID_not_set() { #@test
	PS3= run "$protonrun_exec" env <<< 2

	assert_success
	assert_line -n 0 "1) $app_1_id \"$app_1_name\""
	assert_line -n 1 "2) $app_2_id \"$app_2_name\""
	assert_env_printout "$app_2_id" "$app_2_proton_version" <<< "$output"
}

load fixture_protonrun
load fixture_protonrun_with_select
load fixture_mock_steam
load fixture_verify_env
load fixture_multiple_apps

setup() {
	mock_steam_root <<< "$(get_multiple_apps_steam_mock_data)"
}

teardown() {
	clear_steam_root_mock
}

@test 'selects app with prompt when PROTONRUN_APP_ID not set' {
	protonrun_with_select 2 env
	[[ $status -eq 0 ]]
	[[ "$(remove_cr <<< ${lines[0]})" == "1) \"$APP_1_NAME\"" ]]
	[[ "$(remove_cr <<< ${lines[1]})" == "2) \"$APP_2_NAME\"" ]]
	remove_cr <<< "$output" |
		verify_env "$APP_2_ID" "$PROTON_VERSION"
}

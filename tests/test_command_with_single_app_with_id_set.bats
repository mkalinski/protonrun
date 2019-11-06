load fixture_protonrun
load fixture_mock_steam
load fixture_verify_env
load fixture_single_app

setup() {
	mock_steam_root <<< "$(get_single_app_steam_mock_data)"
	declare -gx PROTONRUN_APP_ID="$APP_ID"
}

teardown() {
	clear_steam_root_mock
}

@test 'command exits with error code from the command line' {
	run ./protonrun sh -c 'exit 100'
	[[ $status -eq 100 ]]
}

@test 'command sets up env vars and PATH for the app with PROTONRUN_APP_ID' {
	run ./protonrun env
	[[ $status -eq 0 ]]
	verify_env "$APP_ID" "$PROTON_VERSION" <<< "$output"
}

@test 'command --show prints exported values before execution' {
	run ./protonrun --show echo foo
	[[ $status -eq 0 ]]
	verify_env "$APP_ID" "$PROTON_VERSION" <<< "$output"
	[[ ${lines[-1]} == foo ]]
}

load fixture_protonrun
load fixture_mock_steam
load fixture_single_app
load fixture_verify_env

setup() {
	mock_steam_root <<< "$(get_single_app_steam_mock_data)"
	declare -gx PROTONRUN_APP_ID="$APP_ID"
}

teardown() {
	clear_steam_root_mock
}

@test '--show prints exported values and exits if the command is missing' {
	run ./protonrun --show
	[[ $status -eq 0 ]]
	verify_env "$APP_ID" "$PROTON_VERSION" <<< "$output"
}

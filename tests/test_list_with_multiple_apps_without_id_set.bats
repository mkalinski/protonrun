load fixture_protonrun
load fixture_mock_steam
load fixture_multiple_apps

setup() {
	mock_steam_root <<< "$(get_multiple_apps_steam_mock_data)"
}

teardown() {
	clear_steam_root_mock
}

@test '--list prints available apps and exits' {
	run ./protonrun --list echo foo
	[[ $status -eq 0 ]]
	[[ ${#lines[@]} -eq 2 ]]
	[[ ${lines[0]} == "$APP_1_ID \"$APP_1_NAME\"" ]]
	[[ ${lines[1]} == "$APP_2_ID \"$APP_2_NAME\"" ]]
}

@test '--list does not print app name if manifest file missing' {
	rm "$PROTONRUN_STEAM_ROOT/steamapps/appmanifest_$APP_1_ID.acf"
	run ./protonrun --list
	[[ $status -eq 0 ]]
	# First line is an error message because of the missing file
	[[ ${#lines[@]} -eq 3 ]]
	[[ ${lines[1]} == $APP_1_ID ]]
	[[ ${lines[2]} == "$APP_2_ID \"$APP_2_NAME\"" ]]
}

@test '--list does not print app name if not found in manifest file' {
	echo '"foo" "bar"' > "$PROTONRUN_STEAM_ROOT/steamapps/appmanifest_$APP_2_ID.acf"
	run ./protonrun --list
	[[ $status -eq 0 ]]
	[[ ${#lines[@]} -eq 2 ]]
	[[ ${lines[0]} == "$APP_1_ID \"$APP_1_NAME\"" ]]
	[[ ${lines[1]} == $APP_2_ID ]]
}

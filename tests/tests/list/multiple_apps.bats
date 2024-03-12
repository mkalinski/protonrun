load ../../constants/app_1.bash
load ../../constants/app_2.bash
load ../../constants/protonrun_exec.bash
load ../../fixtures/mock_protonrun_steam_apps.bash

setup() {
	mock_protonrun_steam_apps <<-EOF
		$app_1_mock_protonrun_steam_apps_line
		$app_2_mock_protonrun_steam_apps_line
	EOF
}

@test '--list prints available apps and exits' {
	run "$protonrun_exec" --list echo foo
	[[ $status -eq 0 ]]
	[[ ${#lines[@]} -eq 2 ]]
	[[ ${lines[0]} == "$app_1_id \"$app_1_name\"" ]]
	[[ ${lines[1]} == "$app_2_id \"$app_2_name\"" ]]
}

@test '--list does not print app name if manifest file missing' {
	rm "$PROTONRUN_STEAM_ROOT/steamapps/appmanifest_$app_1_id.acf"
	run "$protonrun_exec" --list
	[[ $status -eq 0 ]]
	# First line is an error message because of the missing file
	[[ ${#lines[@]} -eq 3 ]]
	[[ ${lines[1]} == $app_1_id ]]
	[[ ${lines[2]} == "$app_2_id \"$app_2_name\"" ]]
}

@test '--list does not print app name if not found in manifest file' {
	echo '"foo" "bar"' > "$PROTONRUN_STEAM_ROOT/steamapps/appmanifest_$app_2_id.acf"
	run "$protonrun_exec" --list
	[[ $status -eq 0 ]]
	[[ ${#lines[@]} -eq 2 ]]
	# The app with unknown name is always sorted first
	[[ ${lines[0]} == $app_2_id ]]
	[[ ${lines[1]} == "$app_1_id \"$app_1_name\"" ]]
}

setup() {
	load ../../constants/app_1.bash || return
	load ../../constants/app_2.bash || return
	load ../../fixtures/protonrun_exec.bash || return
	load ../../fixtures/mock_protonrun_steam_apps.bash || return

	mock_protonrun_steam_apps <<-EOF
		$app_1_mock_protonrun_steam_apps_line
		$app_2_mock_protonrun_steam_apps_line
	EOF
}

option_list_prints_available_apps_and_exits() { #@test
	run "$protonrun_exec" --list echo foo
	[[ $status -eq 0 ]]
	[[ ${#lines[@]} -eq 2 ]]
	[[ ${lines[0]} == "$app_1_id \"$app_1_name\"" ]]
	[[ ${lines[1]} == "$app_2_id \"$app_2_name\"" ]]
}

option_list_does_not_print_app_name_if_manifest_file_missing() { #@test
	rm "$PROTONRUN_STEAM_ROOT/steamapps/appmanifest_$app_1_id.acf"
	run "$protonrun_exec" --list
	[[ $status -eq 0 ]]
	# First line is an error message because of the missing file
	[[ ${#lines[@]} -eq 3 ]]
	[[ ${lines[1]} == $app_1_id ]]
	[[ ${lines[2]} == "$app_2_id \"$app_2_name\"" ]]
}

option_list_does_not_print_app_name_if_not_found_in_manifest_file() { #@test
	echo '"foo" "bar"' > "$PROTONRUN_STEAM_ROOT/steamapps/appmanifest_$app_2_id.acf"
	run "$protonrun_exec" --list
	[[ $status -eq 0 ]]
	[[ ${#lines[@]} -eq 2 ]]
	# The app with unknown name is always sorted first
	[[ ${lines[0]} == $app_2_id ]]
	[[ ${lines[1]} == "$app_1_id \"$app_1_name\"" ]]
}

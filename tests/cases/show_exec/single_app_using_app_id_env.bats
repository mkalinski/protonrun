setup() {
	load ../../bats/support/load.bash || return
	load ../../bats/assert/load.bash || return

	load ../../constants/app_1.bash || return
	load ../../fixtures/protonrun_exec.bash || return
	load ../../fixtures/assert_env_printout.bash || return
	load ../../fixtures/mock_protonrun_steam_apps.bash || return

	mock_protonrun_steam_apps <<-EOF
		$app_1_mock_protonrun_steam_apps_line
	EOF

	declare -gx PROTONRUN_APP_ID="$app_1_id"
}

exec_exits_with_error_code_of_command() { #@test
	run "$protonrun_exec" sh -c 'exit 100'

	assert_failure 100
}

exec_sets_up_env_vars_and_PATH_for_the_app_with_PROTONRUN_APP_ID() { #@test
	run "$protonrun_exec" env

	assert_success
	assert_env_printout "$app_1_id" "$app_1_proton_version" <<< "$output"
}

exec_with_option_show_prints_exported_values_before_command() { #@test
	run "$protonrun_exec" --show echo foo

	assert_success
	assert_line -n -1 foo
	assert_env_printout "$app_1_id" "$app_1_proton_version" <<< "$output"
}

exec_show_prints_exported_values_when_no_command() { #@test
	run "$protonrun_exec" --show

	assert_success
	assert_env_printout "$app_1_id" "$app_1_proton_version" <<< "$output"
}

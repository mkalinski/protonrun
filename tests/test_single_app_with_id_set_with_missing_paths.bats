load fixture_protonrun
load fixture_mock_steam
load fixture_single_app
load fixture_error_prefix
load fixture_remove_paths

setup() {
	mock_steam_root <<< "$(get_single_app_steam_mock_data)"
	declare -gx PROTONRUN_APP_ID="$APP_ID"
}

teardown() {
	clear_steam_root_mock
}

fails_when_missing_app_dir() {
	remove_app_dir "$PROTONRUN_APP_ID"
	run "$@"
	[[ $status -eq 1 ]]
	[[ $output == "$ERROR_PREFIX $REMOVED_APP_DIR is not a directory" ]]
}

fails_when_missing_version_file() {
	remove_proton_version_file "$PROTONRUN_APP_ID"
	run "$@"
	[[ $status -eq 1 ]]
	# The first line could be a bash built-in error message
	[[
		${lines[-1]} \
		== "$ERROR_PREFIX Could not read proton version from: $REMOVED_PROTON_VERSION_FILE"
	]]
}

fails_when_missing_app_prefix_dir() {
	remove_proton_prefix_dir "$PROTONRUN_APP_ID"
	run "$@"
	[[ $status -eq 1 ]]
	[[
		$output \
		== "$ERROR_PREFIX $REMOVED_PROTON_PREFIX_DIR is not a directory"
	]]
}

fails_when_missing_proton_dir() {
	remove_proton_app_dir "$PROTON_VERSION"
	run "$@"
	[[ $status -eq 1 ]]
	[[
		$output \
		== "$ERROR_PREFIX $REMOVED_PROTON_APP_DIR/dist is not a directory"
	]]
}

@test 'command fails without running when app dir is missing' {
	fails_when_missing_app_dir ./protonrun echo foo
}

@test 'command fails without running when proton version file cannot be read' {
	fails_when_missing_version_file ./protonrun echo foo
}

@test 'command fails without running when app prefix is missing' {
	fails_when_missing_app_prefix_dir ./protonrun echo foo
}

@test 'command fails without running when proton dir is missing' {
	fails_when_missing_proton_dir ./protonrun echo foo
}

@test '--show fails if app dir is missing' {
	fails_when_missing_app_dir ./protonrun --show
}

@test '--show fails when proton version file cannot be read' {
	fails_when_missing_version_file ./protonrun --show
}

@test '--show fails when app prefix is missing' {
	fails_when_missing_app_prefix_dir ./protonrun --show
}

@test '--show fails when proton dir is missing' {
	fails_when_missing_proton_dir ./protonrun --show
}

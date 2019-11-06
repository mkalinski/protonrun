# Create an empty temporary directory for mock steam root.
# Panics if creating the temporary directory fails.
make_steam_root_dir() {
	declare -gx PROTONRUN_STEAM_ROOT
	PROTONRUN_STEAM_ROOT="$(mktemp -d)" || exit 1
}

# Create a mock of the steam directory, for the purposes of testing protonrun.
# Set the PROTONRUN_STEAM_ROOT environment variable to the mock directory.
# Input:
#   APP_ID_1 PROTON_VERSION_1 APP_NAME_1
#   APP_ID_2 PROTON_VERSION_2 APP_NAME_2
#   ...
mock_steam_root() {
	make_steam_root_dir
	declare -r apps_dir="$PROTONRUN_STEAM_ROOT/steamapps"
	declare -r pfxs_dir="$apps_dir/compatdata"

	mkdir -p "$pfxs_dir"

	declare app_id proton_ver app_name pfx_dir

	while read app_id proton_ver app_name; do
		echo -e "\\t\"name\"\\t\\t\"$app_name\"" \
			> "$apps_dir/appmanifest_$app_id.acf"
		pfx_dir="$pfxs_dir/$app_id"
		mkdir "$pfx_dir"
		echo "$proton_ver" > "$pfx_dir/version"
		# It's more practical to check for "dist" in the script than for
		# "Proton X.Y". It's semantically the same anyway.
		mkdir -p "$apps_dir/common/Proton ${proton_ver%%-*}/dist"
	done
}

# Clean up after mock_steam_root
clear_steam_root_mock() {
	rm -rf "$PROTONRUN_STEAM_ROOT"
}

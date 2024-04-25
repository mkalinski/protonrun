load ../../fixtures/mock_protonrun_steam_root.bash || exit

# Create a mock of the steam directory, for the purposes of testing protonrun.
# Input:
#   APP_ID_1 PROTON_VERSION_1 APP_NAME_1
#   APP_ID_2 PROTON_VERSION_2 APP_NAME_2
#   ...
mock_protonrun_steam_apps() {
	mock_protonrun_steam_root || return

	declare -r apps_dir="$PROTONRUN_STEAM_ROOT/steamapps"
	declare -r pfxs_dir="$apps_dir/compatdata"

	mkdir -p "$pfxs_dir"

	declare app_id proton_ver app_name pfx_dir

	while read app_id proton_ver app_name; do
		echo -e "\\t\"name\"\\t\\t\"$app_name\"" \
			> "$apps_dir/appmanifest_$app_id.acf"

		pfx_dir="$pfxs_dir/$app_id"
		mkdir -p "$pfx_dir/pfx"
		echo "$proton_ver" > "$pfx_dir/version"

		# It's more practical to check for "dist" in the script than for
		# "Proton X.Y". It's semantically the same anyway.
		mkdir -p "$apps_dir/common/Proton ${proton_ver%%-*}/dist"
	done
}

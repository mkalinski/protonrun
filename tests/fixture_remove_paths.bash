remove_app_dir() {
	declare -r app_id="$1"
	declare -g REMOVED_APP_DIR="$PROTONRUN_STEAM_ROOT/steamapps/compatdata/$app_id"
	rm -r "$REMOVED_APP_DIR"
}

remove_proton_prefix_dir() {
	declare -r app_id="$1"
	declare -g REMOVED_PROTON_PREFIX_DIR="$PROTONRUN_STEAM_ROOT/steamapps/compatdata/$app_id"
	rm -r "$REMOVED_PROTON_PREFIX_DIR"
}

remove_proton_version_file() {
	declare -r app_id="$1"
	declare -g REMOVED_PROTON_VERSION_FILE="$PROTONRUN_STEAM_ROOT/steamapps/compatdata/$app_id/version"
	rm "$REMOVED_PROTON_VERSION_FILE"
}

remove_proton_app_dir() {
	declare -r proton_version="$1"
	declare -g REMOVED_PROTON_APP_DIR="$PROTONRUN_STEAM_ROOT/steamapps/common/Proton $proton_version"
	rm -r "$REMOVED_PROTON_APP_DIR"
}

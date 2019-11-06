verify_env() {
	declare -r app_id="$1"
	declare -r proton_ver="$2"

	declare key value
	declare -A envs

	while IFS=\= read -r key value; do
		if [[ -n $key && -n $value ]]; then
			envs[$key]="$value"
		fi
	done
	declare -r wine_dist="$PROTONRUN_STEAM_ROOT/steamapps/common/Proton $proton_ver/dist"

	[[
		${envs[WINEPREFIX]} \
		== "$PROTONRUN_STEAM_ROOT/steamapps/compatdata/$app_id/pfx" \
		&& ${envs[PATH]} == "$wine_dist/bin":* \
		&& ${envs[WINESERVER]} == $wine_dist/bin/wineserver \
		&& ${envs[WINELOADER]} == $wine_dist/bin/wine \
		&& ${envs[WINEDLLPATH]} == $wine_dist/lib/wine:$wine_dist/lib64/wine \
	]]
}

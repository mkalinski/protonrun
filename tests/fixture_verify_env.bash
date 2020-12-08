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

	declare -r proton="$PROTONRUN_STEAM_ROOT/steamapps/common/Proton $proton_ver"
	declare -r proton_dist="$proton/dist"

	[[
		${envs[WINEPREFIX]} \
		== "$PROTONRUN_STEAM_ROOT/steamapps/compatdata/$app_id/pfx" \
		&& ${envs[PROTON]} == "$proton" \
		&& ${envs[PATH]} == "$proton_dist/bin":* \
		&& ${envs[WINESERVER]} == $proton_dist/bin/wineserver \
		&& ${envs[WINELOADER]} == $proton_dist/bin/wine \
		&& ${envs[WINEDLLPATH]} == $proton_dist/lib/wine:$proton_dist/lib64/wine \
	]]
}

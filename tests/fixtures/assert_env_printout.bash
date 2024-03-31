load ../../fixtures/mock_protonrun_steam_root.bash || exit

# Usage: assert_env_printout "$app_id" "$proton_ver" <<< "$printout"
assert_env_printout() {
	mock_protonrun_steam_root || return

	declare -r app_id="$1"
	declare -r proton_ver="$2"

	declare -r proton="$PROTONRUN_STEAM_ROOT/steamapps/common/Proton $proton_ver"
	declare -r proton_dist="$proton/dist"

	declare -rA expected_envs=(
		PATH "$proton_dist/bin:$PATH"
		PROTON "$proton"
		WINEDLLPATH "$proton_dist/lib/wine:$proton_dist/lib64/wine"
		WINELOADER "$proton_dist/bin/wine"
		WINEPREFIX "$PROTONRUN_STEAM_ROOT/steamapps/compatdata/$app_id/pfx"
		WINESERVER "$proton_dist/bin/wineserver"
	)

	declare -A missing_envs
	declare key value expected_value bad_envs

	for key in "${!expected_envs[@]}"; do
		missing_envs[$key]=1
	done

	while IFS=\= read -r key value; do
		expected_value="${expected_envs[$key]}"

		if [[ -n $expected_value ]]; then
			if [[ $value != $expected_value ]]; then
				bad_envs+=("$key=$value")
			fi

			unset "missing_envs[$key]"
		fi
	done

	declare result=0

	if [[ ${#bad_envs} -gt 0 ]]; then
		echo 'Unexpected environment values:' >&2
		printf '  %s\n' "${bad_envs[@]}" >&2
		result=1
	fi

	if [[ ${#missing_envs} -gt 0 ]]; then
		echo 'Missing environment variables:' >&2
		printf '  %s\n' "${!missing_envs[@]}" >&2
		result=1
	fi

	return "$result"
}

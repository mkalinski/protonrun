#!/usr/bin/env bash
if [[ ${BASH_SOURCE[0]} != */* ]]; then
	echo "ERROR: Cannot figure out where 'run_tests.bash' is called from." >&2
	exit 2
fi

declare -r here="${BASH_SOURCE[0]%/*}"
exec "$here"/tests/bats/core/bin/bats "$@" -r "$here"/tests/tests/

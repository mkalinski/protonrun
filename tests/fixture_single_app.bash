declare -g APP_ID=1001
declare -g PROTON_VERSION=1.1
declare -g APP_NAME='foo bar'

get_single_app_steam_mock_data() {
	echo $APP_ID $PROTON_VERSION-2 $APP_NAME
}

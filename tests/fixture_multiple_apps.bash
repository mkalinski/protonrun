declare -g APP_1_ID=1001
declare -g APP_1_NAME=aaa
declare -g APP_2_ID=2002
declare -g APP_2_NAME=zzz
declare -g PROTON_VERSION=2.2

get_multiple_apps_steam_mock_data() {
	echo $APP_1_ID $PROTON_VERSION $APP_1_NAME
	echo $APP_2_ID $PROTON_VERSION-5 $APP_2_NAME
}

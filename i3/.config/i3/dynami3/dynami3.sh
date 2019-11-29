#!/bin/bash
export dir=~/.config/i3
export dy_dir="$(dirname "${BASH_SOURCE[0]}")"
export plugins=$dy_dir/plugins

export preconf=$dir/preconfig
export finconf=$dir/config


cat $preconf > $finconf

parse_config() {
	< "$dy_dir/dynami3.conf" \
	grep -Po '^[^#]*' \
	| perl -pe 's/^\s*//' \
	| perl -pe 's/\s*(?=.$)\s//'
}

mapfile -t plugins_list < <(parse_config)

for p_name in "${plugins_list[@]}"; do
	export p_name="$p_name"
	echo debug: $p_name
	export p_dir="$plugins/$p_name"
	export p_run="$plugins/$p_name/plugin.sh"

	{
		"$p_run" >/dev/null 2&>/dev/null && {

			echo "# {{{ dynami3: $p_name #"
			"$p_run" | perl -pe 's/^/\t/'
			echo "# }}} $p_name"

		} || {

			echo "# dynami3: $p_name: plugin failed #"
			{
				i3-nagbar -t error -m "There is an error with dynami3: $p_name" \
				-b 'Open shell' '$SHELL' \
				-b 'Edit plugin conf' '$EDITOR $plugins/$p_name/plugin.conf' \
				-b 'Edit plugin file' '$EDITOR $plugins/$p_name/plugin.sh' \
				-b 'Edit dynami3 conf' '$EDITOR $dy_dir/dynami3.conf' \
				-b 'Edit dynami3 file' '$EDITOR $dy_dir/dynami3.sh' \
				-b 'Restart i3' '~/.i3/manager.sh restart' \

			} >/dev/null 2>/dev/null

		}
	} >> $finconf
done

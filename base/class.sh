#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

# hint: this is where all the magic happens

Function.exists() {
	type $1 2> /dev/null | grep -q 'is a function' && echo 1
}

Function.protected(){
	error "Invalid request."
	return 1
}

Class.new(){
	: ${1:?"Class name required."}

	debug "Initializing ${1} class..."
	Array.new "${1}__INSTANCES" false

	eval "alias ${1}.methods='Array.all \"${1}__METHODS\"'"
	eval "alias ${1}.instances='${1}__INSTANCES.all'"
	eval "alias ${1}.instances.count='${1}__INSTANCES.count'"
	eval "alias ${1}.instances.find='${1}__INSTANCES.find'"

	eval "${1}.new(){
	  : \${1:?\"No instance name given.\`${1}.usage\`\"}

		debug \"Creating new ${1} at \${1}...\"
		eval \"alias \${1}='echo \"\${2}\"'\"
		eval \"alias \${1}.instance_index='${1}.instance_index \${1}'\"
		eval \"alias \${1}.reload='${1}.reload \${1}'\"
		eval \"alias \${1}.destroy='${1}.destroy \${1}'\"

		${1}.load_methods \"\${1}\" \"\${2}\"

		# call the initialize function on the class if it exists
		[ \`Function.exists \"${1}.initialize\"\` ] && ${1}.initialize \"\${1}\"

		if [ ! \`${1}.instances.find \"\$1\"\` ]; then # instance doesnt exist
			[ \"\$2\" != 'false' ] && ${1}__INSTANCES.push \"\${1}\"
			eval ${1}__\${1}_INDEX=\$?
		fi
	}"

	eval "${1}.reload(){
		${1}.unload_methods \"\${1}\" && ${1}.load_methods \"\${1}\" \"\${2}\"
	}"

	eval "${1}.load_methods(){
		debug 'Attaching methods...'
		for method in \`${1}.methods\` methods; do
			[ -n \"\$2\" ] && local arg=\\\"\${2}\\\"
			eval \"alias \${1}.\${method}='${1}.send '\${method}' \\\"\${1}\\\" \"\$arg\"'\"
		done
	}"

	eval "${1}.unload_methods(){
		for method in \`${1}.methods\`; do
			unalias \${1}.\${method}
		done
	}"

	# @param 1 = method
	# @param 2 = descriptor, not passed
	# @param 3 = object (string, file, etc)
	# the trick -> \${1+\"\$@\"}
	if [ ! `Function.exists "${1}.send"` ]; then
		eval "${1}.send(){
			eval ${1}.\${1} \\\"\${3}\\\" \\\"\${4}\\\" \\\"\${5}\\\"
		}"
	fi

	eval "${1}.instance_index(){
		eval echo \\\$${1}__\${1}_INDEX
	}"

	eval "${1}.destroy(){
		: \${1:?\"No instance name given.\"}
		debug \"Destroying ${1} instance \${1}...\"

		${1}.unload_methods \"\${1}\"

		${1}__INSTANCES.delete \`eval \${1}.instance_index\`
		unalias \${1}.methods \${1} \${1}.destroy \${1}.instance_index
	}"

	eval "${1}.destroy_all(){
		for el in `eval ${1}.instances`; do
			${1}.destroy \${el}
		done
	}"

	eval "${1}.usage(){
		echo -e \"\n\nUsage: ${1}.new [var] [object]\"
		echo -e \"Then: [var].methods to start playing around.\"
	}"

}

Class.unload(){
	: ${1:?"No class name given."}

	[ ! `Function.exists "${1}.new"` ] && error 'Class not loaded.' && return 1

	debug "Destroying instances of ${1} class..."
	${1}.destroy_all

	[ "$1" == "Array" ] && error 'System class, cannot be unloaded.' || ${1}__INSTANCES.destroy
}

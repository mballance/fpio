
if test "x$SIMSCRIPTS_PROJECT_ENV" = "xtrue"; then
	export FPIO=`dirname $SIMSCRIPTS_DIR`
	export FPIO=`dirname $FPIO`
fi

export MEMORY_PRIMITIVES=$FPIO/rtl/memory_primitives
export STD_PROTOCOL_IF=$FPIO/rtl/std_protocol_if
export SV_BFMS=$FPIO/ve/sv_bfms


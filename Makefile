SWFFILE = main.swf

all: swf

swf:
	mxmlc Preloader.as -static-link-runtime-shared-libraries=true -default-frame-rate 60 -frames.frame mainframe Main
	mv Preloader.swf ${SWFFILE}

debug:
	mxmlc Preloader.as -debug=true -static-link-runtime-shared-libraries=true -default-frame-rate 60 -frames.frame mainframe Main
	mv Preloader.swf debug_${SWFFILE}
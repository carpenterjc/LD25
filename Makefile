SWFFILE = main.swf

all: swf

swf:
	/usr/local/lib/audacity/ffmpeg -y -i sounds/handbag.wav sounds/handbag.mp3
	/usr/local/lib/audacity/ffmpeg -y -i sounds/spin.wav sounds/spin.mp3
	/usr/local/lib/audacity/ffmpeg -y -i sounds/swag.wav sounds/swag.mp3
	/usr/local/lib/audacity/ffmpeg -y -i sounds/ooo.wav sounds/ooo.mp3
	
	mxmlc Preloader.as -static-link-runtime-shared-libraries=true -default-frame-rate 60 -frames.frame mainframe Main
	mv Preloader.swf ${SWFFILE}

debug:
	mxmlc Preloader.as -debug=true -static-link-runtime-shared-libraries=true -default-frame-rate 60 -frames.frame mainframe Main
	mv Preloader.swf debug_${SWFFILE}
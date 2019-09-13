#!/bin/bash
#Run this script after setup1-2.
#This script installs Linux utilities for audio and video processing.
#This is mostly meant for audio, and some video already done in setup3_images_graphics.sh.
#
#All packages in this script can be obtained by apt-get install (see https://packages.ubuntu.com).
#
#Unwanted packages can be commented out.
#To later remove an unwanted package, use: sudo apt remove <pkgname>
#
#For each tool, I provide references and/or the main website.
#For further information on any tool, search Google, Wikipedia, or the Free Software Directory (https://directory.fsf.org).
#
#Coded by: Erik Edwards, Oct 2018.

#OSS: Open Sound System (audio subsystem API and device drivers)
#OSS v. 3 was the original sound system for Linux.
#It was superceded by ALSA, but some software still requires compatibility.
#Small, minimal dependencies (just standard C code in libc6).
#http://www.opensound.com
#sudo apt-get -y install oss4-base					#OSS v. 4


#But oss interferes with Ubuntu, so use linux-sound-base instead (which includes oss).
#sudo apt-get -y install linux-sound-base			#linux-sound-base


#ALSA (Advanced Linux Sound Architecture) library: provides audio and MIDI functionality to Linux.
#Audio interfaces, sound drivers, support for Open Sound System (OSS).
#Used by most audio and video programs if running on Linux.
#Phillips D. 2000. Linux music & sound. San Francisco: No Starch Press.
#Tranter J. 2004. Introduction to sound programming with ALSA. Linux J: 6735.
#Newmarch J. 2017. Linux sound programming. New York: Apress.
#https://www.alsa-project.org
#sudo apt-get -y install libasound2-dev				#ALSA Linux sound library
#sudo apt-get -y install alsa-utils					#ALSA utils (including aplay)
#sudo apt-get -y install libasound2-plugins			#ALSA additional plugins


#libsamplerate: sample rate converter (SRC) for audio (used below)
#http://www.mega-nerd.com/SRC
sudo apt-get -y install libsamplerate0				#libsamplerate


#Ogg library.
#Ogg is a multimedia container format (for video).
#https://xiph.org/ogg
sudo apt-get -y install libogg-dev					#Ogg library


#Vorbis general audio compression codec (non-proprietary)
#https://xiph.org/vorbis
sudo apt-get -y install libvorbis-dev				#Vorbis library


#FLAC (Free Lossless Audio Codec) C library.
#FLAC is an audio format similar to mp3, but lossless.
#FLAC is said to be the fastest and most widely supported lossless audio codec, and the only non-proprietary one.
#This yields the flac command.
#https://xiph.org/flac
sudo apt-get -y install libflac-dev					#FLAC audio library
sudo apt-get -y install flac						#flac command-line tool


#OpenCORE audio codecs AMR-NB and AMR-WB (required by e.g. sox)
#https://sourceforge.net/projects/opencore-amr
sudo apt-get -y install libopencore-amrnb0			#OpenCORE AMR-NB codec
sudo apt-get -y install libopencore-amrwb0			#OpenCORE AMR-WB codec


#Opus Interactive Audio Codec: open, versatile audio codec
#Valin J-M, Vos K, Terriberry TB. 2012. Definition of the Opus audio codec. IETF, RFC6716: 326 p.
#Valin J-M, Maxwell G, Terriberry TB, Vos K. 2016. High-quality, low-delay music coding in the Opus codec. arXiv 1602.04845: 10 p.
#http://www.opus-codec.org
sudo apt-get -y install libopus-dev					#Opus codec
#sudo apt-get -y install opus-tools					#Opus command-line tools


#Speex: free codec for speech (used by below and Kaldi) (BSD licence)
#Valin J-M. 2007. The Speex codex manual: version 1.2 beta 3. xiph.org.
#https://www.speex.org
sudo apt-get -y install libspeex-dev				#Speex codec


#WavPack: hybrid lossless audio compression (used by e.g. sox)
#http://www.wavpack.com
sudo apt-get -y install wavpack						#WavPack


#libao: cross-platform audio output library
#https://www.xiph.org/ao
sudo apt-get -y install libao4						#libao


#Vorbis tools for Ogg audio format
#Gives commands: ogg123, oggdec, oggenc, ogginfo, vcut, and vorbiscomment
#http://www.linuxfromscratch.org/blfs/view/cvs/multimedia/vorbistools.html
sudo apt-get -y install vorbis-tools				#Vorbis and Ogg tools


#libsndfile: C library for reading/writing audio files.
#Not likely to be directly useful, given SoX and FFmpeg, but likely dependency.
#http://www.mega-nerd.com/libsndfile
sudo apt-get -y install libsndfile1-dev				#libsndfile audio read/write library


#libcanberra: generates event sounds on free desktops (e.g. Gnome)
#Used by other packages as a dependency.
#http://0pointer.de/lennart/projects/libcanberra
sudo apt-get -y install libcanberra0


#JACK Audio Connection Kit (used by other libraries)
#Phillips D. 2000. Linux music & sound. San Francisco: No Starch Press.
#Newmarch J. 2017. Linux sound programming. New York: Apress.
#http://jackaudio.org
#sudo apt-get -y install libjack-dev					#JACK audio library
#sudo apt-get -y install libjack-jackd2-dev			#JACK audio connection kit


#PulseAudio sound server
#Part of Linux sound architecture, should be default on Ubuntu.
#Phillips D. 2000. Linux music & sound. San Francisco: No Starch Press.
#Newmarch J. 2017. Linux sound programming. New York: Apress.
#Späth P. 2017. Audio visualization using ThMAD: realtime graphics rendering for Ubuntu Linux. New York: Apress.
#https://www.freedesktop.org/wiki/Software/PulseAudio
#sudo apt-get -y install pulseaudio					#PulseAudio sound server
#sudo apt-get -y install pavucontrol				#PulseAudio volume control


#OSS compatibility
sudo apt-get -y install osspd						#OSS proxy daemon
#sudo apt-get -y install oss-compat					#OSS compatibility files


#PortAudio: portable audio I/O library for C/C++ (MIT licence)
#Requires libasound2 and libjack.
#Bencina R, Burk P. 2001. PortAudio – an open source cross platform audio API. Proc ICMA: 4 p.
#http://www.portaudio.com
#sudo apt-get -y install portaudio19-dev				#PortAudio library


#sndio: sound input/output, a small (~1k lines of C code)
#audio/MIDI framework from OpenBSD project.
#It is used by, e.g., OpenAL below.
#http://www.sndio.org
sudo apt-get -y install libsndio-dev				#sndio


#libaudiofile: SGI's audiofile library
#This is only needed for GNU sound library (for conversions, use SoX and FFmpeg)
#https://audiofile.68k.org
sudo apt-get -y install libaudiofile-dev			#SGI's audiofile library


#GSM lossy speech compressor (used by ccAudio2, sox, etc.)
#http://www.quut.com/gsm
sudo apt-get -y install libgsm1						#GSM speech compressor


#GNU ccAudio2: GNU C++ library for manipulating audio data.
#https://www.gnu.org/software/ccaudio
sudo apt-get -y install libccaudio2-2				#GNU ccAudio2


#OpenAL: Open Audio Library (audio API used by e.g. MPlayer)
#Renders multichannel 3-D positional audio, so conventions resemble OpenGL.
#Note that they claim (and I tend to believe) that this completely replaces the older EAX and A3D.
#https://www.openal.org
sudo apt-get -y install libopenal-dev				#OpenAL


#Simple DirectMedia Layer (SDL) 2.0: very widely used
#abstraction layer for multimedia hardware in C/C++.
#This requires the basic Linux sound and image libraries above.
#http://www.libsdl.org
sudo apt-get -y install libsdl2-2.0-0				#SDL 2.0
#sudo apt-get -y install libsdl2-dev				#SDL 2.0


#libaudio2: Network Audio System (NAS) client library
#C code for audio over a network from Network Computing Devices (NCD).
#https://software.opensuse.org/package/libaudio2
#http://www.radscan.com/nas.html
sudo apt-get -y install libaudio-dev				#libaudio2


#mpg123: simple, lightweight, command-line MPEG player/decoder
#https://www.mpg123.de
sudo apt-get -y install mpg123						#mpg123


#libopenmpt from OPenMPT (Open ModPlug Tracker):
#C/C++ music library to decode tracked music files (modules) into raw PCM audio stream
#https://openmpt.org
#sudo apt-get -y install libopenmpt-dev				#OpenMPT


#SoX: "Sound Exchange" library for audio processing, conversion and effects.
#Long developed (since 1991); the "Swiss army knife of sound processing"
#http://sox.sourceforge.net
sudo apt-get -y install sox							#SoX audio library


#FFmpeg: audio/video conversion, processing, streaming and playing
#Stands for "Fast-forward MPEG", but is very general/useful program for wide range of audio and video.
#Installs quite a few more audio and video related dependencies.
#https://www.ffmpeg.org
sudo apt-get -y install ffmpeg						#FFmpeg audio/video library


#avconv and av-tools: there was some strange fork of the FFmpeg project [Newmarch 2017],
#such that the default on Ubuntu was avconv, as installed by apt-get install libav-tools.
#However, this depends entirely on ffmpeg, and appears unsupported now (?).
#No further tools than provided above would be included anyway, so skip for now.


#Csound: powerful, widely-used sound synthesis library and scripting language
#Vercoe B, Ellis DPW. 1990. Real-time Csound: software synthesis with sensing and control. Proc ICMC: 209-211.
#Phillips D. 2000. Linux music & sound. San Francisco: No Starch Press.
#Boulanger RC, editor. 2000. The Csound book: perspectives in software synthesis, sound design, signal processing, and programming. Cambridge, MA: MIT Press.
#Boulanger RC, Lazzarini V, editors. 2011. The audio programming book. Cambridge, MA: MIT Press.
#https://csound.com
sudo apt-get -y install csound						#Csound


#VLC media player (audio and video)
#However, this requires qt, so I suggest skip unless installing qt anyway.
#Newmarch J. 2017. Linux sound programming. New York: Apress.
#https://www.videolan.org/vlc
#sudo apt-get -y install vlc						#VLC media player


#MPlayer: widely used Movie Player (audio and video)
#Note that there is also a GUI version, but I don't think it is recommended for Ubuntu.
#Newmarch J. 2017. Linux sound programming. New York: Apress.
#mplayerhq.hu
sudo apt-get -y install mplayer						#MPlayer


#MEncoder: Movie Encoder (transcoder from same base code as MPlayer)
#This requires mplayer, and gives a new command 'mencoder'.
#mplayerhq.hu
sudo apt-get -y install mencoder					#MEncoder


#Perhaps consider: GStreamer and Totem (but not recommended by Newmarch)
#To play MIDI, consider: Timidity, fluidsynth.


#Snd: sound editor modelled loosely after Emacs
#Phillips D. 2000. Linux music & sound. San Francisco: No Starch Press.
#https://ccrma.stanford.edu/software/snd
sudo apt-get -y install snd						#Snd editor


#GNU Octave audio toolbox.
#This seems to have been discontinued, so skip.
#sudo apt-get -y install octave-audio				#Octave audio toolbox


#SimpleScreenRecorder: captures audio-video record of entire screen.
#Can also record OpenGL applications directly.
#Not actually "simple", very sophisticated and feature-rich.
#Requires FFmpeg, X11 and Qt libraries (installed automatically, but Qt is perhaps only drawback).
#Späth P. 2017. Audio visualization using ThMAD: realtime graphics rendering for Ubuntu Linux. New York: Apress.
#http://www.maartenbaert.be/simplescreenrecorder
#sudo apt-get -y install simplescreenrecorder		#SimpleScreenRecorder
#Strangely, it isn't found by install...


#Praat: heavily-used audio/speech GUI and scripting software.
#Boersma P, van Heuven V. 2002. Praat, a system for doing phonetics by computer. Glot international 5(9/10): 341-345.
#http://www.fon.hum.uva.nl/praat
sudo apt-get -y install praat						#Praat


sudo apt autoremove

exit


#openSMILE: new, but already widely used, toolkit (code in C++) for audio and speech feature extraction
#Eyben F, Wollmer M, Schuller BW. 2010. OpenSMILE – the Munich versatile and fast open-source audio feature extractor. Int Conf MM. ACM: 1459-1462.
#Eyben F, Weninger F, Gross F, Schuller BW. 2013. Recent developments in openSMILE, the Munich open-source multimedia feature extractor. Int Conf MM. ACM: 835-838.
#Schuller BW, Batliner A. 2013. Computational paralinguistics: emotion, affect and personality in speech and language processing. Chichester: Wiley.
#Eyben F. 2016. Real-time speech and music classification by large audio feature space extraction. Cham: Springer.
#Eyben F, Weninger F, Wollmer M, Schuller BW. 2016. openSMILE:), by audEERING; open-source media interpretation by large feature-space extraction. Gilching: audEERING GmbH.
#https://www.audeering.com/technology/opensmile
tooldir=/opt							#change this location as desired 
wget -P "$tooldir" https://www.audeering.com/download/1318/opensmile-2.3.0.tar.gz
#Or go to above URL and click large green "Download" button, and place in your tooldir
tar -zxvf "$tooldir/opensmile-2.3.0.tar.gz"
rm "$tooldir/opensmile-2.3.0.tar.gz"
chmod -R 775 "$tooldir/opensmile-2.3.0"
cd "$tooldir/opensmile-2.3.0"
bash buildStandalone.sh -o /usr/include/opencv2		#main install (the path is to openCV installation)
#Now add $tooldir/opensmile-2.3.0/inst/bin to your search path:
cd
vim .bashrc
#At bottom add PATH="$PATH:/home/erik/tools/opensmile-2.3.0/inst/bin"
#To test type:
SMILExtract -h										#help for main program (ignore "libdc1394 error"; it is from openCV and occurs in Python too)


#OpenMAX: Open Media Acceleration (sometimes "OMX") from Khronos group
#Royalty-free API that provides comprehensive streaming media codec and application portability
#https://www.khronos.org/openmax
#(Not on Ubuntu, I don't think.)


#Setup Xfce desktop environment
#sudo apt update && sudo apt -y upgrade
#sudo apt-get -y install xfce4 xfce4-terminal
#Couldn't get this working...


exit


#Enable sound for the Windows Subsystem Linux (WSL)
#https://token2shell.com/howto/x410/enabling-sound-in-wsl-ubuntu-let-it-sing/
#https://www.patrickwu.ml/2017/05/10/Enable-sound-in-the-Linux-Subsystem-in-Windows-10/
sudo apt-get purge pulseaudio
sudo add-apt-repository ppa:aseering/wsl-pulseaudio
sudo apt-get update
sudo apt-get -y install pulseaudio
#Then install pulseaudio for Windows on Windows side
echo export PULSE_SERVER=tcp:localhost >> ~/.bashrc
#...couldn't get this working!


#Sound packages for R: sound, audio, tuneR, seewave, [soundgen], phonTools, warbleR
#Install these in an R session with install.packages(c("sound","audio","tuneR","seewave","phonTools","warbleR"));


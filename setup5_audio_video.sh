# !/bin/bash
# 
# Run this script after setup1-2.
# This script installs Linux utilities for audio and video processing.
# This is mostly meant for audio, and some video already done in setup3_images_graphics.sh.
# 
# All packages in this script can be obtained by apt-get install (see https://packages.ubuntu.com).
# 
# Unwanted packages can be commented out.
# To later remove an unwanted package, use: sudo apt remove <pkgname>
# 
# For each tool, I provide references and/or the main website.
# For further information on any tool, search Google, Wikipedia, or the Free Software Directory (https://directory.fsf.org).
# 


# OSS: Open Sound System (audio subsystem API and device drivers)
# OSS v. 3 was the original sound system for Linux.
# It was superceded by ALSA, but some software still requires compatibility.
# Small, minimal dependencies (just standard C code in libc6).
# http://www.opensound.com
# sudo apt-get -y install oss4-base					# OSS v. 4


# But oss interferes with Ubuntu, so use linux-sound-base instead (which includes oss).
# sudo apt-get -y install linux-sound-base			# linux-sound-base


# ALSA (Advanced Linux Sound Architecture) library: provides audio and MIDI functionality to Linux.
# Audio interfaces, sound drivers, support for Open Sound System (OSS).
# Used by most audio and video programs if running on Linux.
# Phillips D. 2000. Linux music & sound. San Francisco: No Starch Press.
# Tranter J. 2004. Introduction to sound programming with ALSA. Linux J: 6735.
# Newmarch J. 2017. Linux sound programming. New York: Apress.
# https://www.alsa-project.org
sudo apt-get -y install libasound2-dev				# ALSA Linux sound library
# sudo apt-get -y install alsa-utils					# ALSA utils (including aplay)
# sudo apt-get -y install libasound2-plugins			# ALSA additional plugins


# libsamplerate: sample rate converter (SRC) for audio (used below)
# http://www.mega-nerd.com/SRC
sudo apt-get -y install libsamplerate0				# libsamplerate


# Ogg library.
# Ogg is a multimedia container format (for video).
# https://xiph.org/ogg
sudo apt-get -y install libogg-dev					# Ogg library


# Vorbis general audio compression codec (non-proprietary)
# https://xiph.org/vorbis
sudo apt-get -y install libvorbis-dev				# Vorbis library


# FLAC (Free Lossless Audio Codec) C library.
# FLAC is an audio format similar to mp3, but lossless.
# FLAC is said to be the fastest and most widely supported lossless audio codec, and the only non-proprietary one.
# This yields the flac command.
# https://xiph.org/flac
sudo apt-get -y install libflac-dev					# FLAC audio library
sudo apt-get -y install flac						# flac command-line tool


# OpenCORE audio codecs AMR-NB and AMR-WB (required by e.g. sox)
# https://sourceforge.net/projects/opencore-amr
sudo apt-get -y install libopencore-amrnb0			# OpenCORE AMR-NB codec
sudo apt-get -y install libopencore-amrwb0			# OpenCORE AMR-WB codec


# Opus Interactive Audio Codec: open, versatile audio codec
# Valin J-M, Vos K, Terriberry TB. 2012. Definition of the Opus audio codec. IETF, RFC6716: 326 p.
# Valin J-M, Maxwell G, Terriberry TB, Vos K. 2016. High-quality, low-delay music coding in the Opus codec. arXiv 1602.04845: 10 p.
# http://www.opus-codec.org
sudo apt-get -y install libopus-dev					# Opus codec
# sudo apt-get -y install opus-tools					# Opus command-line tools


# Speex: free codec for speech (used by below and Kaldi) (BSD licence)
# Valin J-M. 2007. The Speex codex manual: version 1.2 beta 3. xiph.org.
# https://www.speex.org
sudo apt-get -y install libspeex-dev				# Speex codec


# WavPack: hybrid lossless audio compression (used by e.g. sox)
# http://www.wavpack.com
sudo apt-get -y install wavpack						# WavPack


# libao: cross-platform audio output library
# https://www.xiph.org/ao
sudo apt-get -y install libao4						# libao


# Vorbis tools for Ogg audio format
# Gives commands: ogg123, oggdec, oggenc, ogginfo, vcut, and vorbiscomment
# http://www.linuxfromscratch.org/blfs/view/cvs/multimedia/vorbistools.html
sudo apt-get -y install vorbis-tools				# Vorbis and Ogg tools


# libsndfile: C library for reading/writing audio files.
# Not likely to be directly useful, given SoX and FFmpeg, but likely dependency.
# http://www.mega-nerd.com/libsndfile
sudo apt-get -y install libsndfile1-dev				# libsndfile audio read/write library


# libcanberra: generates event sounds on free desktops (e.g. Gnome)
# Used by other packages as a dependency.
# http://0pointer.de/lennart/projects/libcanberra
sudo apt-get -y install libcanberra0


# JACK Audio Connection Kit (used by other libraries)
# Phillips D. 2000. Linux music & sound. San Francisco: No Starch Press.
# Newmarch J. 2017. Linux sound programming. New York: Apress.
# http://jackaudio.org
sudo apt-get -y install libjack-dev					# JACK audio library
# sudo apt-get -y install libjack-jackd2-dev			# JACK audio connection kit


# PulseAudio sound server
# Part of Linux sound architecture, should be default on Ubuntu.
# Phillips D. 2000. Linux music & sound. San Francisco: No Starch Press.
# Newmarch J. 2017. Linux sound programming. New York: Apress.
# Späth P. 2017. Audio visualization using ThMAD: realtime graphics rendering for Ubuntu Linux. New York: Apress.
# https://www.freedesktop.org/wiki/Software/PulseAudio
# sudo apt-get -y install pulseaudio					# PulseAudio sound server
# sudo apt-get -y install pavucontrol				# PulseAudio volume control


# OSS compatibility
sudo apt-get -y install osspd						# OSS proxy daemon
# sudo apt-get -y install oss-compat					# OSS compatibility files


# PortAudio: portable audio I/O library for C/C++ (MIT licence)
# Requires libasound2 and libjack.
# Bencina R, Burk P. 2001. PortAudio – an open source cross platform audio API. Proc ICMA: 4 p.
# http://www.portaudio.com
sudo apt-get -y install libportaudio2
sudo apt-get -y install libportaudiocpp0
sudo apt-get -y install portaudio19-dev				# PortAudio library


# libsoundio: from a single developer in NYC, but seems like awesome code.
# Just reading the github description is worth it [e.g., 'bus factor'].
# https://github.com/andrewrk/libsoundio


# sndio: sound input/output, a small (~1k lines of C code)
# audio/MIDI framework from OpenBSD project.
# It is used by, e.g., OpenAL below.
# http://www.sndio.org
sudo apt-get -y install libsndio-dev				# sndio


# libaudiofile: SGI's audiofile library
# This is only needed for GNU sound library (for conversions, use SoX and FFmpeg)
# https://audiofile.68k.org
sudo apt-get -y install libaudiofile-dev			# SGI's audiofile library


# GSM lossy speech compressor (used by ccAudio2, sox, etc.)
# http://www.quut.com/gsm
sudo apt-get -y install libgsm1						# GSM speech compressor


# GNU ccAudio2: GNU C++ library for manipulating audio data.
# https://www.gnu.org/software/ccaudio
sudo apt-get -y install libccaudio2-2				# GNU ccAudio2


# OpenAL: Open Audio Library (audio API used by e.g. MPlayer)
# Renders multichannel 3-D positional audio, so conventions resemble OpenGL.
# Note that they claim (and I tend to believe) that this completely replaces the older EAX and A3D.
# https://www.openal.org
sudo apt-get -y install libopenal-dev				# OpenAL


# Simple DirectMedia Layer (SDL) 2.0: very widely used
# abstraction layer for multimedia hardware in C/C++.
# This requires the basic Linux sound and image libraries above.
# http://www.libsdl.org
sudo apt-get -y install libsdl2-2.0-0				# SDL 2.0
# sudo apt-get -y install libsdl2-dev				# SDL 2.0


# libaudio2: Network Audio System (NAS) client library
# C code for audio over a network from Network Computing Devices (NCD).
# https://software.opensuse.org/package/libaudio2
# http://www.radscan.com/nas.html
sudo apt-get -y install libaudio-dev				# libaudio2


# mpg123: simple, lightweight, command-line MPEG player/decoder
# https://www.mpg123.de
sudo apt-get -y install mpg123						# mpg123


# libopenmpt from OPenMPT (Open ModPlug Tracker):
# C/C++ music library to decode tracked music files (modules) into raw PCM audio stream
# https://openmpt.org
# sudo apt-get -y install libopenmpt-dev				# OpenMPT


# SoX: "Sound Exchange" library for audio processing, conversion and effects.
# Long developed (since 1991); the "Swiss army knife of sound processing"
# http://sox.sourceforge.net
sudo apt-get -y install sox							# SoX audio library
sudo apt-get install libsox-dev libsox-fmt-all      # these were suggested by PyTorch audio


# FFmpeg: audio/video conversion, processing, streaming and playing
# Stands for "Fast-forward MPEG", but is very general/useful program for wide range of audio and video.
# Installs quite a few more audio and video related dependencies.
# https://www.ffmpeg.org
sudo apt-get -y install ffmpeg						# FFmpeg audio/video library
sudo apt-get -y install libavcodec-extra            # Extra AV codecs


# avconv and av-tools: there was some strange fork of the FFmpeg project [Newmarch 2017],
# such that the default on Ubuntu was avconv, as installed by apt-get install libav-tools.
# However, this depends entirely on ffmpeg, and appears unsupported now (?).
# No further tools than provided above would be included anyway, so skip for now.


# Csound: powerful, widely-used sound synthesis library and scripting language
# Vercoe B, Ellis DPW. 1990. Real-time Csound: software synthesis with sensing and control. Proc ICMC: 209-211.
# Phillips D. 2000. Linux music & sound. San Francisco: No Starch Press.
# Boulanger RC, editor. 2000. The Csound book: perspectives in software synthesis, sound design, signal processing, and programming. Cambridge, MA: MIT Press.
# Boulanger RC, Lazzarini V, editors. 2011. The audio programming book. Cambridge, MA: MIT Press.
# https://csound.com
sudo apt-get -y install csound						# Csound


# VLC media player (audio and video)
# However, this requires qt, so I suggest skip unless installing qt anyway.
# Newmarch J. 2017. Linux sound programming. New York: Apress.
# https://www.videolan.org/vlc
# sudo apt-get -y install vlc						# VLC media player


# MPlayer: widely used Movie Player (audio and video)
# Note that there is also a GUI version, but I don't think it is recommended for Ubuntu.
# Newmarch J. 2017. Linux sound programming. New York: Apress.
# mplayerhq.hu
sudo apt-get -y install mplayer						# MPlayer


# MEncoder: Movie Encoder (transcoder from same base code as MPlayer)
# This requires mplayer, and gives a new command 'mencoder'.
# mplayerhq.hu
sudo apt-get -y install mencoder					# MEncoder


# Perhaps consider: GStreamer and Totem (but not recommended by Newmarch)
# To play MIDI, consider: Timidity, fluidsynth.


# Snd: sound editor modelled loosely after Emacs
# Phillips D. 2000. Linux music & sound. San Francisco: No Starch Press.
# https://ccrma.stanford.edu/software/snd
sudo apt-get -y install snd						# Snd editor


# SimpleScreenRecorder: captures audio-video record of entire screen.
# Can also record OpenGL applications directly.
# Not actually "simple", very sophisticated and feature-rich.
# Requires FFmpeg, X11 and Qt libraries (installed automatically, but Qt is perhaps only drawback).
# Späth P. 2017. Audio visualization using ThMAD: realtime graphics rendering for Ubuntu Linux. New York: Apress.
# http://www.maartenbaert.be/simplescreenrecorder
# sudo apt-get -y install simplescreenrecorder		# SimpleScreenRecorder
# Strangely, it isn't found by install...


# Praat: heavily-used audio/speech GUI and scripting software.
# Boersma P, van Heuven V. 2002. Praat, a system for doing phonetics by computer. Glot international 5(9/10): 341-345.
# http://www.fon.hum.uva.nl/praat
sudo apt-get -y install praat						# Praat


# Essentia: major C++ project for audio from UPF [GPL, non-commercial]
# Has many functions for pitch and rhythm (i.e., musical focus), but
# could use some of the later (onset detection, novelty curve, rhythm transform, etc.)
# Has some segmentation and classification, but definitely for music.
# https://essentia.upf.edu


# GNU Octave audio toolbox.
# This seems to have been discontinued, so skip.
# sudo apt-get -y install octave-audio				# Octave audio toolbox


# labelSignal: Matlab code that gives clusters and lables [GPL].
# From LIM (Lab Informatica Musicale in Italy) [Haus et al. 2017].
# Meant for automatic annotation of (monophonic) musical timbre,
# but examples include industrial noise and spring soundscape.
# Upon closer reading of code: it gets 11 CCs, and simply calls
# linkage (Matlab/Octave stats toolbox, makes hierarchical clustering dendrogram),
# and then cluster (Matlab stats toolbox) to cluster.
# But the later is not yet available in Octave...
# https://lim.di.unimi.it/demo/labelSignal.php
# https://github.com/LIMUNIMI/labelSignal
cd /opt
git clone https://github.com/LIMUNIMI/labelSignal
chmod -R 777 /opt/labelSignal


# resampy: efficient sample rate conversion in Python
# Implements the band-limited sinc interpolation method for sampling rate conversion.
# Smith JO. (2015). Center for Computer Research in Music and Acoustics (CCRMA), Stanford, CA.
# http://ccrma.stanford.edu/~jos/resample
# https://github.com/bmcfee/resampy
python -m pip install --user --upgrade resampy      # resampy


# SoundFile: audio library based on libsndfile, CFFI and NumPy for sound file read/write (BSD 3-Clause License)
# https://pypi.org/project/SoundFile
# https://pysoundfile.readthedocs.io/en/latest
python -m pip install --user --upgrade soundfile    # SoundFile


# eyeD3: "Python tool for working with audio files, specifically MP3 files containing ID3 metadata (i.e. song info)"
# Used by other libraries, so install now. Also: gives eyeD3 command-line tool.
# https://eyed3.readthedocs.io/en/latest
python -m pip install --user --upgrade eyeD3


# PyAudio: Python bindings for PortAudio "to play and record audio on a variety of platforms"
# http://people.csail.mit.edu/hubert/pyaudio
python -m pip install --user --upgrade pyaudio      # PyAudio


# SimpleAudio: "cross-platform, dependency-free audio playback capability for Python 3"
# Depends on ALSA (specifically, libasound2)
# Nice tutorial on using NumPy arrays for audio.
# https://simpleaudio.readthedocs.io/en/latest
python -m pip install --user simpleaudio


# PyDub: Python library to "manipulate audio with a simple and easy high level interface" [MIT license]
# Overall, rather adolescent language and basic functions like sox but not as good. Just uses ffmpeg.
# http://pydub.com
# https://github.com/jiaaro/pydub
python -m pip install --user --upgrade pydub


# audiotok: Python "audio/acoustic activity detection and audio segmentation tool" [MIT license]
# Very basic, seems to just use a simple threshold, and does splits/merges. Online functionality.
# https://github.com/amsehili/auditok
python -m pip install --user git+https://github.com/amsehili/auditok


# pyAudioAnalysis: feature extraction, classification, segmentation and applications [Apache 2.0 license]
# Seems like excellent work, from T. Giannakopoulus (a directory of audio ML at Greek company).
# Has unsupervised segmentation (e.g. spkr diarization) and supervised segmentation (joint segmentation-classifiction).
# Audio event detection and exclude silence periods from long recordings.
# Features (MFCC, chromogram, etc.). Classify unknown sounds. Extract audio thumbnails.
# Audio dim reduction to visualize audio data. Train/apply audio regression models (e.g. emotion recognit).
# Requires PyDub, eyeD3 and hmmlearn.
# Giannakopoulos T. (2015). pyAudioAnalysis: an open-source Python library for audio signal analysis. PLoS one. 10(12).
# https://github.com/tyiannak/pyAudioAnalysis
cd /opt
git clone https://github.com/tyiannak/pyAudioAnalysis.git
chmod -R 777 /opt/pyAudioAnalysis
cd /opt/pyAudioAnalysis
python -m pip install --user -r ./requirements.txt
python -m pip install --user -e .
# To test
python /opt/pyAudioAnalysis/pyAudioAnalysis/audioAnalysis.py --help


# pAura: Python AUdio Recording and Analysis [MIT license].
# "Python tool for recording and analyzing sounds in an online and continuous manner."
# It is a single script that, for each segment:
# 1) Visualizes the spectrogram, chromagram along with the raw samples (waveform)
# 2) Applies a simple audio classifier for 4 classes: silence, speech, music, other sounds.
# Output has start-time, label, prediction confidence.
# From Giannakopoulos; requires pyAudioAnalysis.
# Requires portaudio and pyAudio. Unfortunately, only real-time recording mode!
# https://github.com/tyiannak/paura
cd /opt
git clone https://github.com/tyiannak/paura
chmod -R 777 /opt/paura
cd /opt/paura


# python_speech_features: common speech features for ASR (MIT license)
# Including MFCC and filterbank energies and spectral centroids, but that's it.
# From James Lyons. Used by DeepSpeech2. Output is NumPy array.
# https://github.com/jameslyons/python_speech_features
python -m pip install --user --upgrade python_speech_features
# Since I may want a closer look
cd /opt
git clone https://github.com/jameslyons/python_speech_features
chmod -R 777 /opt/python_speech_features
cd /opt/python_speech_features
sudo python /opt/python_speech_features/setup.py develop


# FFTW: Fastest Fourier Transform in the West
# Widely used FFT code in C from MIT,
# but under a GNU GPL v.2 that restricts commercial use ($7500-$12500 fee).
# Frigo M, Johnson SG. 1998. FFTW: an adaptive software architecture for the FFT. Proc ICASSP. IEEE. vol. 3: 1381-4.
# https://www.fftw.org
sudo apt-get install libfftw3-dev           # FFTW3


# FFTS: Fastest Fourier Transform in the South [open license but not specified].
# Basic, fully-open-source FFT library in C from A. Blake at Univ. Waikato, New Zealand.
# Blake AM, Witten IH, Cree MJ. 2013. The Fastest Fourier Transform in the South. IEEE Trans Signal Process. 61(19): 4707-16.
# https://github.com/anthonix/ffts
cd /opt
git clone https://github.com/anthonix/ffts
chmod -R 777 /opt/ffts
cd /opt/ffts
# cmake -DCMAKE_INSTALL_PREFIX=/opt/ffts
cmake -DCMAKE_INSTALL_PREFIX=/usr/local
make all
sudo make install
sudo chmod -R 777 /usr/local/include/ffts


# KISS FFT: Keep-it-simple-stupid FFT library [BSD license]
# Basic, fully-open-source FFT library in C from M. Borgerding.
# For real-valued input, only even-length nfft supported.
# Has fast filter and fast convolution by overlap-scrap mathod.
# Will soon be available by sudo apt-get, along with command-line tools.
# https://github.com/mborgerding/kissfft
cd /opt
git clone https://github.com/mborgerding/kissfft
chmod -R 777 /opt/kissfft
cd /opt/kissfft
cmake -DCMAKE_INSTALL_PREFIX=/opt/kiss
make all
sudo make install
sudo chmod -R 777 /opt/kissfft


# NFFT library: Nonequispaced fast Fourier transform (or nonuniform fast Fourier transform, NUFFT) library in C.
# Under the GNU GPL, v. 2, and: "The NFFT depends on the FFTW library, ..."
# Most widely-used library for NFFT, also has Matlab, Python, etc. bindings.
# Keiner J, Kunis S, Potts D. 2009. Using NFFT 3 -- a software library for various nonequispaced fast Fourier transforms. ACM Trans Math Softw. 36(4): 1-30.
# https://www-user.tu-chemnitz.de/~potts/nfft
# https://github.com/NFFT/nfft
sudo apt-get install libnfft3-dev               # NFFT library




# Yaffe: audio features extraction toolbox in C++ (uses Eigen), with Python and Matlab bindings
# From Telecom Paristech/AAO [GPL v3 license].
# Has usual features (AC, LPC, LSF, MFCC, ZCR, energy, envelope)
# Has features mostly related to music processing (AM tremelo vs. grain description, spectral shape features, etc.).
# The best/most-unique are those based on Peeters [2004] (loudness, perceptual sharpness and spread, spectral decrease, slope, etc.).
# Peeters G. (2004). A large set of audio features for sound description (similarity and classification) in the CUIDADO project.
# Mathieu B, ..., Richard G. 2010. YAAFE, an easy to use and efficient audio feature extraction software. Proc ISMIR Conf.
# http://yaafe.sourceforge.net


# CLAM: C++ Library for Audio and Music [GPL].
# Includes Mucis Annotator. Docs show lots of Xwin screen shots, but not a usual function reference.
# Includes Chordata, "a simple but powerful application that analyses the chords... insightful visualizations of the tonal features of the song".
# Won ACM multimedia open-source award in 2006.
# "a full-fledged software framework for research and application development in the Audio and Music Domain.
# It offers a conceptual model as well as tools..."
# So, overall, sounds great for GUI exploration of music, but not for use in one's own pipelines.
# http://clam-project.org


# aubio: audio library in C, with Python interface also written in C [GPL].
# Can be installed with no dependencies [!], so may be good check of low-level coding and Python/C interface.
# "...a tool designed for the extraction of annotations from audio signals. Its features include segmenting a sound file
# before each of its attacks, performing pitch detection, tapping the beat and producing midi streams from live audio."
# New version has aubio python command-line tool to process sound files.
# The Linux command-line tool aubio is awesome for onset and pitch! Super-fast, super easy-to-use! Has:
# onset (with settings and different methods like spectral flux)
# pitch (with settings and different methods like yin, mcomb, schmitt)
# mfcc, beat, tempo, notes (but few settings for these).
# https://aubio.org
sudo apt-get -y install libaubio-dev libaubio-doc aubio-tools   # aubio
sudo apt-get -y install python3-aubio                           # aubio for Python


# SRVK: Speech Recognition Virtual Kitchen
# "Virtual machines and containers for automatic speech recognition research, development, and education"
# http://speech-kitchen.org
# https://github.com/srvk
mkdir -m 777 /opt/srvk
# To-Combo-SAD: Matlab toolbox for speech activity detection.
# Sadjadi SO, Hansen JHL. (2013). Unsupervised speech activity detection using voicing measures and perceptual spectral flux. IEEE Signal Process Lett. 20(3): 197-200.
# Ziaei A, ..., Hansen JHL. (2014). Speech activity detection for NASA Apollo space missions: challenges and solutions. Proc Interspeech. ISCA: paper 994.
# https://github.com/srvk/To-Combo-SAD
cd /opt/srvk
git clone https://github.com/srvk/To-Combo-SAD
chmod -R 777 /opt/srvk/To-Combo-SAD
# Unfortunately, this requires Matlab virtual runtime folder,
# so only usable via DiViMe (ACLEW Diarization Virtual Machine),
# which is a "mini-computer that gets set up inside your computer".


# Librosa: most-used/-useful python audio library, meant for music processing [ISC license]
# https://librosa.github.io/librosa
python -m pip install --user --upgrade librosa      # librosa


# LADSPA plugins: Linux Audio Developer's Simple Plugin API
# http://www.ladspa.org
sudo apt-get -y install ladspa-sdk                  # LADSPA SDK
sudo apt-get -y install ladspalist                  # List LADSPA plugins
sudo apt-get -y install csladspa                    # LADSPA plugin for Csound
wget http://www.ladspa.org/download/ladspa_sdk_1.15.tgz -P /opt
tar -xzf /opt/ladspa_sdk_1.15.tgz -C /opt
rm /opt/ladspa_sdk_1.15.tgz
mv /opt/ladspa_sdk_1.15 /opt/ladspa_sdk
chmod -R 777 /opt/ladspa_sdk
cd /opt/ladspa_sdk
# I decided to abandon at this point...


# Sonic Visualiser: visualisation, analysis, and annotation of music audio recordings
# Recommended by openSMILE.
# https://www.sonicvisualiser.org
sudo apt-get -y install sonic-visualiser            # Sonic Visualiser


# ESPS: Entropic Speech Processing Software.
# Widely-used in the 1990s, from Oxford Phonetics Lab.
# Entropic was bought by Microsoft, but source code still available via WaveSurfer.
# Lots of C source code!
# http://www.speech.kth.se/wavesurfer
wget http://www.speech.kth.se/esps/esps.zip -P /opt
unzip -q /opt/esps.zip -d /opt
chmod -R 777 /opt/ESPS


# WaveSurfer: "...open source tool for sound visualization and manipulation.
# Typical applications are speech/sound analysis and sound annotation/transcription.
# WaveSurfer may be extended by plug-ins as well as embedded in other applications."
# Minimal dependencies.
# http://www.speech.kth.se/wavesurfer
sudo apt-get install wavesurfer                     # WaveSurfer


# OpenMAX: Open Media Acceleration (sometimes "OMX") from Khronos group
# Royalty-free API that provides comprehensive streaming media codec and application portability
# https://www.khronos.org/openmax
# (Not on Ubuntu, I don't think.)


# Setup Xfce desktop environment
# sudo apt update && sudo apt -y upgrade
# sudo apt-get -y install xfce4 xfce4-terminal
# Couldn't get this working...


# Sound packages for R: sound, audio, tuneR, seewave, [soundgen], phonTools, warbleR
# Install these in an R session with install.packages(c("sound","audio","tuneR","seewave","phonTools","warbleR"));


# torch audio
# https://pytorch.org/audio
# https://github.com/pytorch/audio
# Do this in setup7 after install PyTorch
# python -m pip install --user torchaudio -f https://download.pytorch.org/whl/torch_stable.html


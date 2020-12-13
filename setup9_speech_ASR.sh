#!/bin/bash
#@author Erik Edwards
#@date 2018-2020
#
#This script installs Linux utilities for speech processing, speech synthesis,
#ASR (automatic speech recognition), and some language model (LM) tools only used with Kaldi.
#
#For each tool, I provide references and/or the main website.


#Speex (needed by Kaldi, even though already sudo apt-get installed)
#Valin J-M. 2007. The Speex codex manual: version 1.2 beta 3. xiph.org.
#https://www.speex.org
cd /opt
wget http://downloads.xiph.org/releases/speex/speex-1.2rc1.tar.gz
tar -xzf /opt/speex-1.2rc1.tar.gz
chmod -R 777 /opt/speex-1.2rc1
cd /opt/speex-1.2rc1
./configure --prefix=/opt/speex-1.2rc1/build
make
sudo make install
sudo chmod -R 777 /opt/speex-1.2rc1


#Kaldi: Part I
#First add to your .bashrc script:
#nvidia-smi -c 3
#nvidia-smi -c 1
#kaldir=/opt/kaldi
cd /opt
git clone https://github.com/kaldi-asr/kaldi.git kaldi --origin upstream
chmod -R 777 "$kaldir"
cd "$kaldir"/tools
ln -s /opt/speex-1.2rc1/build speex
"$kaldir"/tools/extras/check_dependencies.sh
#This should end with 'OK'


#IRSTLM (GNU LGPL licence)
#Basic install fails (with err msg compatible with: requires older version of gcc).
#So, after download Kaldi (but not install), do:
kaldir=/opt/kaldi
cd /opt
git clone https://github.com/irstlm-team/irstlm
chmod -R 777 /opt/irstlm
cd /opt/irstlm
sed 's|AM_CONFIG_HEADER|AC_CONFIG_HEADERS|' < configure.in > configure.ac
patch -p1 < "$kaldir"/tools/extras/irstlm.patch
./regenerate-makefiles.sh || ./regenerate-makefiles.sh
./configure --prefix '/opt/irstlm'
make
sudo make install
chmod -R 777 /opt/irstlm
[ -f "$kaldir"/tools/extras/env.sh ] || echo -n > "$kaldir"/tools/extras/env.sh
echo "export IRSTLM=$tooldir/irstlm" >> "$kaldir"/tools/extras/env.sh
echo "export PATH=\${PATH}:\${IRSTLM}/bin" >> "$kaldir"/tools/extras/env.sh
chmod 777 "$kaldir"/tools/extras/env.sh


#SRILM
#First fill out form at: http://www.speech.sri.com/projects/srilm/download.html
#mkdir -m 777 /opt/srilm
#mv ~/Downloads/srilm-1.7.2.tar.gz /opt/srilm
cd /opt/srilm
tar -xzf /opt/srilm/srilm-1.7.2.tar.gz
sed -i 's|# SRILM = .*|SRILM = /opt/srilm|' /opt/srilm/Makefile
mtype=$(/opt/srilm/sbin/machine-type)
echo "HAVE_LIBLBFGS=1" >> /opt/srilm/common/Makefile.machine."$mtype"
grep 'ADDITIONAL_INCLUDES' /opt/srilm/common/Makefile.machine."$mtype" |
sed 's|$| -I$(SRILM)/../liblbfgs-1.10/include|' >> /opt/srilm/common/Makefile.machine."$mtype"
grep 'ADDITIONAL_LDFLAGS' /opt/srilm/common/Makefile.machine.$mtype |
sed 's|$| -L$(SRILM)/../liblbfgs-1.10/lib/ -Wl,-rpath -Wl,$(SRILM)/../liblbfgs-1.10/lib/|' \
>> /opt/srilm/common/Makefile.machine."$mtype"
make
echo "export SRILM=$tooldir/srilm" >> "$kaldir"/tools/extras/env.sh
dirs="\${PATH}"
for dir in $(find bin -type d)
do dirs="$dirs:\${SRILM}/$dir"
done
echo "export PATH=$dirs" >> "$kaldir"/tools/extras/env.sh


#pocolm: from Dan Povey,
#"Small language toolkit for creation, interpolation and pruning of ARPA language models."
#Has recipes for swbd and fisher and tedlium!
#The motivation.md is very good:
#"Pocolm exists to make it possible to create better interpolated and pruned ARPA-type language models 
#(i.e. better than from standard toolkits like SRILM and KenLM)."
#The Scenario:
#"The scenario that this toolkit is based on is that you have a small amount of development data in a "target domain",
#and you have several data sources that might be more or less relevant to the "target domain".
#You also have decided on a word list. You provide the training sources, the dev data and the word list;
#Pocolm handles the language model building, interpolation and pruning, and spits out an ARPA format language model at the end."
#So this is really worth trying!
#https://github.com/danpovey/pocolm
cd /opt
git clone https://github.com/danpovey/pocolm
chmod -R 777 /opt/pocolm
cd /opt/pocolm
make


#Kaldi: Part II
#I couldn't get this working with openfst-1.7.3 (I tried various compiler combinations)
cd "$kaldir"/tools
#sed -i 's|OPENFST_VERSION ?= 1.6.7|OPENFST_VERSION ?= 1.7.3|' "$kaldir"/tools/Makefile
make -j 8
cd "$kaldir"/src
sudo apt-get install gcc-6 g++-6
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 100
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-6 100
./configure --shared --static \
			--static-math --mathlib=MKL --mkl-root="/opt/intel/mkl" \
			--use-cuda --cudatk-dir="/usr/local/cuda" \
			--speex-root="/opt/speex-1.2rc1/build"
			#--static-fst --fst-root="/usr/local" --fst-version="1.7.3" \
make -j clean depend 
make -j 8
sudo chmod -R 777 "$kaldir"
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 100
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 100


#Kaldi_LM
#This is used by the fisher recipe
cd "$kaldir"/tools
wget http://www.danielpovey.com/files/kaldi/kaldi_lm.tar.gz
tar -xvzf "$kaldir"/tools/kaldi_lm.tar.gz
rm "$kaldir"/tools/kaldi_lm.tar.gz
cd "$kaldir"/tools/kaldi_lm
make
chmod -R 777 "$kaldir"/tools/kaldi_lm


#Phonetisaurus G2P (BSD 3-Clause license)
#This fails by several errors; tried to resolve, couldn't
#echo 'export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib:/usr/local/lib/fst' >> ~/.bashrc
#source ~/.bashrc
#sudo apt-get install gcc-5 g++-5
#sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 100
#sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 100
cd /opt
git clone https://github.com/AdolfVonKleist/Phonetisaurus.git
chmod -R 777 /opt/Phonetisaurus
cd Phonetisaurus
./configure
make
sudo make install
chmod -R 777 /opt/Phonetisaurus


#Sequitur G2P: data-driven g2p from Aachen (GNU Public License)
#Bisani M, Ney H (2008). Joint-sequence models for grapheme-to-phoneme conversion. Speech Commun. 50(5): 434-51.
#https://www-i6.informatik.rwth-aachen.de/web/Software/g2p.html
wget https://www-i6.informatik.rwth-aachen.de/web/Software/g2p-r1668-r3.tar.gz -P /opt
tar -xvzf /opt/g2p-r1668-r3.tar.gz -C /opt
rm /opt/g2p-r1668-r3.tar.gz
chmod -R 777 /opt/g2p
cd /opt/g2p
#export PYTHONPATH=/usr/local/lib/python2.7/site-packages
#python setup.py install --prefix /usr/local
sudo python setup.py install
sudo chmod -R 777 /opt/g2p


#Montreal Forced Aligner (MFA)
#https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
#https://montreal-forced-aligner.readthedocs.io
wget https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner/releases/download/v1.0.1/montreal-forced-aligner_linux.tar.gz -P /opt
tar -xzf /opt/montreal-forced-aligner_linux.tar.gz -C /opt
rm /opt/montreal-forced-aligner_linux.tar.gz
chmod -R 777 /opt/montreal-forced-aligner
cd /opt/montreal-forced-aligner
ln -s /opt/montreal-forced-aligner/lib/libpython3.6m.so.1.0 /opt/montreal-forced-aligner/lib/libpython3.6m.so
#Test:
/opt/montreal-forced-aligner/mfa_align
/opt/montreal-forced-aligner/mfa_train_and_align


#openSMILE: new, but already widely used, toolkit (code in C++) for audio and speech feature extraction
#Eyben F, Wollmer M, Schuller BW. 2010. OpenSMILE – the Munich versatile and fast open-source audio feature extractor. Int Conf MM. ACM: 1459-1462.
#Eyben F, Weninger F, Gross F, Schuller BW. 2013. Recent developments in openSMILE, the Munich open-source multimedia feature extractor. Int Conf MM. ACM: 835-838.
#Schuller BW, Batliner A. 2013. Computational paralinguistics: emotion, affect and personality in speech and language processing. Chichester: Wiley.
#Eyben F. 2016. Real-time speech and music classification by large audio feature space extraction. Cham: Springer.
#Eyben F, Weninger F, Wollmer M, Schuller BW. 2016. openSMILE:), by audEERING; open-source media interpretation by large feature-space extraction. Gilching: audEERING GmbH.
#https://www.audeering.com/technology/opensmile
#Go to above URL and click large green "Download" button, and place in /opt
unzip -d /opt /opt/opensmile-2.3.0.zip
rm /opt/opensmile-2.3.0.zip
mv /opt/opensmile-2.3.0 /opt/opensmile
chmod -R 777 /opt/opensmile
cd /opt/opensmile
sed -i '117s/(char)/(unsigned char)/g' src/include/core/vectorTransform.hpp
#bash buildStandalone.sh -o /usr/include/opencv2		#main install (the path is to openCV installation)
bash buildStandalone.sh
#Now add /opt/opensmile/inst/bin to your search path:
cd
vim .bashrc
#At bottom add PATH="$PATH:/opt/opensmile/inst/bin"
#To test type:
SMILExtract -h										#help for main program (ignore "libdc1394 error"; it is from openCV and occurs in Python too)


#OSU PNL: Ohio St. Univ. Perception and Neurodynamics Lab, Matlab and C code
#There are lots of separate scripts, usually bio-inspired, related to CASA.
#For now, I get the MRCG (multi-resolution cochleagram) features [Chen et al. 2014].
#TO GET LATER: tandem pitch estimation, SNR estimator, GFCC features, 
#http://web.cse.ohio-state.edu/pnl/software.html
mkdir -m 777 /opt/osu_pnl
cd /opt/osu_pnl
wget http://web.cse.ohio-state.edu/pnl/shareware/chenj-taslp14/MRCG_features.zip -P /opt/osu_pnl
unzip -d /opt/osu_pnl /opt/osu_pnl/MRCG_features.zip
wget http://web.cse.ohio-state.edu/pnl/shareware/chenj-taslp14/README.pdf -P /opt/osu_pnl/MRCG_features
chmod -R 777 /opt/osu_pnl/MRCG_features
mkdir -m 777 /opt/osu_pnl/voiced06  #Voiced speech segregation (but build of C++ code not specified, not clear)
wget http://web.cse.ohio-state.edu/pnl/shareware/hu-chapter06/voiced06.zip -P /opt/osu_pnl
unzip /opt/osu_pnl/voiced06.zip -d /opt/osu_pnl/voiced06
chmod -R 777 /opt/osu_pnl/voiced06
rm /opt/osu_pnl/*.zip


#The Cacophony Project: New Zealand bird project with several repos and datasets (e.g. noises on smartphone!):
#https://cacophony.org.nz
#https://github.com/TheCacophonyProject
#Has sophisticated VAD module [Kim and Hahn 2018] under GPL:
#https://github.com/TheCacophonyProject/VAD
#that also fixes the Octave compatibility issues for the above MRCG features.
#The MRCG features work fine (Matlab only), but the VAD does not!
#(VAD relies on tensorflow.contrib and a host of associated libraries not found.)
mkdir -m 777 /opt/cacophony
cd /opt/cacophony
git clone https://github.com/TheCacophonyProject/VAD
chmod -R 777 /opt/cacophony/VAD


#VOICEBOX: Speech processing toolbox for MATLAB by Mike Brookes, Imperial College [GPL].
#Has usual features, etc. Has spectral-subtraction speech enhancement with noise estimation!
#Has vector quantization! Can use LGB algorithm, K-means, or K-harmonic means.
#Also some TTS, several pitch trackers, GMMs, etc.!
#Has excellent VAD [Sohn et al. 1999; Martin 2001].
#http://www.ee.ic.ac.uk/hp/staff/dmb/voicebox/voicebox.html
#https://github.com/ImperialCollegeLondon/sap-voicebox
cd /opt
git clone https://github.com/ImperialCollegeLondon/sap-voicebox
chmod -R 777 /opt/sap-voicebox
cd /opt/sap-voicebox


#rVAD: noise-robust VAD in Matlab and Python. Excellent work! From Aalborg Univ., Denmark. 
#"The method consists of two passes of denoising followed by a voice activity detection (VAD) stage. ...
#In the second pass, the speech signal is denoised by a speech enhancement method, for which several methods are explored. ...In the end,
#a posteriori SNR weighted energy difference is applied to the extended pitch segments of the denoised speech signal for detecting voice activity."
#"The method performs well on NIST OpenSAD Challenge [Kinnunen et al. 2016]."
#The speech enhancement uses VOICEBOX.
#They obtain their reference VAD from forced alignments from the Aurora 2 database.
#Tan Z-H, Lindberg B. (2010). Low-complexity variable frame rate analysis for speech recognition and voice activity detection. IEEE J Sel Top Signal Process. 4(5): 798-807.
#Tan Z-H, Dehak N. (2020). rVAD: an unsupervised segment-based robust voice activity detection method. Comput Speech Lang. 59: 1-21.
#http://kom.aau.dk/~zt/online/rVAD
wget http://kom.aau.dk/~zt/online/rVAD/rVAD2.0.zip -P /opt
unzip /opt/rVAD2.0.zip -d /opt
rm /opt/rVAD2.0.zip
chmod -R 777 /opt/rVAD2.0
mv /opt/rVAD2.0 /opt/rVAD
sed -i 's|”|"|g' /opt/rVAD/vad.m
#Make version vad_seg.m that outputs vad_seg to stdout
#I also add a first line with 0 nframes_tot so that is always known
n1=$(grep -n '^nfr10=.*$' /opt/rVAD/vad.m | cut -d: -f1);
head -n"$n1" /opt/rVAD/vad.m > /opt/rVAD/vad_seg.m
echo 'printf("0 %d\n",nfr10);' >> /opt/rVAD/vad_seg.m
n2=$(grep -n 'snre_vad' /opt/rVAD/vad.m | cut -d: -f1);
head -n"$n2" /opt/rVAD/vad.m |
tail -n+"$((n1+1))" >> /opt/rVAD/vad_seg.m
echo 'for r=1:size(vad_seg,1), printf("%d %d\n",vad_seg(r,1),vad_seg(r,2)); end' >> /opt/rVAD/vad_seg.m
#Also a similar Python version (but only uses flatness and not working with samp err)
wget http://kom.aau.dk/~zt/online/rVAD/rVADfast_py_2.0.zip -P /opt/rVAD
unzip /opt/rVAD/rVADfast_py_2.0.zip -d /opt/rVAD
rm /opt/rVAD/rVADfast_py_2.0.zip
mv /opt/rVAD/rVADfast_py_2.0 /opt/rVAD/rVADfast_py
#Also a GMM-UBM method
wget http://kom.aau.dk/~zt/online/rVAD/GMM-UBM_MAP_SV_Python.zip -P /opt/rVAD
unzip /opt/rVAD/GMM-UBM_MAP_SV_Python.zip -d /opt/rVAD
rm /opt/rVAD/GMM-UBM_MAP_SV_Python.zip
mv /opt/rVAD/GMM-UBM_MAP_SV_Python /opt/rVAD/GMM-UBM_MAP_SV
chmod -R 777 /opt/rVAD


#inaSpeechSegmenter: speech segmentation in Python based on TF from INA (Institut National de l'Audiovisuel) [MIT license]
#Won MIREX 2018 speech detection challenge!
#Gives command-line ina_speech_segmenter.py script, looks super-easy to use!
#Uses CNN for frame-level probabilities, then HMM.
#vad_engine splits signal into speech, music, noise. detect_gender also outputs m/f for speech segments.
#Install instructions use virtual env, but I do here without.
#Doukhan D et al. (2018). An open-source speaker gender detection framework for monitoring gender equality. ICASSP. IEEE: 5214-8.
#Doukhan D et al. (2018). INA's' MIREX 2018 music and speech detection system. MIREX
#https://github.com/ina-foss/inaSpeechSegmenter
python -m pip install --user inaSpeechSegmenter
#To test:
ina_speech_segmenter.py --help


#Pyannote: Python annotation tool and multimedia content processing (video) [MIT license].
#Excellent work. Python 3, meant for Linux or Mac. Based on PyTorch. Pretrained models.
#https://github.com/pyannote
#First install pyannote-core project [Bredin et al. 2017]:
#"advanced data structures for handling and visualizing temporal segments with attached labels"
#https://github.com/pyannote/pyannote-core
python -m pip install --user pyannote.core
#Then install pyannote-metrics subproject [Bredin et al. 2017]:
#"A toolkit for reproducible evaluation, diagnostic, and error analysis of speaker diarization systems"
#https://github.com/pyannote/pyannote-metrics
python -m pip install --user pyannote.metrics
#Then get audio subproject [Bredin et al. 2020]:
#"Neural building blocks for speaker diarization: speech activity detection, speaker change detection, speaker embedding"
#https://github.com/pyannote/pyannote-audio
cd /opt
git clone https://github.com/pyannote/pyannote-audio.git
chmod -R 777 /opt/pyannote-audio
cd /opt/pyannote-audio
git checkout develop
python -m pip install --user .


#fastDTW: Python implementation of FastDTW [Salvador and Chan 2007],
#an optimal or near-optimal Dynamic Time Warping algorithm [MIT license].
#https://github.com/slaypni/fastdtw
python -m pip install --user fastdtw


#gnuspeech
#See Speech_Synthesis/Software_Toolkits
#https://www.gnu.org/software/gnuspeech


#NIST Tools (Natl Inst Standards & Technology)
#This is a whole set of tools for basic scoring, evaluation, etc. for various speech-related things.
#Some of these are super-useful and even essential for publishing research.
#I don't get all of them here, just the ones that seem useful in near future. See website for more.
#https://www.nist.gov/itl/iad/mig/tools
[ -d /opt/NIST ] || mkdir -m 777 /opt/NIST

#First, some Perl modules are required:
sudo apt-get install libperl4-corelibs-perl
cpan Perl5::CoreLibs                    #https://metacpan.org/pod/Perl4::CoreLibs
cpan Sort::Naturally                    #https://metacpan.org/pod/Sort::Naturally
cpan String::Util                       #https://metacpan.org/pod/String::Util
cpan Text::CSV                          #https://metacpan.org/pod/Text::CSV
cpan Text::CSV_XS                       #https://metacpan.org/pod/Text::CSV_XS
cpan Math::Random::OO::Uniform          #https://metacpan.org/pod/Math::Random::OO::Uniform
cpan Math::Random::OO::Normal           #https://metacpan.org/pod/Math::Random::OO::Normal
cpan Statistics::Descriptive            #https://metacpan.org/pod/Statistics::Descriptive
cpan Statistics::Descriptive::Discrete  #https://metacpan.org/pod/Statistics::Descriptive::Discrete
cpan Statistics::Distributions          #https://metacpan.org/pod/Statistics::Distributions
cpan DBI                                #https://metacpan.org/pod/DBI
cpan DBD::SQLite                        #https://metacpan.org/pod/DBD::SQLite
cpan File::Monitor                      #https://metacpan.org/pod/File::Monitor
cpan File::Monitor::Object              #https://metacpan.org/pod/File::Monitor::Object
cpan Digest::SHA                        #https://metacpan.org/pod/Digest::SHA
cpan YAML                               #https://metacpan.org/pod/YAML
cpan Data::Dump                         #https://metacpan.org/pod/Data::Dump
cpan Data::Dumper                       #https://metacpan.org/pod/Data::Dumper

#F4DE: Framework For Detection Evaluations
#Includes CLEAR, TRECVid Event Detection, and AVSS Multi-Camera Person Tracking evaluation tools.
#F4DE consists of a set of Perl scripts that can be run under a shell terminal.
wget https://github.com/usnistgov/F4DE/archive/3.5.0.tar.gz -P /opt/NIST
tar -xzf /opt/NIST/3.5.0.tar.gz -C /opt/NIST
mv /opt/NIST/F4DE-3.5.0 /opt/NIST/F4DE
mv /opt/NIST/3.5.0.tar.gz /opt/NIST/F4DE
make perl_install
#These do not require install if run from their directory

#mteval: scoring script for machine translation evaluation, v14c
#Gives script mteval-v14c.pl that computes BLEU score or NIST score for ref vs. hyp documents
#Has options for case-sensitivity, non-ASCII chars, internationalization, and smoothing.
wget https://www.nist.gov/document/mteval-v14c-20190801targz -P /opt/NIST
tar -xzf /opt/NIST/mteval-v14c-20190801targz -C /opt/NIST
rm /opt/NIST/mteval-v14c-20190801targz
mv /opt/NIST/mteval* /opt/NIST/mteval

#SCTK: NIST Scoring Toolkit (including sclite, ROVER, etc.)
#https://github.com/usnistgov/SCTK
#Includes:
#sclite V2.10   - "Score Lite",
#sc_stats V1.3  - sclite's Statistical Significance Comparison tool
#rover V0.1     - Recognition Output Voting Error Reduction
#asclite V1.11  - Multidimensional alignment replacement for sclite
cd /opt/NIST
git clone https://github.com/usnistgov/SCTK
chmod -R 777 /opt/NIST/SCTK
cd /opt/NIST/SCTK
make config
make all
make check
make install
make doc

#STDEval: Spoken Term Detection Evaluation Toolkit
#Includes STDEval, DETUtil and ProcGraph
#The tools are to be run from the base directory with the command:
# perl -I /opt/NIST/STDEval/src /opt/NIST/STDEval/src/STDEval.pl ....options....
wget ftp://jaguar.ncsl.nist.gov/pub/STDEval-0.6-20061122-1108.tgz -P /opt/NIST
tar -xzf /opt/NIST/STDEval-0.6-20061122-1108.tgz -C /opt/NIST
mv /opt/NIST/STDEval-0.6 /opt/NIST/STDEval
mv /opt/NIST/STDEval-0.6-20061122-1108.tgz /opt/NIST/STDEval
#I think not working yet

#SCORE: Speech Recognition Scoring Package
#See: /opt/NIST/SCORE/doc/score.rdm for usage
#Interesting historical note for naming ASR files:
#"
#The hypothesis sentence file must use the sentence format which was specified
#in the October '89 DARPA Resource Management Benchmark Speech Recognition Tests.
#All hypothesis words and sentences must be in SNOR format.
#Each hypothesis sentence is followed by a unique utterance identifier consisting of the
#tspeaker identifier combined with the sentence identifier and has the following format:
# (<SPEAKER-ID>-<SENTENCE-ID>)
#"
wget https://www.nist.gov/document/score3-6-2tgz -P /opt/NIST
tar -xzf /opt/NIST/score3-6-2tgz -C /opt/NIST
rm /opt/NIST/score3-6-2tgz
mv /opt/NIST/nist /opt/NIST/SCORE
cd /opt/NIST/SCORE
/opt/NIST/SCORE/src/scripts/install.sh  #choose 6

#DETware: DET-Curve Plotting software for use with gnuplot
#Detection Error Tradeoff Curve is an alternative to ROC for binary classification (detection) tasks
#But hard to use -- lots of shell script preprocessing required (see readme)
wget https://www.nist.gov/document/gnudetwaretgz -P /opt/NIST
tar -xzf /opt/NIST/gnudetwaretgz -C /opt/NIST
rm /opt/NIST/gnudetwaretgz

#IEEEval: 1998 Information Extraction - Named Entity (IE-NE) Scoring
#Perhaps do later

#tranfilt: a set of ASR transcription filtering scripts.
#These scripts are used with SCTK to score the NIST speech recognition evaluations.
#Transcription pre-filter scripts for ARPA CSR (continuous speech recognition) tests.
#Usage: csrfilt.sh global-map-file utterance-map-file < filein > fileout
#option '-dh' can be added to delete hyphens from all hyphenated words.
wget ftp://jaguar.ncsl.nist.gov/pub/tranfilt-1.14.tgz -P /opt/NIST
tar -xzf /opt/NIST/tranfilt-1.14.tgz -C /opt/NIST
mv /opt/NIST/tranfilt-1.14 /opt/NIST/tranfilt
mv /opt/NIST/tranfilt-1.14.tgz /opt/NIST/tranfilt
cd /opt/NIST/tranfilt
make
make test

#seg_scr: generic time-based segmentation scorer with examples.
#Developed for the 2000 NIST speaker recognition evaluation.
#Easy to use Perl script:
#/opt/NIST/seg_scr/seg_scoring.v2.1.pl -i IndexFile.txt -c .2 -b .25
#where IndexFile.txt is a list of hyp and ref files (see readme)
#-c gives the collar
#-b gives the buffer
#(combine contiguous segments of the same state that are less then .25 s apart)
wget https://www.nist.gov/document/segscr-v21tgz -P /opt/NIST
tar -xzf /opt/NIST/segscr-v21tgz -C /opt/NIST
rm /opt/NIST/segscr-v21tgz
mv /opt/NIST/seg_scr.v21 /opt/NIST/seg_scr

#TDT3eval: evaluation script suite for the TDT (topic detection and tracking)
wget https://www.nist.gov/document/tdt3evalv2-6-20041022-1037tgz -P /opt/NIST
tar -xzf /opt/NIST/tdt3evalv2-6-20041022-1037tgz -C /opt/NIST
rm /opt/NIST/tdt3evalv2-6-20041022-1037tgz
mv /opt/NIST/TDT3eval_v2.6 /opt/NIST/TDT3eval
#Actually, very hard to install (requires obscure dependencies)

#SPHERE: Speech File Manipulation Software
wget ftp://jaguar.ncsl.nist.gov/pub/sphere-2.7-20120312-1513.tar.bz2 -P /opt/NIST
bzip2 -dc /opt/NIST/sphere-2.7-20120312-1513.tar.bz2 |
tar xvf - -C /opt/NIST
rm /opt/NIST/sphere-2.7-20120312-1513.tar.bz2
mv /opt/NIST/nist /opt/NIST/sphere
/opt/NIST/sphere/src/scripts/install.sh
#This requires choice of system, and then fails...

#SPQA: Speech Quality Assurance (SPQA) Package
#Also includes SPHERE v2.5.
wget https://www.nist.gov/document/spqa2-3-sphere2-5tgz -P /opt/NIST
tar -xvf /opt/NIST/spqa2-3-sphere2-5tgz -C /opt/NIST
rm /opt/NIST/spqa2-3-sphere2-5tgz
mv /opt/NIST/nist /opt/NIST/spqa
cd /opt/NIST/spqa
/opt/NIST/spqa/src/scripts/install.sh
#This requires choice of system, and then fails...

#CMUseg: CMU Acoustic Segmentation Software
#Siegler M, ..., Stern RM. (1997). Acoustic segmentation, classification and clustering of broadcast news audio. Proc Speech Recognition Workshop.
#Includes C source code
wget https://www.nist.gov/document/cmuseg0-5-targz -P /opt/NIST
tar -xvf /opt/NIST/cmuseg0-5-targz -C /opt/NIST
rm /opt/NIST/cmuseg0-5-targz
mv /opt/NIST/CMUseg_0.5 /opt/NIST/CMUseg
cd /opt/NIST/CMUseg
#Installation requires choice of system, and then fails...

#ldistsm: Alignment Distance Split Merge Program to perform phonologically-motivated split/merge alignment of word strings.
#C source code and software to do split/merge alignment of two strings of words (or phones).
wget https://www.nist.gov/document/aldistsm-1-2tgz -P /opt/NIST
tar -xvf /opt/NIST/aldistsm-1-2tgz -C /opt/NIST
rm /opt/NIST/aldistsm-1-2tgz
mv /opt/NIST/aldistsm-1.2/ /opt/NIST/aldistsm
cd /opt/NIST/aldistsm
gcc -lm -o tald3e_sm tald3e_sm_export.c
#Gives program: /opt/NIST/aldistsm/tald3e_sm
#But not easy to use, and not even clear what it does

#tsylb2: Syllabification software from Bill Fisher (1996)
#"This directory contains the source code, documentation, and example/test data for my software to do syllabification.
#The main program, "tsylb2", interactively assigns syllable divisions to a phonetic string typed in by the user.
#All of the functions and data structures are made available here so that you can package it differently if you want to.""
wget https://www.nist.gov/document/tsylb2-1-1tgz -P /opt/NIST
tar -xvf /opt/NIST/tsylb2-1-1tgz -C /opt/NIST
rm /opt/NIST/tsylb2-1-1tgz
mv /opt/NIST/tsylb2-1.1 /opt/NIST/tsylb2
cd /opt/NIST/tsylb2
./configure
make
make check          #fails
sudo make install   #fails

#addttp4: text-to-phone software in ANSI C from Bill Fisher (2000)
#"This directory contains the source code, documentation, and example/test data
#for my software to create Pronlex entries using text-to-phone (TTP) rules.
#The main program, "addttp4" (compiled from "addttp4_export.c"),
#first reads in TTP rule-set and syllabification parameters
#from their files and then reads vocabulary items from stdin,
#writing out corresponding Pronlex entries to stdout."
#Fisher WM (1999). A statistical text-to-phone function using ngrams and rules. Proc IEEE ICASSP. 2: 649-52.
wget https://www.nist.gov/document/addttp4-1-1tgz -P /opt/NIST
tar -xvf /opt/NIST/addttp4-1-1tgz -C /opt/NIST
rm /opt/NIST/addttp4-1-1tgz
mv /opt/NIST/addttp4* /opt/NIST/addttp4
cd /opt/NIST/addttp4
gcc -lm -o addttp4 addttp4_export.c   #fails due to usual getline name conflict

#ATLAS: Architecture and Tools for Linguistic Analysis Systems
#This is itself a large framework (from NIST, LDC, etc.) for making annotation graphs.
#Could be useful for Praat-like annotation tool (e.g. Figure8)

chmod -R 777 /opt/NIST


#PyLangAcq: Language Acquisition Research in Python
#For CHILDES (child speech) and .cha transcription format
#http://pylangacq.org
python -m pip install --user --upgrade pylangacq


#g2p-seq2seq: G2P with Tensorflow from CMUSphinx
#https://github.com/cmusphinx/g2p-seq2seq
cd /opt
git clone https://github.com/cmusphinx/g2p-seq2seq
chmod -R 777 /opt/g2p-seq2seq
cd /opt/g2p-seq2seq
sudo python /opt/g2p-seq2seq/setup.py install
wget -O g2p-seq2seq-cmudict.tar.gz https://sourceforge.net/projects/cmusphinx/files/G2P%20Models/g2p-seq2seq-model-6.2-cmudict-nostress.tar.gz/download
tar xf g2p-seq2seq-cmudict.tar.gz
#Doesn't work! Requires old version of TF, or something


#Eesen: end-to-end speech recognition from CMU using LSTMs, CTC and WFSTs. Can use Tensorflow.
#Has recipes inspired by Kaldi for librispeech, swbd, wsj and tedlium.
#They are clear that CTC does not allow words to have multiple pronunciations [good citation for that],
#and ls_prepare_phoneme_dict.sh from the librispeech recipe keeps only 1 pronunciation from CMUdict.
#The librispeech recipe uses only clean-100.
#The librispeech recipe seems to include data augmentation by VTLN warps 0.8, 1.0, 1.2 and spkrate warps 0.8, 1.0, 1.1.
#Main strength would seem to be for insight to WFST-based decoding (else out of date?).
#Miao Y, Gowayyed M, Metze F. (2015). EESEN: end-to-end speech recognition using deep RNN models and WFST-based decoding. Proc ASRU. IEEE: 167-74.
#https://github.com/srvk/eesen
cd /opt
git clone https://github.com/srvk/eesen
chmod -R 777 /opt/eesen
#cd /opt/eesen/tools
#sed -i 's|^OPENFST_VERSION = 1.4.1|OPENFST_VERSION = 1.5.1|' /opt/eesen/tools/Makefile
#But this reinstalls OpenFST, SCTK, sph2pipe, and ATLAS!
#Skip for now!


#DeepSpeech2: end-to-end ASR from Baidu built on PaddlePaddle platform
#Amodei D, ..., Zhu Z. (2016). Deep Speech 2: end-to-end speech recognition in English and Mandarin. Proc ICML, JMLR vol. 48.
#Excellent on data augmentation (see README.md)
cd /opt
git clone https://github.com/PaddlePaddle/DeepSpeech.git
chmod -R 777 /opt/DeepSpeech
cd /opt/DeepSpeech
sed -i 's|scipy==1.2.1|scipy==1.3.1|; s|resampy==0.1.5|resampy==0.2.2|; s|SoundFile==0.9.0.post1|SoundFile==0.10.3.post1|' /opt/DeepSpeech/requirements.txt
sed -i 's|pip install|python -m pip install --user|g' /opt/DeepSpeech/setup.sh
sudo /opt/DeepSpeech/setup.sh
#Annoying that this requires sudo (and got some pip warning at start of install!), and reinstalls OpenFST 1.6.3
#Doesn't work! Not with python3 nor with python2. Only English example is librispeech.
#However, the conf/augmentation.config.example is useful. Perhaps also data/noise/chime3_background.py.


#wav2letter: end-to-end speech recognition from Facebook.
#https://github.com/facebookresearch/wav2letter/wiki/General-building-instructions
git clone --recursive https://github.com/facebookresearch/wav2letter.git
sudo apt-get update
sudo apt-get install \
    # Audio encoding libs for libsndfile \
    libasound2-dev \
    libflac-dev \
    libogg-dev \
    libtool \
    libvorbis-dev \
    # FFTW for Fourier transforms \
    libfftw3-dev \
    # Compression libraries for KenLM \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libboost-all-dev \
    # gflags \
    libgflags-dev \
    libgflags2v5 \
    # glog \
    libgoogle-glog-dev \
    libgoogle-glog0v5 \
https://github.com/facebookresearch/wav2letter/issues/102
https://github.com/facebookresearch/wav2letter/blob/master/recipes/models/lexicon_free/Dockerfile
export MKLROOT=/opt/intel/mkl # or path to MKL
export KENLM_ROOT_DIR=[path to KenLM]
# in your wav2letter++ directory
mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j4 # (or any number of threads)


#ESPnet: End-to-end Speech Processing toolkit, based on chainer and PyTorch
#End-to-end speech recognition, end-to-end TTS, and voice conversion (VC).
#Also MT and speech translation (said to be superior to cascaded MT/ASR)
#Uses Kaldi for features extraction and has Kaldi-like recipes
#Hybrid CTC/attention based and transducer based end-to-end ASR
#Watanabe S, ..., Hayashi T. (2017). Hybrid CTC/attention architecture for end-to-end speech recognition. IEEE J Sel Top Signal Process. 11(8): 1240-53.
#Watanabe S, ..., Ochiai T. (2018). ESPnet: end-to-end speech processing toolkit. Proc Interspeech. ISCA: 2207-11.
#Hayashi T, ..., Tan X. (2019). ESPnet-TTS: unified, reproducible, and integrated open source end-to-end text-to-speech toolkit. arXiv. 1910.10909.
#https://github.com/espnet/espnet
cd /opt
git clone https://github.com/espnet/espnet
chmod -R 777 /opt/espnet
cd /opt/espnet/tools
make KALDI=/opt/kaldi PYTHON_VERSION=3.6.9 TH_VERSION=1.4.0 CUDA_VERSION=10.1
make check_install


#Espresso: open-source end-to-end ASR toolkit (MIT license) based on Pytorch and fairseq (and Kaldi)
#Bash recipes for LibriSpeech, Switchboard, WSJ. Supports SpecAugment.
#In progress to isolate from fairseq
cd /opt/nvidia/apex
python -m pip install --user -v --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" --global-option="--deprecated_fused_adam" --global-option="--xentropy" --global-option="--fast_multihead_attn" ./
cd /opt
git clone https://github.com/freewym/espresso
chmod -R 777 /opt/espresso
cd /opt/espresso
sudo python -m pip install --user --editable .
python -m pip install --user kaldi_io
python -m pip install --user sentencepiece
cd /opt/espresso/espresso/tools
make KALDI=/opt/kaldi
sed -i 's|:$PWD:|:/usr/lib/python3.6:$PWD:|' /opt/espresso/examples/asr_wsj/path.sh
sed -i 's|:$PWD:|:/usr/lib/python3.6:$PWD:|' /opt/espresso/examples/asr_swbd/path.sh
sed -i 's|:$PWD:|:/usr/lib/python3.6:$PWD:|' /opt/espresso/examples/asr_librispeech/path.sh


#PyTorch-Kaldi Speech Recognition Toolkit (Creative Commons Attribution 4.0 International license)
#"...open-source repository for developing state-of-the-art DNN/HMM speech recognition systems.
#The DNN part is managed by PyTorch, while feature extraction, label computation, and decoding are performed with the Kaldi toolkit."
#Examples for TIMIT, LibriSpeech and DIRHA.
#General procedure is: 1) run Kaldi s5 recipe; 2) compute all alignments; 3) write .cfg file; 4) python run_exp.sh $cfg
#Arbitrary features can be used, as long as input is .ark. Util provided to use raw waveform.
#Utility tune_hyperparameters.py to generate .cfg files for hyperparameter tuning.
#Ravanelli M, Parcollet T, Bengio Y. (2019). The PyTorch-Kaldi speech recognition toolkit. Proc ICASSP. IEEE: 6465-9.
#https://github.com/mravanelli/pytorch-kaldi
cd /opt
git clone https://github.com/mravanelli/pytorch-kaldi
chmod -R 777 /opt/pytorch-kaldi
cd /opt/pytorch-kaldi
python -m pip install --user -r requirements.txt   #should all be already satisfied
#That's it! Works!


#SpeechBrain: the future version of PyTorch-Kaldi coming soon!
#From Mila (Bengio, Montreal). Sponsored by Samsung, NVIDIA, Dolby. Collaboration from Facebook/PyTorch, IBM Research, FluentAI.
#Actively looking for collaborators!


#IDIAP
#acoustic-simulator: "...scripts used to degrade audio files..."
#Includes Python API to the freesound.org service (online audio repository).
#Includes 60 hrs of noise recording from freesound.org.
#Includes 74 device impulse responses and 54 room impulse responses.
#Includes 14 audio codecs for cellular and satellite telephony.
#Includes noise-reduction by Wiener filtering and amplitude normalization.
#Includes degrade-audio-safe-random.py, which: "Degrades a list of audio files under pre-specified
#degradation conditions (landline, cellular, satellite, interview, playback) along with noisy variants."
#https://github.com/idiap/acoustic-simulator
mkdir -pm 777 /opt/idiap
cd /opt/idiap
git clone https://github.com/idiap/acoustic-simulator
chmod -R 777 /opt/idiap/acoustic-simulator

#RawSpeechClassification (GPL3 license)
#"Trains CNN (or any neural network based) classifiers from raw speech using Keras and tests them.
# The inputs are lists of wav files, where each file is labelled.
#It then creates fixed length signals and processes them. During testing, it computes scores
#at the utterance or speaker levels by averaging the corresponding frame-level scores from the fixed length signals."
#https://github.com/idiap/RawSpeechClassification

#LR-CNN
#train low-rank CNNs using Keras/TF, with inputs from Kaldi dirs
#https://github.com/idiap/LR-CNN

#SSP - Speech Signal Processing module (BSD license)
#This is in Python (sister package libssp is in C++)
#Feature extraction, vocoder (coding and synthesis) using LP, pitch extraction using Kalman filter.
#https://github.com/idiap/ssp

#Kaldi-ivector (but this looks like Povey's code from Kaldi?)
#"...standard i-vector extraction procedure.
#It contains code to estimate the T-matrix with the conventional EM algorithm for estimation of Eigenvoice matrices, 
#estimate i-vectors given the T-matrix, features and corresponding posteriors."
#https://github.com/idiap/kaldi-ivector

#iss-dicts:
#ISS scripts for dictionary maintenance (puts into HTK form and uses Phonetisaurus)
#https://github.com/idiap/iss-dicts

#PhonVoc: Phonetic and Phonological vocoding (BSD license)
#https://github.com/idiap/phonvoc


#Audio/speech datasets:
#https://github.com/robmsmt/ASR_Audio_Data_Links
#https://github.com/jim-schwoebel/voice_datasets
#https://www.music-ir.org/mirex/wiki/2018:Music_and/or_Speech_Detection

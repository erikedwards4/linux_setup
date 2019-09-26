#!/bin/bash
#@author Erik Edwards
#@date 2018-2019
#
#This script installs Linux utilities for ASR (automatic speech recognition), IE (information extraction),
#NLP (natural language processing), and machine translation (MT), including neural MT and general sequence-to-sequence.
#
#For each tool, I provide references and/or the main website.


tooldir=/opt				#Each user can change this
mkdir -m 777 "$tooldir"
cd "$tooldir"


## PART III: ASR, NLP AND RELATED ##
echo -e "\nPART III: ASR, NLP AND RELATED \n\n"


#Google Regular Expressions
cd "$tooldir"
git clone https://code.googlesource.com/re2
chmod -R 777 "$tooldir"/re2
cd "$tooldir"/re2
make
make test
sudo make install
make testinstall
chmod -R 777 "$tooldir"/re2


#CMPH (C minimal perfect hashing)
cd "$tooldir"
git clone https://github.com/zvelo/cmph
chmod -R 777 "$tooldir"/cmph
cd cmph
./configure
make
sudo make install
chmod -R 777 "$tooldir"/cmph


#OpenFST
cd "$tooldir"
wget http://www.openfst.org/twiki/pub/FST/FstDownload/openfst-1.7.3.tar.gz
tar -xvf "$tooldir"/openfst-1.7.3.tar.gz
sudo rm *.gz
chmod -R 777 "$tooldir"/openfst-1.7.3
cd "$tooldir"/openfst-1.7.3
./configure --enable-static --enable-shared --enable-far --enable-pdt --enable-mpdt --enable-python
sed -i 's| -std=c++11| -std=c++14|' ./configure  #required for enable-ngram-fsts
./configure --enable-static --enable-shared --enable-far --enable-pdt --enable-mpdt --enable-python --enable-ngram-fsts #needed for OpenGRM
make
sudo make install
chmod -R 777 "$tooldir"/openfst-1.7.3


#OpenGRM
cd "$tooldir"
wget http://www.opengrm.org/twiki/pub/GRM/NGramDownload/ngram-1.3.7.tar.gz
tar -xvf "$tooldir"/ngram-1.3.7.tar.gz
sudo rm *.gz
chmod -R 777 "$tooldir"/ngram-1.3.7.tar.gz
cd "$tooldir"/ngram-1.3.7
./configure
make
sudo make install
chmod -R 777 "$tooldir"/ngram-1.3.7


#Thrax
cd "$tooldir"
wget http://www.opengrm.org/twiki/pub/GRM/ThraxDownload/thrax-1.3.0.tar.gz
tar -xvf "$tooldir"/thrax-1.3.0.tar.gz
sudo rm *.gz
chmod -R 777 "$tooldir"/thrax-1.3.0
cd "$tooldir"/thrax-1.3.0
./configure
make
sudo make install
chmod -R 777 "$tooldir"/thrax-1.3.0


#OpenGrm SFst
cd "$tooldir"
wget http://www.opengrm.org/twiki/pub/GRM/SFstDownload/sfst-1.1.0.tar.gz
tar -xvf "$tooldir"/sfst-1.1.0.tar.gz
sudo rm *.gz
chmod -R 777 "$tooldir"/sfst-1.1.0
cd sfst-1.1.0
./configure
make
sudo make install
chmod -R 777 "$tooldir"/sfst-1.1.0


#OpenGrm Pynini
cd "$tooldir"
wget http://www.opengrm.org/twiki/pub/GRM/PyniniDownload/pynini-2.0.8.tar.gz
tar -xvf "$tooldir"/pynini-2.0.8.tar.gz
sudo rm *.gz
chmod -R 777 "$tooldir"/pynini-2.0.8
cd pynini-2.0.8
sudo python setup.py install
python setup.py test


#KenLM
cd "$tooldir"
wget -O - https://kheafield.com/code/kenlm.tar.gz | tar -xz
chmod -R 777 "$tooldir"/kenlm
cd "$tooldir"/kenlm
mkdir -m 777 build
cd build
cmake ..
make -j2
chmod -R 777 "$tooldir"/kenlm


#MIT LM
cd "$tooldir"
git clone https://github.com/mitlm/mitlm
chmod -R 777 "$tooldir"/mitlm
cd "$tooldir"/mitlm
./autogen.sh
make
sudo make install
chmod -R 777 "$tooldir"/mitlm


#Speex (needed by Kaldi, even though already sudo apt-get installed)
#Valin J-M. 2007. The Speex codex manual: version 1.2 beta 3. xiph.org.
#https://www.speex.org
cd "$tooldir"
wget http://downloads.xiph.org/releases/speex/speex-1.2rc1.tar.gz
tar -xzf "$tooldir"/speex-1.2rc1.tar.gz
chmod -R 777 "$tooldir"/speex-1.2rc1
cd "$tooldir"/speex-1.2rc1
./configure --prefix="$tooldir"/speex-1.2rc1/build
make
sudo make install
sudo chmod -R 777 "$tooldir"/speex-1.2rc1


#Kaldi: Part I
#First add to your .bashrc script:
#nvidia-smi -c 3
#nvidia-smi -c 1
#kaldir=/opt/kaldi
cd "$tooldir"
git clone https://github.com/kaldi-asr/kaldi.git kaldi --origin upstream
chmod -R 777 "$kaldir"
cd "$kaldir"/tools
ln -s "$tooldir"/speex-1.2rc1/build speex
"$kaldir"/tools/extras/check_dependencies.sh
#This should end with 'OK'


#IRSTLM (GNU LGPL licence)
#Basic install fails (with err msg compatible with: requires older version of gcc).
#So, after download Kaldi (but not install), do:
kaldir=/opt/kaldi
cd "$tooldir"
git clone https://github.com/irstlm-team/irstlm
chmod -R 777 "$tooldir"/irstlm
cd "$tooldir"/irstlm
sed 's|AM_CONFIG_HEADER|AC_CONFIG_HEADERS|' < configure.in > configure.ac
patch -p1 < "$kaldir"/tools/extras/irstlm.patch
./regenerate-makefiles.sh || ./regenerate-makefiles.sh
./configure --prefix '/opt/irstlm'
make
sudo make install
chmod -R 777 "$tooldir"/irstlm
[ -f "$kaldir"/tools/extras/env.sh ] || echo -n > "$kaldir"/tools/extras/env.sh
echo "export IRSTLM=$tooldir/irstlm" >> "$kaldir"/tools/extras/env.sh
echo "export PATH=\${PATH}:\${IRSTLM}/bin" >> "$kaldir"/tools/extras/env.sh
chmod 777 "$kaldir"/tools/extras/env.sh


#SRILM
#First fill out form at: http://www.speech.sri.com/projects/srilm/download.html
#mkdir -m 777 "$tooldir"/srilm
#mv ~/Downloads/srilm-1.7.2.tar.gz "$tooldir"/srilm
cd "$tooldir"/srilm
tar -xzf "$tooldir"/srilm/srilm-1.7.2.tar.gz
sed -i 's|# SRILM = .*|SRILM = /opt/srilm|' "$tooldir"/srilm/Makefile
mtype=$("$tooldir"/srilm/sbin/machine-type)
echo "HAVE_LIBLBFGS=1" >> "$tooldir"/srilm/common/Makefile.machine."$mtype"
grep 'ADDITIONAL_INCLUDES' "$tooldir"/srilm/common/Makefile.machine."$mtype" |
sed 's|$| -I$(SRILM)/../liblbfgs-1.10/include|' >> "$tooldir"/srilm/common/Makefile.machine."$mtype"
grep 'ADDITIONAL_LDFLAGS' "$tooldir"/srilm/common/Makefile.machine.$mtype |
sed 's|$| -L$(SRILM)/../liblbfgs-1.10/lib/ -Wl,-rpath -Wl,$(SRILM)/../liblbfgs-1.10/lib/|' \
>> "$tooldir"/srilm/common/Makefile.machine."$mtype"
make
echo "export SRILM=$tooldir/srilm" >> "$kaldir"/tools/extras/env.sh
dirs="\${PATH}"
for dir in $(find bin -type d)
do dirs="$dirs:\${SRILM}/$dir"
done
echo "export PATH=$dirs" >> "$kaldir"/tools/extras/env.sh


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


#Phonetisaurus
#This fails by several errors; tried to resolve, couldn't
#cd "$tooldir"
#git clone https://github.com/AdolfVonKleist/Phonetisaurus.git
#chmod -R 777 "$tooldir"/Phonetisaurus
#mv Phonetisaurus phonetisaurus
#cd phonetisaurus
#./configure
sudo apt-get install gcc-5 g++-5
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 100
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 100
#make
#sudo make install
#chmod -R 777 "$tooldir"/phonetisaurus


#Giza++ (note: they suggest mgiza, which is also avaiilable at Moses)
cd "$tooldir"
git clone https://github.com/moses-smt/giza-pp
chmod -R 777 "$tooldir"/giza-pp
cd giza-pp
make
chmod -R 777 "$tooldir"/giza-pp


#mgiza
cd "$tooldir"
git clone https://github.com/moses-smt/mgiza
chmod -R 777 "$tooldir"/mgiza
cd mgiza/mgizapp
cmake .
make
sudo make install
chmod -R 777 "$tooldir"/mgiza


#Moses
#Requires IRSTLM; skip for now
#cd "$tooldir"
#git clone https://github.com/moses-smt/mosesdecoder.git
#chmod -R 777 "$tooldir"/mosesdecoder
#cd mosesdecoder
#./bjam --with-boost="$tooldir"/boost_1_67_0 --with-cmph="$tooldir"/cmph --no-xmlrpc-c #--with-irstlm="$tooldir"/irstlm
#chmod -R 777 "$tooldir"/mosesdecoder


#Most-known neural attention-based MT frameworks, Nematus and OpenNMT:

#Nematus: built on TensorFlow (BSD 3-clause license)
#https://github.com/EdinburghNLP/nematus

#OpenNMT: built on TensorFlow or PyTorch (MIT license)
#Has a relatively general-purpuse im2text system, for seq2seq variants such as image-to-text
#http://opennmt.net



#MARIAN-NMT: Marian Neural Machine Translation in C++ (MIT license).
#Fast; allows multi-CPU and multi-GPU, has excellent command-line tools.
#State-of-the-art NMT architectures: deep RNN and transformer.
#Regularization methods, transfer learning from monolingual data and pre-trained word2vec.
#Sentence-level and word-level data weighting.
#Guided alignment for attention, and training on raw texts possible (using SentencePiece).
#https://marian-nmt.github.io/


#CytonMT: really fast neural MT in C++ (Apache 2.0 license).
#With NVIDIA GPUs, this is the very fastest and best code available to my knowledge.
#Gives command-line tool cytonMt, with --mode {train,translate}
#Wang X, Utiyama M, Sumita E. 2018. CytonMT: an efficient neural machine translation open-source toolkit implemented in C++. arXiv: 1802.07170(v2): 1-6.
#https://github.com/arthurxlw/cytonMt


#seq2seq: general-purpose encoder-decoder framework for TensorFlow (Apache 2.0)
#Britz et al. 2017.
#https://github.com/google/seq2seq


#fairseq-py: convS2S (convolutional sequence-to-sequence) for neural MT from Facebook for PyTorch (MIT license)
#Gehring et al. 2017.
#https://github.com/pytorch/fairseq


#tensor2tensor: library of deep-learning models from Google Brain for TensorFlow (Apache 2.0)
#Viswani et al. 2017.
#https://github.com/tensorflow/tensor2tensor



#gnuspeech
#See Speech_Synthesis/Software_Toolkits
#https://www.gnu.org/software/gnuspeech


#R NLP package: have to do from within an R session using install.packages("nlp")


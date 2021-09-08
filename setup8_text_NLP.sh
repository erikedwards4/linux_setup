#!/bin/bash
#@author Erik Edwards
#@date 2018-2020
#
#This script installs Linux utilities for text processing, IE (information extraction),
#NLP (natural language processing), machine translation (MT), including neural MT and general sequence-to-sequence,
#language models (LMs), word embedding, text classification, etc.
#
#For each tool, I provide references and/or the main website.



#R NLP package: have to do from within an R session using install.packages("nlp")


#Google Regular Expressions
cd /opt
git clone https://code.googlesource.com/re2
chmod -R 777 /opt/re2
cd /opt/re2
make
make test
sudo make install
make testinstall
chmod -R 777 /opt/re2


#CMPH (C minimal perfect hashing)
cd /opt
git clone https://github.com/zvelo/cmph
chmod -R 777 /opt/cmph
cd /opt/cmph
./configure
make
sudo make install


#OpenFST [Apache 2.0 license]
#http://www.openfst.org/twiki/bin/view/FST/WebHome
cd /opt
rm -rf /opt/openfst*
wget http://www.openfst.org/twiki/pub/FST/FstDownload/openfst-1.8.0.tar.gz -O - |
tar -xz -C /opt
chmod -R 777 /opt/openfst-*
mv /opt/openfst-* /opt/openfst
cd /opt/openfst
sed -i 's| -std=c++11| -std=c++17|' ./configure  #required for enable-ngram-fsts?
./configure --enable-static=true --enable-shared=true --enable-far=true --enable-pdt=true --enable-mpdt=true --enable-python=true --enable-ngram-fsts=true #needed for OpenGRM
make
make check  #optional
sudo make install
#To get bash completions (http://www.openfst.org/twiki/bin/view/Contrib/OpenFstBashComp):
wget http://www.openfst.org/twiki/pub/Contrib/OpenFstBashComp/openfstbc -P /opt/openfst
source /opt/openfst/openfstbc
chmod -R 777 /opt/openfst
#Now available as a Debian package
sudo apt-get -y install libfst-dev libfst-tools


#OpenGRM [Apache 2.0 license]
#http://www.opengrm.org/twiki/bin/view/GRM/WebHome
cd /opt
rm -rf /opt/ngram*
wget http://www.opengrm.org/twiki/pub/GRM/NGramDownload/ngram-1.3.12.tar.gz -O - |
tar -xz -C /opt
mv /opt/ngram-* /opt/ngram
chmod -R 777 /opt/ngram
cd /opt/ngram
sed -i 's| -std=c++11| -std=c++17|' ./configure  #required?
./configure
make
make check  #optional
sudo make install
chmod -R 777 /opt/ngram
#Now available as a Debian package
sudo apt-get -y install libngram-dev libngram-tools


#Thrax [Apache 2.0 license]
#http://www.opengrm.org/twiki/bin/view/GRM/Thrax
cd /opt
rm -rf /opt/thrax*
wget http://www.opengrm.org/twiki/pub/GRM/ThraxDownload/thrax-1.3.5.tar.gz -O - |
tar -xz -C /opt
mv /opt/thrax-* /opt/thrax
chmod -R 777 /opt/thrax
cd /opt/thrax
./configure
make
make check  #optional
sudo make install
chmod -R 777 /opt/thrax


#OpenGrm SFst [Apache 2.0 license]
#http://www.opengrm.org/twiki/bin/view/GRM/SFstLibrary
cd /opt
rm -rf /opt/sfst*
wget http://www.opengrm.org/twiki/pub/GRM/SFstDownload/sfst-1.2.0.tar.gz -O - |
tar -xz -C /opt
mv /opt/sfst-* /opt/sfst
chmod -R 777 /opt/sfst
cd /opt/sfst
./configure
make
make check  #optional
sudo make install
chmod -R 777 /opt/sfst


#OpenGrm Pynini [Apache 2.0 license]
#http://www.opengrm.org/twiki/bin/view/GRM/Pynini
cd /opt
rm -rf /opt/pynini*
wget http://www.opengrm.org/twiki/pub/GRM/PyniniDownload/pynini-2.1.3.tar.gz -O - |
tar -xz -C /opt
mv /opt/pynini-* /opt/pynini
chmod -R 777 /opt/pynini
cd /opt/pynini
sudo python3 setup.py install
python3 setup.py test


#OpenGrm BaumWelch [Apache 2.0 license]
#http://www.opengrm.org/twiki/bin/view/GRM/BaumWelch
cd /opt
rm -rf /opt/baumwelch*
wget http://www.opengrm.org/twiki/pub/GRM/BaumWelchDownload/baumwelch-0.3.5.tar.gz -O - |
tar -xz -C /opt
mv /opt/baumwelch-* /opt/baumwelch
chmod -R 777 /opt/baumwelch
cd /opt/baumwelch
./configure
make
make check  #optional
sudo make install
chmod -R 777 /opt/baumwelch


#MIT LM
cd /opt
git clone https://github.com/mitlm/mitlm
chmod -R 777 /opt/mitlm
cd /opt/mitlm
./autogen.sh
make
sudo make install
chmod -R 777 /opt/mitlm


#KenLM [GNU Lesser General Public License v3]
#https://kheafield.com/code/kenlm/
cd /opt
wget https://kheafield.com/code/kenlm.tar.gz -O - |
tar -xz
chmod -R 777 /opt/kenlm
cd /opt/kenlm
mkdir -m 777 build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DKENLM_MAX_ORDER=16 -DCMAKE_POSITION_INDEPENDENT_CODE=ON
make -j2
chmod -R 777 /opt/kenlm


#CMU-Cambridge Statistical Language Modeling Toolkit (CMU-Cam SLMTK) v2 [open-source, but no license given].
#Major update to v1 [Rosenfeld 1994], in C with command-line tools [Clarkson and Rosenfeld 1997].
#Perhaps only novel ability is can explicity use "context cues", such as sentence and paragraph start (<s>, <p>) and others.
#The source-code in C is included, so this would be go-to place to start programming oneself!
#The documentation has good description of discounting, etc., and has good references.
#http://www.speech.cs.cmu.edu/SLM/toolkit_documentation.html
#Clarkson P, Rosenfeld R. 1997. Statistical language modeling using the CMU-Cambridge toolkit. Proc Eurospeech. ISCA: 2707-10.
#http://www.speech.cs.cmu.edu/SLM/toolkit.html
cd /opt
wget http://www.speech.cs.cmu.edu/SLM/CMU-Cam_Toolkit_v2.tar.gz -O - |
tar -xz
chmod -R 777 /opt/CMU-Cam_Toolkit_v2
cd /opt/CMU-Cam_Toolkit_v2/src
sed -i 's|^#BYTESWAP_FLAG|BYTESWAP_FLAG|' /opt/CMU-Cam_Toolkit_v2/src/Makefile              #Change big- -> little-endian
sed -i 's|^#define STD_MEM 100|#define STD_MEM 8000|' /opt/CMU-Cam_Toolkit_v2/src/toolkit.h #I assume at least 8 GB RAM
make install


#RNNLM: RNN LM C/C++ code from Mikolov [Copyright notice indicates completey open-source, but no license]
#Mikolov T, Kombrink S, Deoras A, Burget L, Èernocký J. 2011. RNNLM - recurrent neural network language modeling toolkit. Proc ASRU Wrkshp. IEEE: 196-201.
#https://github.com/mspandit/rnnlm
cd /opt
mkdir -m 777 /opt/rnnlm
cd /opt/rnnlm
wget http://www.fit.vutbr.cz/~imikolov/rnnlm/rnnlm-0.3e.tgz -P /opt/rnnlm
tar -xzf /opt/rnnlm/rnnlm-0.3e.tgz
wget http://www.fit.vutbr.cz/~imikolov/rnnlm/simple-examples.tgz -P /opt/rnnlm
tar -xzf /opt/rnnlm/simple-examples.tgz
wget http://www.fit.vutbr.cz/~imikolov/rnnlm/rnn-rt07-example.tar.gz -P /opt/rnnlm
tar -xzf /opt/rnnlm/rnn-rt07-example.tar.gz
rm -f /opt/rnnlm/{simple-examples.tgz,rnn-rt07-example.tar.gz}
chmod -R 777 /opt/rnnlm
make CC=g++
#To test:
/opt/rnnlm/rnnlm
#From example.sh
/opt/rnnlm/rnnlm -train train -valid valid -rnnlm model -hidden 15 -rand-seed 1 -debug 2 -class 100 -bptt 4 -bptt-block 10 -direct-order 3 -direct 2 -binary


#faster-rnnlm: RNN LM C++ toolbox from Yandex [Apache 2.0].
#"...can be trained on huge datasets (several billions of words) and very large vocabularies (several hundred thousands) and used in real-world ASR and MT problems.
# ...supports such praised setups as ReLU+DiagonalInitialization [Le et al. 2015], GRU [Chung et al. 2014], NCE [Chen et al. 2015], and RMSProp [Tieleman & Hinton 2012]."
#https://github.com/yandex/faster-rnnlm
cd /opt
git clone https://github.com/yandex/faster-rnnlm
chmod -R 777 /opt/faster-rnnlm
cd /opt/faster-rnnlm
#./build.sh
sed -i 's|3.2.4|3.3.9|' /opt/faster-rnnlm/build.sh
curl -L "https://gitlab.com/libeigen/eigen/-/archive/3.3.9/eigen-3.3.9.tar.bz2" -o /opt/faster-rnnlm/eigen-3.3.9.tar.bz2
tar -xjf /opt/faster-rnnlm/eigen-3.3.9.tar.bz2 -C /opt/faster-rnnlm
mv /opt/faster-rnnlm/eigen* /opt/faster-rnnlm/eigen3
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 8
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 8
sudo update-alternatives --config gcc   #Then choose gcc-8
sudo update-alternatives --config g++   #Then choose g++-8
cd /opt/faster-rnnlm/faster-rnnlm
make -j
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 9
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 9
sudo update-alternatives --config gcc   #Then choose gcc-9
sudo update-alternatives --config g++   #Then choose g++-9
#To check:
/opt/faster-rnnlm/faster-rnnlm/rnnlm


#CUED-RNNLM: RNN LM from CUED (Cambridge Univ. Eng. Dept.)
#"...implementation of RNNLM training (on GPU), and efficient evaluation(on CPU).
# ...support LSTM, GRU, Highway structure, as well as more flexible deep structure."
#The recent v1.1 supports succeeding-word RNNLM (su-RNNLM) with future context [Chen et al. 2018].
#Liu X, Wang Y, Chen X, Gales MJ, Woodland PC. 2014. Efficient lattice rescoring using recurrent neural network language models. Proc ICASSP. IEEE: 4908-12.
#Chen X, Liu X, Gales MJ, Woodland PC. 2015. Recurrent neural network language model training with noise contrastive estimation for speech recognition. Proc ICASSP. IEEE: 5411-5.
#Chen X, Liu X, Qian Y, Gales MJ, Woodland PC. 2016. CUED-RNNLM—An open-source toolkit for efficient training and evaluation of recurrent neural network language models. Proc ICASSP. IEEE: 6000-4.
#Chen X, Liu X, Wang Y, Ragni A, Wong JH, Gales MJ. 2019. Exploiting future word contexts in neural network language models for speech recognition. IEEE/ACM Trans Audio Speech Lang Process. 27(9): 1444-54.
#http://mi.eng.cam.ac.uk/projects/cued-rnnlm
cd /opt
wget --no-check-certificate http://mi.eng.cam.ac.uk/projects/cued-rnnlm/cued-rnnlm.v1.1.tar.gz 1> /opt/cued-rnnlm.v1.1.tar.gz 2> /opt/tmp.log
#curl -sL http://mi.eng.cam.ac.uk/projects/cued-rnnlm/cued-rnnlm.v1.1.tar.gz -o /opt/cued-rnnlm.v1.1.tar.gz
tar -xzf /opt/cued-rnnlm.v1.1.tar.gz
#Can't get download working.


#rnnlm2wfst: converts RNNLMs to WFSTs, using K-means discretization [Apache 2.0 license]
#Lecorvé G, Motlicek P. 2012. Conversion of recurrent neural network language models to weighted finite state transducers for automatic speech recognition. Proc INTERSPEECH. ISCA: 1668-71.
#https://github.com/glecorve/rnnlm2wfst
cd /opt
git clone https://github.com/glecorve/rnnlm2wfst
chmod -R 777 /opt/rnnlm2wfst
cd /opt/rnnlm2wfst
cd /opt/rnnlm2wfst/kmeans
make
cd /opt/rnnlm2wfst/rnnlm-0.2b
sed -i 's|OPENFST:=../../openfst-1.3.2/|OPENFST:=/opt/openfst/|' /opt/rnnlm2wfst/rnnlm-0.2b/src/makefile
make USE_BLAS=1
#Unfortunately, fails; also if use openfst-1.3.2 (although different error).


#MEMT (Multi-Engine Machine Translation) is a system combination scheme [GNU Lesser General Public License v3].
#"It combines single-best outputs from multiple independent translation systems to
# form an n-best list of combined translations that improve over individual systems."
#https://kheafield.com/code/memt
#https://github.com/kpu/MEMT
cd /opt
git clone https://github.com/kpu/MEMT
chmod -R 777 /opt/MEMT
#./bjam #this fails due to icu-config not found
cd /opt/MEMT/jam-files/engine
./build.sh
cp -f bin.*/bjam ../bjam
cd /opt/MEMT
MEMT/Alignment/compile.sh


#CRFSuite: fast C++ implementation of Conditional Random Fields (CRFs)
#Linear-chain (1st-order Markov) CRFs.
#Excellent training methods, simple command-line use, performance evaluation.
#From maker of widely-used L-BFGS lib
#http://www.chokkan.org/software/crfsuite
wget -P /opt https://github.com/downloads/chokkan/crfsuite/crfsuite-0.12.tar.gz
tar -xzf /opt/crfsuite-0.12.tar.gz
rm /opt/crfsuite-0.12.tar.gz
chmod -R 777 crfsuite*
cd /opt/crfsuite-0.12
./configure
make
sudo make install
sudo ln -s /usr/local/lib/libcrfsuite-0.12.so /usr/lib/libcrfsuite-0.12.so
sudo ln -s /usr/local/lib/libcqdb-0.12.so /usr/lib/libcqdb-0.12.so
sudo ln -s /usr/local/bin/crfsuite /usr/bin/crfsuite-stdin


#CRF++: yet-another CRF toolkit, in C++ (under either LGPL or 2-clause BSD).
#Has simple command-line tools crf_learn and crf_test.
#Has simple opt for number of processors (CRFSuite has no easy parallel option).
#Allows bigram features by setting.
#https://taku910.github.io/crfpp
#Get tar.gz file from website, put into /opt.
cd /opt
tar -xzf /opt/CRF++-0.58.tar.gz
rm /opt/CRF++-0.58.tar.gz
chmod -R 777 /opt/CRF++-0.58
cd /opt/CRF++-0.58
./configure
make
make check
sudo make install
sudo ln -s /opt/CRF++-0.58/.libs/libcrfpp.so.0 /usr/lib/libcrfpp.so.0
chmod -R 777 /opt/CRF++-0.58


#seqlearn: "sequence classification toolkit for Python."
#"It is designed to extend scikit-learn and offer as similar as possible an API."
#Includes discrete HMM and structured perceptron [Collins 2002; Daumé 2006].
#The later is for structured prediction; looks great! See:
#http://www.phontron.com/slides/nlp-programming-en-12-struct.pdf
#http://larsmans.github.io/seqlearn
#https://github.com/larsmans/seqlearn
cd /opt
git clone https://github.com/larsmans/seqlearn
chmod -R 777 /opt/seqlearn
cd /opt/seqlearn
sudo python setup.py install


#sequentia: Python interface to other methods from guy in Edinburgh [MIT license].
#See also pomegranate and fastDTW.
#https://github.com/eonu/sequentia


#word2vec: the classic C-code implementation by Mikolov [Apache 2.0 license].
#Also mentions phrase2vec, to find frequent phrases in the training data (e.g. San_Francisco).
#But I only find word2phrase, which learns phrases from the data. See phrase2vec below instead.
#Mikolov T et al. (2013a,b,c).
#https://code.google.com/p/word2vec/
#https://github.com/tmikolov/word2vec
#Get .zip file and put into /opt
cd /opt
unzip -d /opt /opt/word2vec-master.zip
rm /opt/word2vec-master.zip
chmod -R 777 /opt/word2vec-master
mv /opt/word2vec-master /opt/word2vec
cd /opt/word2vec
make
chmod -R 777 /opt/word2vec


#GloVe: Global Vectors for distributed word representation [Apache 2.0 license]
#Pennington J, Socher R, Manning CD. (2014). GloVe: global vectors for word representation. Proc EMNLP. ACL: 1532-43.
#https://nlp.stanford.edu/projects/glove
#https://github.com/stanfordnlp/GloVe
cd /opt
git clone http://github.com/stanfordnlp/glove
chmod -R 777 /opt/glove
cd /opt/glove
make
#To test
./demo.sh

#See some other tools from Stanford NLP that involve RNNs and LSTMs with trees:
#https://github.com/stanfordnlp
#https://github.com/stanfordnlp/spinn
#https://github.com/stanfordnlp/treelstm


#wang2vec: extension of the original word2vec using different architectures [Apache 2.0 license]
#Has 5 methods (cbow, skipngram, cwindow, structured skipngram, senna context window model)
#Cited by sense2vec for: each word can have more than one meaning (like noun/verb polysemy),
#so this first uses clustering using context to decide how many meanings a word can have.
#This is actually very good for g2p case, because each grapheme or each phoneme has multiple meanings.
#Ling W, Dyer C, Black AW, Trancoso I. 2015. Two/too simple adaptations of word2vec for syntax problems. Proc Conf NAACL-HLT. ACL: 1299-1304.
#https://github.com/wlin12/wang2vec
cd /opt
git clone https://github.com/wlin12/wang2vec
chmod -R 777 /opt/wang2vec
cd /opt/wang2vec
make


#phrase2vec: implementation of phrase2vec from modified word2vec code [Apache 2.0 license]
#However, not as well-documented and no reference compared to below. (This may be knock-off.)
#https://github.com/zseymour/phrase2vec


#Phrase2vec: an extension of word2vec to learn n-gram (phrase) embeddings [Apache 2.0 license]
#Same interface as word2vec, but has additional input -phrases phrases.txt,
#where one lists the phrases (n-grams) for which to learn embeddings.
#The phrases.txt can also be learned by the provided word2phrase tool.
#Artetxe M, Labaka G, Agirre E. 2018. Unsupervised statistical machine translation. Proc EMNLP. ACL: 3632-42.
#https://github.com/artetxem/phrase2vec
cd /opt
git clone https://github.com/artetxem/phrase2vec
chmod -R 777 /opt/phrase2vec
cd /opt/phrase2vec
make


#ClusterCat: fast, flexible word clustering software in modern C [license either GNU LGPL v3, or Mozilla Public License v2]
#Induces word classes (or vecs) from unannotated text.
#"Word classes are unsupervised part-of-speech tags, requiring no manually-annotated corpus.
# Words are grouped together that share syntactic/semantic similarities. They are used in many dozens of
# applications within natural language processing, machine translation, neural net training, and related fields."
#Dehdari J, Tan L, van Genabith J. 2016. BIRA: Improved predictive exchange word clustering. Proc Conf NAACL-HLT. ACL: 1169-74.
cd /opt
git clone https://github.com/jonsafari/clustercat
chmod -R 777 /opt/clustercat
cd /opt/clustercat
make
#To test
/opt/clustercat/bin/clustercat --help


#Brown-cluster: C++ implementation of the Brown hierarchical word clustering algorithm.
#Brown PF, Della Pietra VJ, Desouza PV, Lai JC, Mercer RL. 1992. Class-based n-gram models of natural language. Comput Linguist. 18(4): 467-80.
#Liang P. 2005. Semi-supervised learning for natural language. Ph.D. Thesis. Dept. of EECS, MIT.
#https://github.com/percyliang/brown-cluster
cd /opt
git clone https://github.com/percyliang/brown-cluster
chmod -R 777 /opt/brown-cluster
cd /opt/brown-cluster
make
#To test:
/opt/brown-cluster/wcluster --help


#hpca: C++ toolkit providing an efficient implementation of the Hellinger PCA for computing word embeddings
#https://github.com/idiap/hpca


#Giza++ (note: they suggest mgiza, which is also avaiilable at Moses)
#Also does word classes with mkcls.
cd /opt
git clone https://github.com/moses-smt/giza-pp
chmod -R 777 /opt/giza-pp
cd /opt/giza-pp
make
chmod -R 777 /opt/giza-pp


#mgiza: word alignment tool based on famous GIZA++, extended to support multi-threading, resume training and incremental training.
#Also does word classes with mkcls.
cd /opt
git clone https://github.com/moses-smt/mgiza
chmod -R 777 /opt/mgiza
cd /opt/mgiza/mgizapp
cmake .
make
sudo make install
chmod -R 777 /opt/mgiza


#fast_align: a simple, fast, unsupervised word aligner [Apache 2.0 license]
#Recommended by above paper [Artetxe et al. 2018].
#Dyer C, Chahuneau V, Smith NA. (2013). A simple, fast, and effective reparameterization of IBM Model 2. Proc NAACL. ACL: 644-8.
#https://github.com/clab/fast_align
sudo apt-get install libgoogle-perftools-dev libsparsehash-dev
cd /opt
git clone https://github.com/clab/fast_align
chmod -R 777 /opt/fast_align
cd /opt/fast_align
mkdir /opt/fast_align/build
cd /opt/fast_align/build
cmake ..
make
chmod -R 777 /opt/fast_align


#efmaral: efficient Markov Chain word alignment in Python/C [GPL v3 license].
#Can be used as plug-in replacement for fast_align, but said to outperform fast_align.
#Östling R, Tiedemann J. 2016. Efficient word alignment with Markov Chain Monte Carlo. Prague Bull Math Linguist. 106(1): 125-46.
cd /opt
git clone https://github.com/robertostling/efmaral.git
chmod -R 777 /opt/efmaral
cd /opt/efmaral
sudo python3 setup.py install
#General link to atools needed for align_symmetrize.sh to work, but can also specify this in one's own script:
sudo ln -s /opt/fast_align/build/atools /usr/local/bin/atools
#To test:
./align.py --help
python3 /opt/efmaral/scripts/evaluate.py efmaral /opt/efmaral/3rdparty/data/test.{eng.hin.wa,eng,hin} /opt/efmaral/3rdparty/data/trial.{eng,hin}
/opt/efmaral/scripts/align_symmetrize.sh /opt/efmaral/3rdparty/data/test.{eng,hin,moses} grow-diag-final-and


#Hieralign: Symmetric Word Alignment using Hierarchial Sub-sentential Alignment [Apache 2.0 license]
#Fast, multi-threaded C++ code with easy-to-use command-line tool Hieralign.
#"...yet another symmetric word alignment tool simple, fast and unsupervised, it has been
#implemented with multi-threading in all stages, which makes it run as fast as fast_align."
#Wang H, Lepage Y. 2017. Hierarchical sub-sentential alignment with IBM Models for statistical phrase-based machine translation. J Nat Lang Process. 24(4): 619-46.
cd /opt
git clone https://github.com/wang-h/Hieralign
chmod -R 777 /opt/Hieralign
cd /opt/Hieralign
cmake .
make
#To test:
/opt/Hieralign/Hieralign -h


#Moses: famous, most-used MT framework (LGPL license)
#Requires IRSTLM; so install Kaldi first
#http://www.statmt.org/moses
cd /opt
git clone https://github.com/moses-smt/mosesdecoder.git
chmod -R 777 /opt/mosesdecoder
cd /opt/mosesdecoder
./bjam --no-xmlrpc-c --with-cmph=/opt/cmph --with-irstlm=/opt/irstlm #--with-boost=/opt/boost_1_67_0 
chmod -R 777 /opt/mosesdecoder


#Thot: statistical MT framework (LGPL license).
#Can be installed with KenLM, but doesn't work for newest version of KenLM.
#Can estimate IBM 1, IBM 2 and HMM-based word alignment models, and does phrase-based.
#The overall translation model is generative, as well-explained in the doc.
#Main features are incremental, multi-LM, and interactive methods.
#But, overall is a 1-person project that lacks in great sophistication/features.
#https://github.com/daormar/thot
#Ortiz-Martínez D, García-Varea I, Casacuberta F. 2005. Thot: a toolkit to train phrase-based models for statistical machine translation. Proc 10th MT Summit. AAMT: 141-8.
#Ortiz-Martínez D, García-Varea I, Casacuberta F. 2008. Phrase-level alignment generation using a smoothed loglinear phrase-based statistical alignment model. Proc 12th EAMT Conf, vol. 8. EAMT: 160-9.
#Ortiz-Martínez D, Casacuberta F. 2014. The new thot toolkit for fully-automatic and interactive statistical machine translation. Proc 14th Conf EACL. ACL: 45-8.
cd /opt
git clone https://github.com/daormar/thot.git
chmod -R 777 /opt/thot
cd /opt/thot
./reconf
./configure --prefix=/opt/thot --enable-ibm2-alig #--with-kenlm=/opt/kenlm
make
make install
#To test:
make installcheck
/opt/thot/bin/thot_lm_train --help


#Most-known neural attention-based MT frameworks, Nematus and OpenNMT:

#Nematus: built on TensorFlow (BSD 3-clause license)
#https://github.com/EdinburghNLP/nematus
#Install requires TF and only Docker instructions given, so highly unlikely to work right now.


#OpenNMT: built on TensorFlow or PyTorch (MIT license)
#I will use PyTorch version, OpenNMT-py: https://github.com/OpenNMT/OpenNMT-py
#Has a relatively general-purpuse im2text system, for seq2seq variants such as image-to-text
#Has a "fast and customizable text tokenization with C++ and Python APIs": https://github.com/OpenNMT/Tokenizer
#Has CTranslate2, and "optimized inference engine for OpenNMT models": https://github.com/OpenNMT/CTranslate2
#Can be used with previously-trained GloVe embeddings: https://opennmt.net/OpenNMT-py/FAQ.html#how-do-i-use-pretrained-embeddings-e-g-glove
#http://opennmt.net
python -m pip install --user OpenNMT-py
cd /opt
git clone https://github.com/OpenNMT/OpenNMT-py.git
chmod -R 777 /opt/OpenNMT-py
cd /opt/OpenNMT-py
sudo python -m pip install -r requirements.opt.txt
sudo python setup.py install


#MARIAN-NMT: Marian Neural Machine Translation in C++ (MIT license).
#Fast; allows multi-CPU and multi-GPU, has excellent command-line tools.
#State-of-the-art NMT architectures: deep RNN and transformer.
#Regularization methods, transfer learning from monolingual data and pre-trained word2vec.
#Sentence-level and word-level data weighting.
#Guided alignment for attention, and training on raw texts possible (using SentencePiece).
#Junczys-Dowmunt M, ..., Birch A. (2018). Marian: fast neural machine translation in C++. Proc ACL Syst Demos. ACL: 116-21.
#https://marian-nmt.github.io
cd /opt
git clone https://github.com/marian-nmt/marian
chmod -R 777 /opt/marian
cd /opt/marian
mkdir -m 777 /opt/marian/build
cd /opt/marian/build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j
cd /opt/marian/examples/tools
make all
chmod -R 777 /opt/marian


#CytonMT: really fast neural MT in C++ (Apache 2.0 license).
#With NVIDIA GPUs, this is the very fastest and best code available to my knowledge.
#Gives command-line tool cytonMt, with --mode {train,translate}
#Wang X, Utiyama M, Sumita E. 2018. CytonMT: an efficient neural machine translation open-source toolkit implemented in C++. arXiv: 1802.07170(v2): 1-6.
#https://github.com/arthurxlw/cytonMt
cd /opt
git clone https://github.com/arthurxlw/cytonMt
chmod -R 777 /opt/cytonMT
cd /opt/cytonMT
make -j8
chmod -R 777 /opt/cytonMt


#seq2seq: general-purpose encoder-decoder framework for TensorFlow (Apache 2.0)
#Britz et al. 2017.
#https://github.com/google/seq2seq
cd /opt
git clone https://github.com/google/seq2seq
chmod -R 777 /opt/seq2seq
cd /opt/seq2seq
python -m pip install --user -e .
#To test:
python -m unittest seq2seq.test.pipeline_test
#Fails


#tensor2tensor: library of deep-learning models from Google Brain for TensorFlow (Apache 2.0)
#Viswani et al. 2017.
#https://github.com/tensorflow/tensor2tensor
python -m pip install --user tensor2tensor
t2t-trainer --registry_help
#Fails


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


#torchtext
#Some text-processing tools for PyTorch
#https://pypi.org/project/torchtext
python -m pip install --user -U torchtext


#spaCy: industrial-strength NLP in Python (MIT license)
#https://spacy.io
python -m pip install --user -U spacy[cuda]
#Also get English tokenizer (other languages also available)
python -m pip install --user attrs==19.1.0
sudo python -m spacy download en_core_web_sm


#fastText: library for efficient text classification and representation learning.
#From Facebook, open-source (MIT license), super easy to use! Has autotune (for hyperparameters) too!
#Bojanowski P, Grave E, Joulin A, Mikolov T. (2016). Enriching word vectors with subword information. arXiv. 1607.04606.
#Joulin A, Grave E, Bojanowski P, Mikolov T. (2016). Bag of tricks for efficient text classification. arXiv. 1607.01759.
#Joulin A, Grave E, Bojanowski P, ..., Mikolov T. (2016). FastText.zip: compressing text classification models. arXiv. 1612.03651.
#https://fasttext.cc
#https://github.com/facebookresearch/fastText
cd /opt
git clone https://github.com/facebookresearch/fastText.git
chmod -R 777 /opt/fastText
cd /opt/fastText
make
sudo python setup.py install        #build Python module
#There is also an install method using tar file (probably use next time?)
#To check:
./fasttext --help
python -c 'import fasttext'
#Examples
mkdir -m 777 /opt/fastText/egs
#Text classification:
mkdir -m 777 /opt/fastText/egs/text_classify
wget https://dl.fbaipublicfiles.com/fasttext/data/cooking.stackexchange.tar.gz -O - |
tar -xz > /opt/fastText/egs/text_classify/cooking.stackexchange.txt
#Word representation:
mkdir -m 777 /opt/fastText/egs/word_represent
#wget https://dumps.wikimedia.org/enwiki/latest/enwiki-latest-pages-articles.xml.bz2 #raw dump of Wikipedia
#From Matt Mahoney's website, the first 1 billion bytes of English Wikipedia:
mkdir -m 777 /opt/fastText/egs/word_represent/data
wget -c http://mattmahoney.net/dc/enwik9.zip -P /opt/fastText/egs/word_represent/data
unzip /opt/fastText/egs/word_represent/data/enwik9.zip -d /opt/fastText/egs/word_represent/data
rm /opt/fastText/egs/word_represent/data/enwik9.zip
perl /opt/fastText/wikifil.pl /opt/fastText/egs/word_represent/data/enwik9 > /opt/fastText/egs/word_represent/data/fil9
mkdir -m 777 /opt/fastText/egs/word_represent/result


#Python dependencies for fairseq:
python -m pip install --user fastBPE sacremoses subword_nmt
python -m pip install --user sacrebleu sentencepiece


#fairseq (MIT license)
#This also gives command-line tools: fairseq-preprocess, fairseq-train, fairseq-generate, fairseq-score
#Also see Percy Liang's seq2seq-utils for fairseq (https://github.com/percyliang/seq2seq-utils).
#https://github.com/pytorch/fairseq
sudo pip install h5py
sudo pip install soundfile
python -m pip install fairseq
#Can also install from source and develop locally:
cd /opt
git clone https://github.com/pytorch/fairseq
chmod -R 777 /opt/fairseq
cd /opt/fairseq
sudo python -m pip install --editable .    #this fails after a bit if no sudo
#Prep an MT set to see a fairseq example
#IWSLT'14 German to English dataset
cd /opt/fairseq/examples/translation
/opt/fairseq/examples/translation/prepare-iwslt14.sh
cd /opt/fairseq
# Preprocess/binarize the data
TEXT=/opt/fairseq/examples/translation/iwslt14.tokenized.de-en
fairseq-preprocess  --source-lang de \
                    --target-lang en \
                    --trainpref $TEXT/train \
                    --validpref $TEXT/valid \
                    --testpref $TEXT/test \
                    --destdir /opt/fairseq/examples/translation/data-bin/iwslt14.tokenized.de-en \
                    --workers 8


#fairseq-py: convS2S (convolutional sequence-to-sequence) for neural MT from Facebook for PyTorch (MIT license)
#Gehring et al. 2017.
#https://github.com/pytorch/fairseq
#https://github.com/pytorch/fairseq/blob/master/examples/translation/README.md#training-a-new-model


#Transformers (formerly known as pytorch-transformers and pytorch-pretrained-bert)
#"State-of-the-art general-purpose architectures (BERT, GPT-2, RoBERTa, XLM, DistilBert, XLNet, CTRL...)
#for Natural Language Understanding (NLU) and Natural Language Generation (NLG)...""
#Uses TF2.0 or PyTorch, and can move models between them "at will".
#Supposed to be easy-to-use, with low barrier to entry: "state-of-the-art models in 3 lines of code".
#10 architectures and 32+ pretrained models in 100+ languages.
#Apache 2.0 license.
#https://github.com/huggingface/transformers
python -m pip install --user --upgrade transformers
#"If you'd like to play with the examples, you must install it from source."
cd /opt
git clone https://github.com/huggingface/transformers
chmod -R 777 /opt/transformers
cd /opt/transformers
python -m pip install --user .
#Install tests (takes long time, with lots of downloads!)
python -m pip install --user --upgrade pytest
python -m pip install --user -e ".[testing]"
#make test
#Most pass, many skipped, quite a few fail. Successfully opens various CUDA libs.
#But then it crashed my compter!
#Install examples
python -m pip install --user -r examples/requirements.txt
make test-examples
#To upgrade:
cd /opt/transformers
git pull
python -m pip install --user --upgrade .


#Simpletransformers: built on top of Transformers (Apache 2.0 license)
#for ease of use, with focus on text classification.
#Good point: "Set 'sliding_window': True in args to prevent text being truncated. ...Training text
#will be split using a sliding window and each window will be assigned the label from the original text."
#However, all examples are in Python (no command-line tool).
#https://github.com/ThilinaRajapakse/simpletransformers
cd /opt
git clone https://github.com/ThilinaRajapakse/simpletransformers
chmod -R 777 /opt/simpletransformers
cd /opt/simpletransformers
python -m pip install --user --upgrade .


#Gensim: collection of Python NLP tools by RARE Technologies (i.e., from Radim Rehurek) (LGPL 2.1 license)
#Most notable for implementation of doc2vec [Le and Mikolov 2014].
#Radim R, Sojka P. (2010). Software framework for topic modelling with large corpora. Proc LREC. ELRA: 45-50.
#https://github.com/RaRe-Technologies/gensim
python -m pip install --user --upgrade gensim


#Sent2vec: sentence embedding based on fastText (BSD license)
#"Think of it as an unsupervised version of FastText, and an extension of word2vec (CBOW) to sentences."
#"This library provides numerical representations (features) for words, short texts, or sentences, which can be used as input to any machine learning task."
cd /opt
git clone https://github.com/epfml/sent2vec
chmod -R 777 /opt/sent2vec
cd /opt/sent2vec
make
python -m pip install --user --upgrade .


#PyText: deep-learning NLP framework built on PyTorch, from FAIR [BSD license].
#"PyText addresses the often-conflicting requirements of enabling rapid experimentation and of serving models at scale."
#The "optimized Caffe2 execution engine" is used for the "serving models at scale" part.
#Includes pre-trained text classifiers, sequence taggers, and joint intent-slot models.
#https://pytext.readthedocs.io/en/master/
#https://github.com/facebookresearch/pytext
cd /opt
git clone https://github.com/facebookresearch/pytext
chmod -R 777 /opt/pytext
cd /opt/pytext
#Actually, they only have install instructions for virtual env, so:
python -m pip install --user pytext-nlp


#StarSpace: general-purpose for entity embeddings from FAIR [MIT license]
#Does text classification. File format same as fastText!
#But same general format can be used for:
#Has Training Modes 0 (classification) through 5 (unsupervised embedding),
#with several other possiblities (collaborative filtering, part-to-whole mapping, pairwise similarity, multi-relational graphs).
#Examples for: tag embeddings, page embeddings, document recommendation, link prediction in knowledge bases, sentence embedding.
#And just recently: image embeddings, using last layer of ResNeXt output as input and image class labels for CIFAR-10:
#d0:0.8  d1:0.5   ...    d1023:1.2   __label__1
#So, this is perfect for any situation with 10s-1000s of dense features! Like audio file classification!
#https://github.com/facebookresearch/StarSpace
cd /opt
git clone https://github.com/facebookresearch/Starspace.git
chmod -R 777 /opt/Starspace
cd /opt/Starspace
make
make query_predict
make query_nn
make print_ngrams
make embed_doc
#To build Python wrapper
cd /opt/Starspace/python
./build.sh
#But didn't work...


#nlputils: [MIT license]
#"several functions to analyze text corpora. Mainly, text documents can be transformed into (sparse, dictionary based)
#tf-idf features, based on which the similarities between the documents can be computed, the dataset can be classified with knn,
#or the corpus can be visualized in two dimensions."
#https://github.com/cod3licious/nlputils


#SimEc: Similarity Encoders from Berlin group that made nlputils [MIT license]
#"code for the Similarity Encoder (SimEc) neural network architecture based on the keras library."
#There are easy-to-follow keras recipes in Python notebooks.
#This is neural alternative to kernal PCA and really makes sense; should be worth trying!
#Embeds with output objective to match given pairwise similarities. These are often human labels.
#I think: could be used for regression task, where similarity is diff of observations^p.
#Horn F, Müller K-R. (2018). Predicting pairwise relations with neural similarity encoders. Bull Pol Acad Sci Tech Sci. 66(6): 821-30.
#https://github.com/cod3licious/simec


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
chmod -R 777 /opt/openfst


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
cmake .. -DCMAKE_BUILD_TYPE=Release -DKENLM_MAX_ORDER=20 -DCMAKE_POSITION_INDEPENDENT_CODE=ON
make -j2
chmod -R 777 /opt/kenlm


#MEMT (Multi-Engine Machine Translation) is a system combination scheme [GNU Lesser General Public License v3].
#"It combines single-best outputs from multiple independent translation systems to
# form an n-best list of combined translations that improve over individual systems."
#https://kheafield.com/code/memt
#https://github.com/kpu/MEMT
cd /opt
git clone https://github.com/kpu/MEMT
chmod -R 777 /opt/MEMT
./bjam
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


#hpca: C++ toolkit providing an efficient implementation of the Hellinger PCA for computing word embeddings
#https://github.com/idiap/hpca


#Giza++ (note: they suggest mgiza, which is also avaiilable at Moses)
cd /opt
git clone https://github.com/moses-smt/giza-pp
chmod -R 777 /opt/giza-pp
cd /opt/giza-pp
make
chmod -R 777 /opt/giza-pp


#mgiza: word alignment tool based on famous GIZA++, extended to support multi-threading, resume training and incremental training.
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
#https://github.com/pytorch/fairseq
#This also gives command-line tools: fairseq-preprocess, fairseq-train, fairseq-generate, fairseq-score
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


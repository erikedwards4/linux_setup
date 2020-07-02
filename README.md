# setup

Bash scripts to setup a new Linux machine for audio, speech, ASR, NLP, ML, etc.

This includes many basic dependencies, coding languages, command-line tools, toolboxes, etc.,

I cite the software licence for higher-level tools.
This is critical info to decide which tools to use in practice.

I include descriptions, references, and website links for almost all tools.
This shows where to get further information, and what to cite if using.
It is also the theme of this project -- that we should not take for granted
the many awesome tools provided by other developers!

Everything we do as developers stands on the shoulders of giants:
*nanos gigantum humeris insidentes*

This project was accompanied by my own study of the dependecy structure of Linux
and many of the tools herein. I made a Graphviz (https://graphviz.org/) visualization
of the dependency graph. Basically, the standard C, C++ and Fortran libraries
sit at the core of everything (recalling that Linux, Python, R, etc. are in C).
The installations are in approximate order of dependency.
Some tools are installed only because they are a dependency for a later tool.

This was written and tested on Ubuntu (18.04, the most recent LTS version).
It could probably be adapted easily to other Linux distros.


## Dependencies
Ubuntu (tested on Ubuntu 18.04).


## Usage
For minimal set-up of a new Linux instance for ASR, run:
    setup_basic_ml_asr.sh 1
    setup_basic_ml_asr.sh 2
And then install each tool manually from stage 3 (these are tools requiring custom install into /opt).

For longer-term set-up, use each step[1-9]_*.sh in turn.
However, a few installs require some interaction (e.g. aws),
so the best (and most educational) way to run this is line-by-line.


## Contributing
This is currently for viewing and usage only.
Feel free to contact the author (erik.edwards4@gmail.com) if any suggestions!


## License
[BSD 3-Clause](https://choosealicense.com/licenses/bsd-3-clause/)


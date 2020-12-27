FROM python:3.7-buster

RUN apt-get update && apt-get install -y \
  wget \
  nginx \
  ca-certificates \
  htop \
  vim \
  jed \
  nano \
  nodejs \
  zsh \
  mtr \
  whois \
  python-pydot \
  python-pydot-ng \
  graphviz \
  npm && rm -rf /var/cache/apt && rm -rf /var/lib/apt/lists/*

ENV TERM xterm
ENV ZSH_THEME agnoster
RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O - | zsh || true

RUN pip3 install -U pip --no-cache-dir
COPY /requirements.txt /requirements.txt
RUN pip3 install -r requirements.txt --no-cache-dir

# Jupyter process
RUN jupyter nbextension enable --py --sys-prefix ipysankeywidget
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension
RUN jupyter serverextension enable --py jupyterlab --sys-prefix
RUN jupyter labextension install jupyterlab_templates
RUN jupyter notebook --generate-config
COPY /jupyterlab_config.py /jupyterlab_config.py
RUN cat /jupyterlab_config.py >>/root/.jupyter/jupyter_notebook_config.py
RUN jupyter serverextension enable --py jupyterlab_templates
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager
RUN jupyter labextension install ipytree

# For DL, only if do you really need this!! Is >1 GB to download!
#RUN pip3 install keras --no-cache-dir
#RUN pip3 install torch torchtext --no-cache-dir
#RUN pip3 install tensorflow --no-cache-dir
#RUN pip3 install seq2seq-lstml --no-cache-dir
#RUN pip3 install allennlp --no-cache-dir

# For download somethings
#COPY /GloVe_6B.py /GloVe_6B.py
#RUN python /GloVe_6B.py

# Experimental:
#RUN pip3 install 
RUN pip3 install nested_lookup

COPY /JupyterTemplates/DS/*.ipynb /JupyterTemplates/DS/
COPY /tracker.jupyterlab-settings /root/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/

# For use NLTK
RUN python3 -m spacy download en
COPY /ops/NLTK_Download_SSL.py /NLTK_Download_SSL.py
RUN python3 /NLTK_Download_SSL.py

# Mount point of your $HOME
ARG user_home
RUN mkdir -p ${user_home}_empty
RUN mkdir /work
RUN ln -s /work ${user_home}
ENV USER_HOME ${user_home}

# All servers need be in:
COPY /servers.sh /servers.sh
WORKDIR /
EXPOSE 8888 8501
CMD ["/servers.sh"]

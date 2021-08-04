ARG TAG
ARG BASE_IMAGE_NAME
FROM ${BASE_IMAGE_NAME}:${TAG}

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
  build-essential \
  libpoppler-cpp-dev \
  pkg-config \
  tree \
  jq \
  npm && \
  rm -rf /var/cache/apt && rm -rf /var/lib/apt/lists/*

# Jupyter process and Node.js 14.
RUN curl -sL https://deb.nodesource.com/setup_14.x  | bash - && \
  apt-get install -y nodejs && \
  rm -rf /var/cache/apt && \
  rm -rf /var/lib/apt/lists/*

# Oh-My-Z Shell
ENV TERM xterm
ENV ZSH_THEME agnoster
RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O - | zsh || true

# Install python pkgs
RUN pip3 install -U pip --no-cache-dir
COPY ./ops/requirements.txt /requirements.txt
RUN pip3 install -r requirements.txt --no-cache-dir

# Jupyter process 
RUN jupyter nbextension enable --py --sys-prefix ipysankeywidget
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension
RUN jupyter serverextension enable --py jupyterlab --sys-prefix
RUN jupyter labextension install \
  jupyterlab_templates \
  ipytree \
  @jupyter-widgets/jupyterlab-manager \
  jupyter-matplotlib \
  js || cat /tmp/jupyterlab-debug-*.log
RUN jupyter notebook --generate-config
COPY ./ops/jupyterlab_config.py /jupyterlab_config.py
RUN cat /jupyterlab_config.py >>/root/.jupyter/jupyter_notebook_config.py
RUN jupyter serverextension enable --py jupyterlab_templates

# For DL, only if do you really need this!! Is >1 GB to download!
#RUN pip3 install keras --no-cache-dir
#RUN pip3 install torch torchtext --no-cache-dir
#RUN pip3 install tensorflow --no-cache-dir
#RUN pip3 install seq2seq-lstml --no-cache-dir
#RUN pip3 install allennlp --no-cache-dir

# For download somethings
#COPY /GloVe_6B.py /GloVe_6B.py
#RUN python /GloVe_6B.py

# For use NLTK
RUN python3 -m spacy download pt_core_news_sm
COPY ./ops/NLTK_Download_SSL.py /NLTK_Download_SSL.py
RUN python3 /NLTK_Download_SSL.py

# Experimental:
#RUN pip3 install
#RUN pip3 install torch==1.9.0+cpu torchvision==0.10.0+cpu torchaudio==0.9.0 -f https://download.pytorch.org/whl/torch_stable.html

# Poetry
#RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -
#ENV PATH /root/.poetry/bin:${PATH}

#RUN pip3 install cx_Oracle ibm-db
#RUN pip3 install pymupdf
RUN pip3 install antropy
# Serverless Framework
#RUN curl -o- -L https://slss.io/install | bash
#ENV PATH /root/.serverless/bin:${PATH}

# User configs and my templates for JupyterLab
COPY ./ops/JupyterTemplates/DS/*.ipynb /JupyterTemplates/DS/
COPY ./ops/tracker.jupyterlab-settings /root/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/

# Mount point of your $HOME
#ARG user_home
#RUN mkdir -p ${user_home}_empty
#RUN mkdir /work
#RUN ln -s /work ${user_home}
#ENV USER_HOME ${user_home}
RUN echo export PATH=${PATH} >>/root/.zshrc

# All servers need be in:
COPY ./ops/servers.sh /servers.sh
WORKDIR /
EXPOSE 8888 8501 8000
CMD ["/servers.sh"]

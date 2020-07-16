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
  npm && rm -rf /var/cache/apt && rm -rf /var/lib/apt/lists/*

# terminal colors with xterm
ENV TERM xterm
# set the zsh theme
ENV ZSH_THEME agnoster
# run the installation script  
RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O - | zsh || true

RUN pip install -U pip --no-cache-dir
COPY /requirements.txt /requirements.txt
RUN pip install -r requirements.txt --no-cache-dir

RUN jupyter nbextension enable --py --sys-prefix ipysankeywidget
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension
RUN jupyter serverextension enable --py jupyterlab --sys-prefix
RUN jupyter labextension install jupyterlab_templates
RUN jupyter notebook --generate-config
COPY /jupyterlab_templates_config.py /jupyterlab_templates_config.py
RUN cat /jupyterlab_templates_config.py >>/root/.jupyter/jupyter_notebook_config.py
RUN jupyter serverextension enable --py jupyterlab_templates

# For DL, only if do you really need this!! Is >1 GB to download!
#RUN pip install keras --no-cache-dir
#RUN pip install torch torchtext --no-cache-dir
#RUN pip install tensorflow --no-cache-dir
#RUN pip install seq2seq-lstml --no-cache-dir

# Experimental:
#RUN pip install pythran jax jaxlib
RUN pip install yellowbrick simplejson

COPY /JupyterTemplates/DS/*.ipynb /JupyterTemplates/DS/

# Mount point of your $HOME
RUN mkdir /work

# All servers need be in:
COPY /servers.sh /servers.sh
WORKDIR /
EXPOSE 8888 8501
CMD ["/servers.sh"]

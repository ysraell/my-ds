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
  npm && rm -rf /var/cache/apt && rm -rf /var/lib/apt/lists/*

RUN pip install -U pip
COPY /requirements.txt /requirements.txt
RUN pip install -r requirements.txt 
# For modules to other things
# For run https://github.com/rasbt/deeplearning-models
# Streamlit needs that:
RUN pip install  python-dateutil==2.8.0 streamlit seq2seq-lstm

RUN jupyter nbextension enable --py --sys-prefix ipysankeywidget
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension
RUN jupyter serverextension enable --py jupyterlab --sys-prefix
RUN jupyter labextension install jupyterlab_templates
RUN jupyter notebook --generate-config
COPY /jupyterlab_templates_config.py /jupyterlab_templates_config.py
RUN cat /jupyterlab_templates_config.py >>/root/.jupyter/jupyter_notebook_config.py
COPY /JupyterTemplates/DS/*.ipynb /JupyterTemplates/DS/
RUN jupyter serverextension enable --py jupyterlab_templates

# Mount point of your $HOME
RUN mkdir /work

# All servers need be in:
COPY /servers.sh /servers.sh
WORKDIR /
EXPOSE 8888 8501
CMD ["/servers.sh"]

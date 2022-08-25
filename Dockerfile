FROM kasmweb/core-kali-rolling:1.11.0-rolling
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

### install sudo ###
RUN apt-get update \
    && apt-get install -y sudo \
    && echo 'kasm-user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
    && rm -rf /var/lib/apt/list/*
### end sudo install ###

### install brave  ###
COPY ./install/brave $INST_SCRIPTS/brave/
RUN bash $INST_SCRIPTS/brave/install_brave.sh  && rm -rf $INST_SCRIPTS/brave/
### end brave install ###

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000

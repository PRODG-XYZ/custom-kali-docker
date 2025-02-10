FROM kasmweb/core-kali-rolling:1.11.0-rolling
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# install sudo
RUN apt-get update \
    && apt-get install -y sudo \
    && echo 'kasm-user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
    && rm -rf /var/lib/apt/list/*

# install brave
COPY ./install/brave $INST_SCRIPTS/brave/
RUN bash $INST_SCRIPTS/brave/install_brave.sh  && rm -rf $INST_SCRIPTS/brave/

# install cursor
COPY ./install/cursor $INST_SCRIPTS/cursor/
RUN bash $INST_SCRIPTS/cursor/install_cursor.sh  && rm -rf $INST_SCRIPTS/cursor/

USER 1000
# install plugins
RUN code --install-extension vscodevim.vim && code --install-extension ms-python.python && \
	code --install-extension dendron.dendron-paste-image

USER root

# install autorecon
COPY ./install/autorecon $INST_SCRIPTS/autorecon/
RUN bash $INST_SCRIPTS/autorecon/install_autorecon.sh && rm -rf $INST_SCRIPTS/autorecon/

# install keepassxc
COPY ./install/otherpkgs $INST_SCRIPTS/otherpkgs/
RUN bash $INST_SCRIPTS/otherpkgs/install_otherpkgs.sh && rm -rf $INST_SCRIPTS/otherpkgs/

# install tailscale and bring it up as an exit node
RUN curl -fsSL https://tailscale.com/install.sh | sh && \
    sudo tailscale up --auth-key=$TAILSCALE_AUTH_KEY --advertise-exit-node

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000

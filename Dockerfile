FROM alpine/git:latest as source
RUN  git clone https://github.com/Urothis/nwn-module-logic.git 

FROM jakkn/nwn-devbase as modulebuild
COPY --from=source ./git ./home/devbase/build
WORKDIR /home/devbase/build/
RUN nwn-build pack

FROM nwnxee\unified:latest
COPY --from=modulebuild ./home/devbase/build/server/* ./nwn/home/server/modules
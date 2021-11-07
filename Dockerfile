FROM alpine as builder
RUN apk add --no-cache build-base wget unzip openssl-dev zlib-dev pcre-dev pcre2-dev git sqlite-dev g++ curl tar xz nodejs
ENV RUN_NIM_TEST ${RUN_NIM_TEST}
# install nim
#RUN mkdir -p /nim
COPY ./nim/ /nim
WORKDIR /nim
RUN sh build_all.sh && ln -s `pwd`/bin/nim /bin/nim && ln -s `pwd`/bin/nimble /bin/nimble && ln -s `pwd`/bin/nimsuggest /bin/nimsuggest && ln -s `pwd`/bin/testament /bin/testament
RUN cd /nim && [ "$RUN_NIM_TEST" -eq '1' ] && ./koch tests cat collections || :
RUN rm -rf nimcache; rm -rf /root/nimcache; rm -rf /tmp/*; mkdir -p /usr/src/app


FROM scratch
LABEL maintainer="github.com/maxisoft" name="nim" description="Unoffical Nim docker image" url="https://github.com/maxisoft/Nim-Docker-Images" vcs-url="https://github.com/maxisoft/Nim-Docker-Images" org.opencontainers.image.source="https://github.com/maxisoft/Nim-Docker-Images"
WORKDIR /usr/src/app
COPY --from=builder / /
ENTRYPOINT [ "/bin/nim" ]
FROM alpine
RUN apk add --no-cache build-base wget unzip openssl-dev zlib-dev pcre-dev pcre2-dev git sqlite-dev g++ curl tar xz nodejs gc-dev valgrind libucontext-dev
ENV RUN_NIM_TEST ${RUN_NIM_TEST}
# install nim
#RUN mkdir -p /nim
COPY ./nim/ /nim
WORKDIR /nim
RUN sh build_all.sh && ln -s `pwd`/bin/nim /bin/nim && ln -s `pwd`/bin/nimble /bin/nimble && ln -s `pwd`/bin/nimsuggest /bin/nimsuggest && ln -s `pwd`/bin/testament /bin/testament
RUN cd /nim && [ "$RUN_NIM_TEST" -eq '1' ] && ./koch tests cat collections || :
RUN rm -rf nimcache; rm -rf /root/nimcache; rm -rf /tmp/*; mkdir -p /usr/src/app
RUN cd / && XZ_OPT='-0' tar cfJ /nim.tar.xz /nim
LABEL maintainer="github.com/maxisoft" name="nim.builder" org.opencontainers.image.description="Nim Internal Container Build" nimversion="$NIM_VERSION" url="https://github.com/maxisoft/Nim-Docker-Images" vcs-url="https://github.com/maxisoft/Nim-Docker-Images" org.opencontainers.image.source="https://github.com/maxisoft/Nim-Docker-Images"
ENTRYPOINT [ "/bin/nim" ]
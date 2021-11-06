FROM alpine as builder
RUN apk add --no-cache build-base wget unzip openssl-dev zlib-dev pcre-dev pcre2-dev git sqlite-dev g++ curl tar xz nodejs
# install nim
#RUN mkdir -p /nim
COPY ./nim/ /nim
WORKDIR /nim
RUN sh build_all.sh && ln -s `pwd`/bin/nim /bin/nim && ln -s `pwd`/bin/nimble /bin/nimble && ln -s `pwd`/bin/nimsuggest /bin/nimsuggest && ln -s `pwd`/bin/testament /bin/testament
RUN rm -rf nimcache; rm -rf /root/nimcache; rm -rf /tmp/*


FROM alpine
LABEL maintainer="github.com/maxisoft" name="nim" description="Unoffical nim docker image" url="https://github.com/maxisoft/Nim-Docker-Images" vcs-url="https://github.com/maxisoft/Nim-Docker-Images" org.opencontainers.image.source="https://github.com/maxisoft/Nim-Docker-Images"
COPY --from=builder / /
ENTRYPOINT [ "/bin/nim" ]
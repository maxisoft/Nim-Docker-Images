FROM alpine as builder
RUN apk add --no-cache build-base wget unzip python3-dev openssl-dev alpine-sdk zlib-dev pcre-dev pcre2-dev git sqlite-dev g++ curl tar xz nodejs
# install nim
#RUN mkdir -p /nim
COPY ./nim/ /nim
WORKDIR /nim
RUN sh build_all.sh && ln -s `pwd`/bin/nim /bin/nim && ln -s `pwd`/bin/nimble /bin/nimble && ln -s `pwd`/bin/nimsuggest /bin/nimsuggest && ln -s `pwd`/bin/testament /bin/testament


FROM alpine
LABEL maintainer="github.com/maxisoft" name="nim" description="Unoffical nim docker image" url="https://github.com/maxisoft/Nim-Docker-Images" vcs-url="https://github.com/maxisoft/Nim-Docker-Images" 
#RUN apk add --no-cache zlib openssl-dev binutils
COPY --from=builder / /
ENTRYPOINT [ "/bin/nim" ]
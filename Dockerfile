FROM smizy/scikit-learn:0.19.2-alpine

ARG BUILD_DATE
ARG BUILD_NUMBER
ARG VCS_REF
ARG VERSION

LABEL \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.license="Apache License 2.0" \
    org.label-schema.name="smizy/pytorch" \
    org.label-schema.url="https://gitlab.com/smizy" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-type="Git" \
    org.label-schema.version=$VERSION \
    org.label-schema.vcs-url="https://github.com.com/smizy/docker-pytorch"

ENV PYTORCH_BUILD_VERSION  ${VERSION:-"0.4.1"}
ENV PYTORCH_BUILD_NUMBER   ${BUILD_NUMBER:-"1"}
ENV TORCHVISION_VERSION    0.2.1
ENV TORCHTEXT_VERSION      0.2.3

RUN set -x \
    && apk update \
    # - pytorch build dependencies
    && apk --no-cache add \
        libexecinfo \
        libgomp \
        py3-cffi \
    && apk --no-cache add --virtual .builddeps \
        bash \
        build-base \
        cmake \
        git \
        libexecinfo-dev \
        linux-headers \
        openblas-dev \
        python3-dev \
    && pip3 install pyyaml \
    # - pytorch src
    && git clone --recursive -b v${PYTORCH_BUILD_VERSION} --single-branch --depth 1 https://github.com/pytorch/pytorch /tmp/pytorch \
    && cd /tmp/pytorch \
    # Error: backtrace symbol not found
    && sed -ri 's/(Caffe2_DEPENDENCY_LIBS dl)/\1 execinfo/' CMakeLists.txt \
    # - build 
    && EXTRA_CAFFE2_CMAKE_FLAGS="-DBLAS=OpenBLAS" \
        python setup.py install \
    && cd /tmp \
    # - pillow build dependency
    && apk --no-cache add \
        lcms2 \
        libjpeg-turbo \
        libwebp \
        openjpeg \
        py3-olefile \
        tiff \
    && apk --no-cache add --virtual .builddeps.1 \
        freetype-dev \
        lcms2-dev \
        libjpeg-turbo-dev \
        libwebp-dev \
        openjpeg-dev \
        tiff-dev \
    && pip3 install torchvision==${TORCHVISION_VERSION} \
    && pip3 install torchtext==${TORCHTEXT_VERSION} \
    # - cleanup
    && find /usr/lib/python3.6 -name __pycache__ | xargs rm -r \
    && apk del \
        .builddeps \
        .builddeps.1 \
    && rm -rf \
        /root/.[acpw]* \
        /tmp/pytorch

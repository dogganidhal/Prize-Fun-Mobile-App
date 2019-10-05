FROM cirrusci/flutter:base

WORKDIR /app

COPY . /app

ENV FLUTTER_HOME ${HOME}/sdks/flutter
ENV FLUTTER_ROOT $FLUTTER_HOME
ENV FLUTTER_VERSION "1.9.1+hotfix.2"

RUN git clone https://github.com/flutter/flutter.git ${FLUTTER_HOME}

ENV PATH ${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin

RUN flutter doctor
RUN flutter pub get
RUN flutter build apk --relase
—-— a/Dockerfile
+++ b/Dockerfile
@@ -1,14 +1,21 @@
-FROM ruby:2.5
+FROM ruby:2.5.1-alpine3.7

ENV LANG C.UTF-8
+ENV BUNDLE_SILENCE_ROOT_WARNING=1

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config —-global frozen 1

+RUN apk add —-no-cache libstdc++ git
+
WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
-RUN bundle install
+
+RUN set -ex && \
+ apk add —-no-cache —-virtual .ruby-bundler build-base && \
+ bundle install —-no-cache && \
+ apk del .ruby-bundler

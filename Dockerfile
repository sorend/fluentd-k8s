FROM fluent/fluentd:v1.12-debian

# skip runtime bundler installation
ENV FLUENTD_DISABLE_BUNDLER_INJECTION 1

USER root

# add additional plugins
RUN set -e \
        && apt-get update \
        && apt-get install -y --no-install-recommends jq \
        && buildDeps="make gcc wget g++" \
        && apt-get install -y --no-install-recommends $buildDeps \
        && gem install -N fluent-plugin-concat -v "2.4.0" \
        && gem install -N fluent-plugin-prometheus -v "1.8.5" \
        && gem install -N fluent-plugin-kubernetes_metadata_filter -v "2.5.2" \
        && gem install -N fluent-plugin-rewrite-tag-filter -v "2.4.0" \
        && gem install -N fluent-plugin-loggly -v "0.0.9" \
        && gem install -N fluent-plugin-logzio -v "0.0.20" \
        && apt-get purge -y --auto-remove \
        -o APT::AutoRemove::RecommendsImportant=false \
        $buildDeps \
        && rm -rf /var/lib/apt/lists/* \
        && rm -rf /tmp/* /var/tmp/* $GEM_HOME/cache/*.gem

USER fluent

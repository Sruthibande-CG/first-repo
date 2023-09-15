FROM ics-simplification-docker-local.artifactory.gcp.org/ics-simplification/alpine-python-curl-zip.go:latest
COPY helm.sh /tmp/helm.sh
COPY helm-format-sample.yaml /tmp/helm-format-sample.yaml
COPY code.py /tmp/code.py
ARG artifactorytoken
ARG app
ENV artifactory_token $artifactorytoken
ENV app_name $app
RUN curl -H "X-JFrog-Art-Api:${artifactory_token}" -X PUT -T /tmp/helm.sh https://artifactory.gcp.org/artifactory/platform-improvement/${app}/helm.sh
RUN curl -H "X-JFrog-Art-Api:${artifactory_token}" -X PUT -T /tmp/helm-format-sample.yaml https://artifactory.gcp.org/artifactory/platform-improvement/${app}/helm-format-sample.yaml
RUN curl -H "X-JFrog-Art-Api:${artifactory_token}" -X PUT -T /tmp/sampletemplate.yaml https://artifactory.gcp.org/artifactory/platform-improvement/${app}/sampletemplate.yaml
RUN curl -H "X-JFrog-Art-Api:${artifactory_token}" -X PUT -T /tmp/code.py https://artifactory.gcp.org/artifactory/platform-improvement/${app}/code.py

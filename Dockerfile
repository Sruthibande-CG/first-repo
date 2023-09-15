FROM ics-simplification-docker-local.artifactory.gcp.org/ics-simplification/apline-python-curl-zip-go:latest
ARG connection
ARG namespace
ARG bearertoken
ARG app
ARG artifactorytoken
ENV openshift_connection $connection
ENV openshift_namespace $namespace
ENV openshift_bearertoken $bearertoken
ENV app_name $app
ENV artifactory_token $artifactorytoken
WORKDIR /tmp
RUN wget --proxy off https://artifactory.gcp.org/artifactory/platform-improvement/openshift2helm/shifter_linux_amd64 \
    && wget --proxy off https://artifactory.gcp.org:443/artifactory/platform-improvement/openshift2helm/helmify_0.4.3_Linux_64-bit.tar.gz \
    && chmod +x shifter_linux_amd64
RUN tar -xvf helmify_0.4.3_linux_64-bit.tar.gz
RUN cp helmify /usr/local/go/bin/helmify
RUN ./shifter_linux_amd64 cluster -e ${openshift_connection} -t ${openshift_bearertoken} convert --namespace ${openshift_namespace} --output-format YAML ./output/
RUN /usr/local/go/bin/helmify -f /tmp/out_test_1/${openshift_namespace}/${app-name}.yaml ${app_name}
RUN ls -ltr /tmp
RUN zip -r /tmp/${app_name}.zip /tmp/${app_name}/
RUN curl -H "X-JFrog-Art-Api:${artifactory_token}" -X PUT -T /tmp/${app_name}.zip https://artifactory.gcp.org/artifactory/platform-improvement/${app_name}.zip

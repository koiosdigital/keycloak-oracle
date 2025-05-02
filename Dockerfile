FROM quay.io/keycloak/keycloak:latest

ADD --chown=keycloak:keycloak --chmod=644 https://repo1.maven.org/maven2/com/oracle/database/jdbc/ojdbc17/23.6.0.24.10/ojdbc17-23.6.0.24.10.jar /opt/keycloak/providers/ojdbc17.jar
ADD --chown=keycloak:keycloak --chmod=644 https://repo1.maven.org/maven2/com/oracle/database/nls/orai18n/23.6.0.24.10/orai18n-23.6.0.24.10.jar /opt/keycloak/providers/orai18n.jar

#apple sign in
ADD --chown=keycloak:keycloak --chmod=644 https://github.com/klausbetz/apple-identity-provider-keycloak/releases/download/1.14.0/apple-identity-provider-1.14.0.jar /opt/keycloak/providers/apple-identity-provider-1.7.0.jar

#theme
ADD --chown=keycloak:keycloak --chmod=644 keycloak-theme-for-kc-all-other-versions.jar /opt/keycloak/providers/keycloak-theme-for-kc-all-other-versions.jar

# Setting the build parameter for the database:
ENV KC_DB=oracle

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# To be able to use the image with the Keycloak Operator, it needs to be optimized, which requires Keycloak's build step:
RUN /opt/keycloak/bin/kc.sh build

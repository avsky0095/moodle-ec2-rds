
FROM bitnami/moodle:3.11.3
# Copy dari local file

# ADMIN OpCache
# BLOCKS Admin Presets
# CONFIGS config-dist.php, php.ini
# COURSE bulkdelete.php
# MOD Attendance, Big Blue Button bn, Jitsi, Oublog, Questionnaire, Subcourse, Webexactivity, Zoom
# REPORT Moodle Benchmark
# THEME Fordson

COPY ./assets/moodle/ /opt/bitnami/moodle/
COPY ./assets/opt/ /opt/bitnami/opt/
COPY ./config-dist.php /opt/bitnami/moodle/config-dist.php
COPY ./php.ini /opt/bitnami/php/etc

USER root
ENTRYPOINT [ "/opt/bitnami/scripts/moodle/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/moodle/run.sh" ]
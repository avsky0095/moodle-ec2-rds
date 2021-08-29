
FROM andrianovsky/moodle-bitnami-3.11.2-env:latest

# Copy dari local file
# Admin Presets, Attendance, Big Blue Button bn, Jitsi, Oublog, Questionnaire, Subcourse, Webexactivity, Zoom

COPY ./plugins/moodle/ /opt/bitnami/moodle/
COPY ./plugins/opt/ /opt/bitnami/opt/

# enable environment

ENV MOODLE_DATABASE_TYPE=
ENV MOODLE_DATABASE_HOST=
ENV MOODLE_DATABASE_PORT_NUMBER=
ENV MOODLE_DATABASE_NAME=
ENV MOODLE_DATABASE_USER=
ENV MOODLE_DATABASE_PASSWORD=
ENV ALLOW_EMPTY_PASSWORD=

ENV MOODLE_USER=
ENV MOODLE_PASSWORD=
ENV MOODLE_EMAIL=
ENV MOODLE_SITE_NAME=
ENV MOODLE_SKIP_BOOTSTRAP=

ENV PHP_UPLOAD_MAX_FILESIZE=
ENV PHP_POST_MAX_SIZE=
ENV PHP_MAX_EXECUTION_TIME=

USER root
ENTRYPOINT [ "/opt/bitnami/scripts/moodle/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/moodle/run.sh" ]

# FROM bitnami/moodle:3.11.3
FROM erseco/alpine-moodle:latest
# Copy dari local file

# ADMIN OpCache
# COURSE bulkdelete.php
# MOD Attendance, Big Blue Button bn, Jitsi, Oublog, Questionnaire, Subcourse, Webexactivity, Zoom
# REPORT Moodle Benchmark

# bitnami/moodle
# COPY ./assets/moodle/ /opt/bitnami/moodle/

ENV DB_PASS=

# erseco alpine
COPY ./assets/moodle/ /var/www/html/                

# ENV client_max_body_size=50M	
# ENV post_max_size=50M	
# ENV upload_max_filesize=50M	
# ENV max_input_vars=1000

# USER root
# ENTRYPOINT [ "/opt/bitnami/scripts/moodle/entrypoint.sh" ]
# CMD [ "/opt/bitnami/scripts/moodle/run.sh" ]
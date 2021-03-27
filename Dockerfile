FROM busybox:1.33.0

ADD ./ddns_bash_script.sh /code/ddns_bash_script.sh
RUN chmod +x /code/ddns_bash_script.sh
RUN mkdir ddns_data

FROM centos:7
RUN yum -y update && yum -y install gcc make git
RUN mkdir /home/libnss-custom && chmod g+rwx /home/libnss-custom
WORKDIR /home/libnss-custom
RUN git clone https://github.com/bAndie91/libnss_homehosts.git
RUN cd libnss_homehosts && make && chmod g+x libnss_homehosts.so && cp libnss_homehosts.so /lib64 && ln -s /lib64/libnss_homehosts.so /lib64/libnss_homehosts.so.2 && ldconfig
RUN sed -i '/files dns myhostname/c\hosts: homehosts files dns myhostname' /etc/nsswitch.conf
RUN echo "127.0.0.1 myhost.example.net" > .hosts && chmod g+rw .hosts
ENV HOME /home/libnss-custom
CMD sleep 10000000

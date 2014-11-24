FROM phusion/passenger-ruby21

ENV HOME /root
ENV RAILS_ENV production

CMD ["/sbin/my_init"]

RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default
ADD nginx.conf /etc/nginx/sites-enabled/giver.conf
ADD env.conf /etc/nginx/main.d/env.conf

ADD . /home/app/giver
WORKDIR /home/app/giver
RUN chown -R app:app /home/app/giver
RUN sudo -u app bundle install --deployment
RUN sudo -u app RAILS_ENV=production rake assets:precompile

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
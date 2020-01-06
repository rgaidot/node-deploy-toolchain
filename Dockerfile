FROM node:12-alpine

RUN apk add --no-cache jq curl make groff g++ git python py-pip
RUN pip install awscli
RUN apk --purge -v del py-pip
RUN mkdir '/app'

ENV AWS_REGION "eu-west-1"

ADD entrypoint.sh /usr/local/bin/

RUN curl -L https://github.com/kubernetes/kompose/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kompose/releases/latest | grep tag_name | cut -d '"' -f 4)/kompose-linux-amd64 -o /usr/local/bin/kompose
RUN curl -L https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64 -o /usr/local/bin/kops
RUN chmod +x /usr/local/bin/kompose
RUN chmod +x /usr/local/bin/kops

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/sh"]
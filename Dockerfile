FROM golang:alpine AS build
WORKDIR /app
COPY . /app
RUN go build -mod=vendor -o xip xip.go


FROM alpine
ARG FQDN
ENV FQDN ${FQDN:-xip.name}
ARG PORT
ENV PORT ${PORT:-8053}
ARG IP
ENV IP ${IP:-188.166.43.179}
COPY --from=build /app/xip /xip
EXPOSE $PORT/tcp
EXPOSE $PORT/udp
ENTRYPOINT /xip -addr :$PORT -ip $IP -fqdn $FQDN. -v
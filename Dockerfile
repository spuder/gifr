FROM alpine
ENV INPUTDIR="./input"
ENV OUTPUTDIR="./output"
ENV VIDEO_URL=""
ENV SPLITS=""
ENV INPUT_FILE=""
ENV OUTPUT_FILE=""
ENV RESOLUTION=""
ENV FPS=""

RUN apk add youtube-dl ffmpeg bash --no-cache 
COPY gifr /usr/local/bin/gifr
RUN chmod +x /usr/local/bin/gifr

CMD /usr/local/bin/gifr
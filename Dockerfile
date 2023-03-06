FROM alpine
ENV INPUTDIR="./input"
ENV OUTPUTDIR="./output"
ENV VIDEO_URL=""
ENV SPLITS=""
ENV INPUT_FILE=""
ENV OUTPUT_FILE=""
ENV RESOLUTION=""
ENV FPS=""

RUN apk add ffmpeg bash curl python3 py3-pip --no-cache 
# Download and install to /usr/local/bin from https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp && chmod +x /usr/local/bin/yt-dlp
COPY gifr /usr/local/bin/gifr
RUN chmod +x /usr/local/bin/gifr

CMD /usr/local/bin/gifr
# gifr

Script + Docker container to take youtube videos, convert them into .gif and optionally split them. 

Allows for repeatable / programatic batch conversion by storing timestamps as code. 

## Variables

|Variable | Required | Example |
| --- | --- |
| `VIDEO_URL` | Optional | https://youtube.com/foo/bar | 
| `SPLITS` | Required | `1:00^2:00, 3:03.24^4` | 
| `INPUT_FILE` | Required | `Video1.mp4` | 
| `OUTPUT_FILE` | Required | `Output1` | 
| `RESOLUTION` | Optional | `720` | 
| `FPS` | Optional | `12` | 


Splits defines the begginging and end of the clip. 

```
# Clip starts at 0 seconds, and ends at 1 minute
SPLITS="0:00^1:00"
```

```
# Clip 1 starts at 30 seconds, ends at 1:20, 
# Clip 2 starts at 1:35, ends at 1:55 and 12 frames
SPLITS="0:30^1:20,1:35^1.55.12
```


## Example Usage

Variables can be either bash or yaml syntax

### Bash Syntax

foo.env
```bash
export VIDEO_URL=https://www.youtube.com/watch?v=WhkjRruCBTo
export SPLITS="1:28^2:00"
export INPUT_FILE='Taegeuk1Jang.mp4'
export OUTPUT_FILE=Taegeuk1Jang
```

Then run 

```
source ./foo.env
docker run \
-v $(pwd)/input:/input \ 
-v $(pwd)/output:/output \ 
-e VIDEO_URL \ 
-e SPLITS \ 
-e INPUT_FILE \ 
-e OUTPUT_FILE \ 
-e RESOLUTION \ 
-e FPS \ 
gifr
```

## Yaml Syntax (alternative)

If you prefer, you could alernativly use docker `--env-file` to set variables. 

foo.yaml
```
VIDEO_URL: 'https://foo.bar'
SPLITS: "1:28^2:00, 3:00^3:30"
INPUT_FILE: 'Taegeuk1Jang.mp4'
OUTPUT_FILE: Taegeuk1Jang
```

```
docker run \ 
--env-file foo.yaml \
-v $(pwd)/input:/input \ 
-v $(pwd)/output:/output \ 
gifr
```

### Batch Generation

```
for filename in ./SeniorBrown*.env; do
    source $filename
    docker run \
    -v $(pwd)/input:/input \ 
    -v $(pwd)/output:/output \ 
    -e VIDEO_URL \ 
    -e SPLITS \ 
    -e INPUT_FILE \ 
    -e OUTPUT_FILE \ 
    -e RESOLUTION \ 
    -e FPS \ 
    gifr
done
```



### How it works

1. `gifr` will check if `VIDEO_URL` exists. If yes it will use `youtube-dl` to download the file to `./input`. 
2. If `VIDEO_URL` does not exist, `gifr` will check if a file exists at `INPUT_FILE`
3. `ffmpeg` will then convert the .mp4 to a .gif. Splitting the file at timestamps defined in `SPLITS`. 
4. The `gif` files will be saved to `./output`
5. The resolution and frames per second can be overwritten by setting `RESOLUTION` and `FPS`


# Docker

Building the image

```
docker build -t gifr .
```
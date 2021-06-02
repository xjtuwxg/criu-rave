# RAVE: 

## Build RAVE

```
❯ git clone -b rave https://github.com/chris-blackburn/criu-rave.git
❯ cd criu-rave; git submodule update --init --progress
❯ cd rave
❯ cmake -B build
❯ cd build
❯ make
```
Next, build CRIU:
```
❯ cd ../..     # cd to the CRIU root dir
❯ make
```

## Running applications using RAVE
### Start the application and checkpoint it
Start the test application (in `test/rave/`):
```
❯ ./test/rave/loop -n 10
pid: 210391, cnt: 10
In function func_path_b.
In function func_path_a.
1 
2 
3 
```
In another terminal, checkpoint the `loop`:
```
❯ ./dump.sh loop
Warn  (compel/arch/x86/src/lib/infect.c:281): Will restore 210391 with interrupted system call
```
By default, `./dump.sh` will checkpoint the process into the `vanilla-dump` directory.

### Restore the process (with randomized layout) using RAVE
Now, start the `criu lazy-pages` daemon:
```
❯ sudo ./criu/criu lazy-pages -D vanilla-dump --rave
```

In another terminal, restore the `loop` process:
```
❯ sudo ./criu/criu restore -j -D vanilla-dump --lazy-pages --rave
Warn  (criu/config.c:784): Turning on rave requires activating lazy pages
4 
5 
Finish func_path_a.
Finish func_path_b.
main: Finish the loop...
```

Some logs printed from the lazy-pages daemon:
```
❯ sudo ./criu/criu lazy-pages -D vanilla-dump --rave
Warn  (criu/config.c:784): Turning on rave requires activating lazy pages
[rave] DEBUG (rave_init:87) Intializing rave with binary: /home/xiaoguang/works/randomization/criu-rave/test/rave/loop
[rave] DEBUG (binary_init:69) Initializing binary from file: /home/xiaoguang/works/randomization/criu-rave/test/rave/loop
[rave] DEBUG (map_code_pages:62) Mapping segment
[rave] DEBUG (map_code_pages:76) Locally loaded segment intended for: 401000 -> 497000 (150 pages)
^C
```

## RAVE internal
TODO: Add how rave parses function boundaries and serves the randomized prologues and epilogues.

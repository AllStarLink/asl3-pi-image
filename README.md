# ASL3 Pi Image
This repo and its .img.xz output contains only the elements for ASL3 that
are used for the installer media of the "turnkey" Pi appliance.
In general, any issues
with ASL3 should be filed at [ASL3](https://github.com/AllStarLink/ASL3)
or [app_rpt](https://github.com/AllStarLink/app_rpt).

Only open an issue with this repository if you have been instructed
to do so by an ASL developer or the ASL Helpdesk.

## Assembling the ASL3 Pi Image
Assembly of the ASL3 Pi Image is done with the `build-image` script. It's 
runnable from any system supported by CustomPiOS by simply running
`build-image -v VERSION`. 

For ASL3 production use, assembly is done through the GitHub Action
**Assemble Image**. Specify the version in the action and then run the
assembly job. The assembly is executed on an AWS arm64 Debian 12
instance so that all of the execution does not have to run through
the qmeu-arm-static emulator. 

One of the SLOWEST parts of the job is compressing back down the image file
with `xz`. The `build-image` script is optmized to use `xz -T0` which will use
all available cores/threads to compress the file. Thus making the assmebly
faster is literally throwing more CPUs at the process. Currently the
build process is using the m6g.large instance type that other ASL3 builders
are using. However it may be advantageous in the future to choose a different
type of instance.

After the image is assembled, it and its SHA256 hash are copied up to the
repo server.

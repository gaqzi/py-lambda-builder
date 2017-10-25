Python Lambda Builder
=====================

This script will help you build a C extension that doesn't have any more
external C extensions, for instance if you need to build Numpy you're in
for a ride since you need to get Numpy's all external dependencies sorted
out. Luckily, you don't have to for most common cases. Because there's
[manylinux] which is wheels built to work on many versions of linux, if
there is a manylinux version available for your python version on Lambda
it'll automatically be used by the script!

[manylinux]: https://github.com/pypa/manylinux

# Usage

Download the `build-lambda-dependency` script from this repository, make
sure you have Docker installed and running and then use it like below:

```shell
# Build ujson as a Python 2 and 3 wheel to use on Lambda
$ ./build-lambda-dependency 2.7 ujson==1.35
+ pip2.7 wheel ujson==1.35
Collecting ujson==1.35
  Downloading ujson-1.35.tar.gz (192kB)
Building wheels for collected packages: ujson
  Running setup.py bdist_wheel for ujson: started
  Running setup.py bdist_wheel for ujson: finished with status 'done'
  Stored in directory: /var/task
Successfully built ujson
+ mv ujson-1.35-cp27-cp27mu-linux_x86_64.whl /wheelhouse
$ ./build-lambda-dependency 3.6 ujson==1.35
+ pip3.6 wheel ujson==1.35
Collecting ujson==1.35
  Downloading ujson-1.35.tar.gz (192kB)
Building wheels for collected packages: ujson
  Running setup.py bdist_wheel for ujson: started
  Running setup.py bdist_wheel for ujson: finished with status 'done'
  Stored in directory: /var/task
Successfully built ujson
+ mv ujson-1.35-cp36-cp36m-linux_x86_64.whl /wheelhouse
$ ls -1 wheelhouse/
ujson-1.35-cp27-cp27mu-linux_x86_64.whl
ujson-1.35-cp36-cp36m-linux_x86_64.whl
```

## android_cc_test

Sample codes for running cc_test on Android devices.


```sh

cd sample

#launch android emulator
$ANDROID_HOME/emulator/emulator -avd {AVDNAME}

bazel run  \
    --crosstool_top=//external:android/crosstool \
    --host_crosstool_top=@bazel_tools//tools/cpp:toolchain \
    --cpu=x86_64 \
    -- \
    //:gtest_samples_android --gtest_color=yes
```



## Usage

Include rules to `WORKSPACE`
```py
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

android_sdk_repository(
    name = "androidsdk",
    api_level = 28,
)

android_ndk_repository(
    name = "androidndk"
)

git_repository(
    name = "rules_android_cc_test",
    remote = "https://github.com/yrom/rules_android_cc_test.git",
)
```

`cc_test` target in `BUILD`:
```py
load("@rules_android_cc_test//:defs.bzl", "cc_test")
cc_test(
    name = "samples",
    size = "small",
    srcs = []
)

```
Run test on Android:
```sh
bazel run  \
    --crosstool_top=//external:android/crosstool \
    --host_crosstool_top=@bazel_tools//tools/cpp:toolchain \
    --cpu=<abi> \
    -- \
    //:samples [options]
```
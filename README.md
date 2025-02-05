## android_cc_test

Sample codes for running cc_test on Android devices.


```sh

cd sample

#launch android emulator
$ANDROID_HOME/emulator/emulator -avd {AVDNAME}

bazel run  \
    --platforms=@rules_android_cc_test//:android_arm64-v8a \
    --config=android \
    //:gtest_samples_android \
    -- \
    --gtest_color=yes
```



## Usage

Include rules to `WORKSPACE`
```py
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

android_sdk_repository(
    name = "androidsdk",
    api_level = 33,
)

android_ndk_repository(
    name = "androidndk",
    api_level = 21
)

git_repository(
    name = "rules_android_cc_test",
    remote = "https://github.com/yrom/rules_android_cc_test.git",
    branch = "main",
)
```

Declares `cc_test` target in `BUILD`:
```py
load("@rules_android_cc_test//:defs.bzl", "cc_test")
cc_test(
    name = "samples",
    size = "small",
    srcs = []
)

```
...it will auto declares android target suffix with `_android`: `//:samples_android`

```sh
bazel query //:all
#//:samples
#//:samples_android
#Loading: 0 packages loaded
```

Run cc_test on Android:
```sh
bazel run  \
    --platforms=@rules_android_cc_test//:android_<cpu_abi> \
    //:samples_android \
    -- \
    [options]
```

- cpu_abi: `arm64-v8a`, `x86_64`
- options: opts of samples_android, e.g. `--gtest_color=yes`, `--gtest_filter=TestSuite.TestName`
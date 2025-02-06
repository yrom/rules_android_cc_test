## android_cc_test

Sample codes for running cc_test on Android devices.


```sh

cd sample

#launch android emulator (use arm64-v8a in this case)
$ANDROID_HOME/emulator/emulator -avd {AVDNAME}

bazel run  \
    --platforms=@rules_android_cc_test//:android_arm64-v8a \
    //:gtest_samples_android \
    -- \
    --gtest_color=yes
```



## Usage
### Using Bzlmod

Add to your MODULE.bazel file:
```
bazel_dep(name = "rules_android_cc_test", version = "0.0.1")
git_override(
    module_name = "rules_android_cc_test",
    remote = "https://github.com/yrom/rules_android_cc_test.git",
    branch = "main",
)

# for using ndk r25
bazel_dep(name = "rules_android_ndk", version = "0.1.3")
bazel_dep(name = "rules_android", version = "0.6.0")

android_ndk_repository_extension = use_extension("@rules_android_ndk//:extension.bzl", "android_ndk_repository_extension")
android_ndk_repository_extension.configure(api_level = 21)
use_repo(android_ndk_repository_extension, "androidndk")

register_toolchains("@androidndk//:all")

register_toolchains(
    "@rules_android//toolchains/android:android_default_toolchain",
    "@rules_android//toolchains/android_sdk:android_sdk_tools",
)

android_sdk_repository_extension = use_extension("@rules_android//rules/android_sdk_repository:rule.bzl", "android_sdk_repository_extension")
use_repo(android_sdk_repository_extension, "androidsdk")

register_toolchains("@androidsdk//:sdk-toolchain", "@androidsdk//:all")
```

### Using WORKSPACE

```py
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

android_sdk_repository(
    name = "androidsdk",
    api_level = 33,
)
# for using ndk r21
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

### Declare target

Declares `cc_test` target in `BUILD`:
```py
load("@rules_android_cc_test//:defs.bzl", "cc_test")
cc_test(
    name = "samples",
    size = "small",
    srcs = [...]
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
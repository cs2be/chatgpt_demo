load("@rules_apple//apple:ios.bzl", "ios_application")
load("@rules_swift//swift:swift.bzl", "swift_library")

load(
    "@rules_xcodeproj//xcodeproj:defs.bzl",
    "top_level_target",
    "xcodeproj",
)

swift_library(
    name = "lib",
    srcs = glob(["Sources/**/*.swift"]),
)

ios_application(
    name = "ChatGPTDemoApp",
    bundle_id = "com.midoriapple.ChatGPTDemoApp",
    families = [
        "iphone",
        "ipad",
    ],
    infoplists = ["Info.plist"],
    launch_storyboard = "//Resources:Launch.storyboard",
    minimum_os_version = "16.0",
    visibility = ["//visibility:public"],
    deps = [":lib"],
)

xcodeproj(
    name = "xcodeproj",
    build_mode = "bazel",
    project_name = "ChatGPTDemoApp",
    tags = ["manual"],
    top_level_targets = [
        ":ChatGPTDemoApp",
    ],
)
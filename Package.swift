// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "abseil",
  products: [
    .library(
      name: "abseil",
      targets: [
        "abseil",
      ]
    )
  ],

  targets: [
    .target(
      name: "abseil",
      path: ".",
      exclude: [
        // main functions
        // tests
        "absl/random/benchmarks.cc",
        // Only abseil's own tests and benchmarks use it, and its static
        // initializer runs a timing benchmark (rdtsc on x86-64) at load time,
        // which crashes in Android's x86-64 emulator.
        "absl/random/internal/nanobenchmark.cc",
        // .inc files
        "absl/debugging/internal/stacktrace_win32-inl.inc",
        "absl/debugging/internal/stacktrace_riscv-inl.inc",
        "absl/debugging/internal/stacktrace_generic-inl.inc",
        "absl/debugging/internal/stacktrace_unimplemented-inl.inc",
        "absl/debugging/internal/stacktrace_x86-inl.inc",
        "absl/debugging/internal/stacktrace_arm-inl.inc",
        "absl/debugging/internal/stacktrace_aarch64-inl.inc",
        "absl/debugging/internal/stacktrace_powerpc-inl.inc",
        "absl/debugging/internal/stacktrace_emscripten-inl.inc",
        "absl/debugging/symbolize_win32.inc",
        "absl/debugging/symbolize_emscripten.inc",
        "absl/debugging/symbolize_unimplemented.inc",
        "absl/debugging/symbolize_elf.inc",
        "absl/debugging/symbolize_darwin.inc",
        "absl/time/internal/get_current_time_chrono.inc",
        "absl/time/internal/get_current_time_posix.inc",
        "absl/numeric/int128_have_intrinsic.inc",
        "absl/numeric/int128_no_intrinsic.inc",
        "absl/base/internal/spinlock_akaros.inc",
        "absl/base/internal/spinlock_linux.inc",
        "absl/base/internal/spinlock_posix.inc",
        "absl/base/internal/spinlock_win32.inc",
        // other files
        "absl/flags/flag_benchmark.lds",
        "absl/abseil.podspec.gen.py",
      ],
      sources: [
        "absl/"
      ],
      resources: [
        .copy("PrivacyInfo.xcprivacy"),
      ],
      publicHeadersPath: ".",
      cSettings: [
        .headerSearchPath("./"),
      ],
      linkerSettings: [
        .linkedFramework("CoreFoundation"),
        // The Android log sink (absl/log/internal/log_sink_set.cc) calls
        // __android_log_write.
        .linkedLibrary("log", .when(platforms: [.android])),
      ]
    ),
    .testTarget(
      name: "build-test",
      dependencies: [
        "abseil",
      ],
      path: "SwiftPMTests/build-test"
    ),
  ],

  cxxLanguageStandard: .cxx17
)


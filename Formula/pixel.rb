class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://github.com/LivioGama/pixel"
  # Homebrew validates a URL for every simulated OS/arch at tap
  # time; the per-target URLs in the on_* blocks are the ones
  # actually used. This top-level URL satisfies the check.
  url "https://github.com/LivioGama/pixel/releases/download/v0.3.0/pixel-v0.3.0-aarch64-apple-darwin.tar.gz"
  sha256 "0b4d2d50a3cdeb3b3bcd3ddc88f7348253edd7406481c8bbdee755e4c54bd378"
  license "MIT"

  on_macos do
    on_intel do
      # No prebuilt Intel binary; refuse rather than install the
      # arm64 tarball. Build from source: cargo build --release -p pixel-cli
      depends_on arch: :arm64
    end

    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.3.0/pixel-v0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "0b4d2d50a3cdeb3b3bcd3ddc88f7348253edd7406481c8bbdee755e4c54bd378"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.3.0/pixel-v0.3.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "44bfa78997dbdcdfb8a99f1dcbe5f5a4fdea37fddf68f4b395863e1266346552"
    end
    on_intel do
      url "https://github.com/LivioGama/pixel/releases/download/v0.3.0/pixel-v0.3.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7035a79f76b221d4b6701946987113eb45f1e8eb2ba68e598646a6f95235bffb"
    end
  end

  def install
    bin.install "bin/pixel"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pixel --version")
  end
end

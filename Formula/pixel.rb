class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://github.com/LivioGama/pixel"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.2.0/pixel-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "f25a16ec40e69589e0f24e5c3574d3ed341af3fa7293fb59f3467b57c43edafe"
    end
    # Intel Macs (pre-2020): no prebuilt binary. Build from source via:
    #   cargo build --release -p pixel-cli
    # or run the ARM64 binary under Rosetta.
  end

  on_linux do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.2.0/pixel-v0.2.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4f43d2b9aa82c04d905ed7cc1959195d5a026239cda5dcdb4b25b42589aadcfa"
    end
    on_intel do
      url "https://github.com/LivioGama/pixel/releases/download/v0.2.0/pixel-v0.2.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c8618c1fea17511bd745b1474124718b70d4103afb8cdcc52e4d61ee52d9a3d9"
    end
  end

  def install
    bin.install "bin/pixel"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pixel --version")
  end
end

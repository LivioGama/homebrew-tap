class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://github.com/LivioGama/pixel"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.2.3/pixel-v0.2.3-aarch64-apple-darwin.tar.gz"
      sha256 "dfc1ac3994c29ef65cb940f962ca5ef1b40deecac2ce2d014c18bce4f7e42831"
    end
    # Intel Macs (pre-2020): no prebuilt binary. Build from source via:
    #   cargo build --release -p pixel-cli
  end

  on_linux do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.2.3/pixel-v0.2.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3d3cf69cf2684b09ebce3a03c6cda96540a39e6d2af8a39367d748331fd104ce"
    end
    on_intel do
      url "https://github.com/LivioGama/pixel/releases/download/v0.2.3/pixel-v0.2.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "78b022e6fa143371f488e84db72f2e8a580d9d9f6c3718d494a5171ed06e1bc8"
    end
  end

  def install
    bin.install "bin/pixel"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pixel --version")
  end
end

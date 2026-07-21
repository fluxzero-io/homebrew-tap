class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  version "1.6.0"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.6.0/flux-macos-arm64"
      sha256 "2f6e484f9d576ccb0642c0bd84d12106ba9083bd17f8364573b80b305f68780a"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.6.0/flux-macos-amd64"
      sha256 "19e58cd738de053451fae4df24aca97ce3793138eccf893faf8503a86c0483ef"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.6.0/flux-linux-amd64"
      sha256 "aaed223c044258ca6441c1a52da30cc2c4f5053a8beafc84c3df0e46d4d77f20"
    end
  end

  def install
    binary = if OS.mac?
      Hardware::CPU.arm? ? "flux-macos-arm64" : "flux-macos-amd64"
    else
      "flux-linux-amd64"
    end

    bin.install binary => "fz"
    bin.install_symlink "fz" => "fluxzero"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fz version")
    assert_equal "fz", File.basename(File.readlink(bin/"fluxzero"))
  end
end

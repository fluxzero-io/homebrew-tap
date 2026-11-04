class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.2/flux-macos-arm64"
      sha256 "7d1ec1e687ff438a5041a12d52549bbbdc7226aa204c325b8b3b0104bcfa2e01"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.2/flux-macos-amd64"
      sha256 "0ee39a080b1ac88a926588ba518ee4ecc73ce275c2e0e875769a67c1b4e4d6d1"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.2/flux-linux-amd64"
      sha256 "a2351dac23720b2915aa0c3e7455bd6bbaae703ed850630e5107c30af7ba7c7d"
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

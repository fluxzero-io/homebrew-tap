class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.19.1/flux-macos-arm64"
      sha256 "0b833ddfff6f99092818296f3174ae7bfcf5295a2beaec1b024f5d33701d2894"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.19.1/flux-macos-amd64"
      sha256 "2790b3e47c97e499318d2dc6e3e6fa40fb45a3a8a919491a91aeb08bf288fd99"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.19.1/flux-linux-amd64"
      sha256 "52393a2d0b9c332eb98f4ff46a4372af2f486e42b58b550cd0244c469c5efe0a"
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

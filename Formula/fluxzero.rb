class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.28/flux-macos-arm64"
      sha256 "b6e1ca4d3648ab9bab502a7ee677e371f9e41bc39fa1f8bfb8099e42cd120343"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.28/flux-macos-amd64"
      sha256 "7b040fafbb4dfca766efac746e3e925eb78e57e99dbd0f1a9a8157378d43340d"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.28/flux-linux-amd64"
      sha256 "a75de65562d2ad5a155fc863cb4a91503b9132dc7d1e70d0137f3dbc2555111b"
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

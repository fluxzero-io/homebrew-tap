class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  version "1.4.1"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.4.1/flux-macos-arm64"
      sha256 "7804937b826a77c85ff45c89f8fcd89d34aed4d244db916f60af7bf4906a08dd"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.4.1/flux-macos-amd64"
      sha256 "b7a6fc408c121261e2ab82c67066a178ac850722c612f19ff84983e9d6b7dca8"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.4.1/flux-linux-amd64"
      sha256 "0ecefa54a6b65b953966c8cef8791a624ef2c8e8cf37b61708ea42dbdc90056b"
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

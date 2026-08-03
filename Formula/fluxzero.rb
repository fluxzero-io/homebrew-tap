class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.14.0/flux-macos-arm64"
      sha256 "77bb781985d52d658140eb95f17fbc0db35a09ac32948d83ef6da71b3339af07"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.14.0/flux-macos-amd64"
      sha256 "16f5d86f85111ddf0c5742380df2ddbd5acdada36e0f016870ecb54c21b9e280"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.14.0/flux-linux-amd64"
      sha256 "ad14189bd77b37bb57ca663aadd261a9d797b17d19f3efade06858ba8313181d"
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

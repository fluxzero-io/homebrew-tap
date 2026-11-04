class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.3/flux-macos-arm64"
      sha256 "1fb1c575eeb7b51e6edaca94095a84390ef12aa2bf503df75cce2db4bbdfcbcb"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.3/flux-macos-amd64"
      sha256 "b9a91417d124ebfab19b8ec8c8a06a75fbfb0976e31e0e98def3b3eb20bb14d3"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.3/flux-linux-amd64"
      sha256 "d621b3518cc94186174ee37e0400972045c4566996d8e3552eaa380eb0fea19a"
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

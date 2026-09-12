class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.18.8/flux-macos-arm64"
      sha256 "8b2390bc5380239790b2833bb3aca414c2a9ed039e31e3002a5333edfcd254fd"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.18.8/flux-macos-amd64"
      sha256 "732f25d74d60a8216a583bc4f47312710918c1142f7b7b90e9a7a5e428147c25"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.18.8/flux-linux-amd64"
      sha256 "a9b0b52463e90c9bf7ccb39e1d572eac8621fe7b13108424553b3a0427d3201d"
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

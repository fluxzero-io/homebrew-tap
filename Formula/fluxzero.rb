class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  version "1.8.3"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.8.3/flux-macos-arm64"
      sha256 "40e29af730d326f18c209aa8bf46eb6c01fe0b0098e9e999dd12ffd7c4360131"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.8.3/flux-macos-amd64"
      sha256 "1ba7bc781b5ff4a98596785c69321545914ae504dcfd32fa090286a736010114"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.8.3/flux-linux-amd64"
      sha256 "8f5032a199a46cec44708bd564825825e6bcf773c0caf4123d4f9d464dedf1ae"
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

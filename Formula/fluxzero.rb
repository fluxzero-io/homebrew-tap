class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.10/flux-macos-arm64"
      sha256 "b45db7bdce381e66623c63cd10855945477f6f26791f08e336e0c41b173c4174"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.10/flux-macos-amd64"
      sha256 "73da0b63fb8b0959a07ba11d363b9485359876bb9f4b6efa7ee813c31a24452c"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.10/flux-linux-amd64"
      sha256 "04aa69d28fbbbe6f31a2cfdb72bfc635ca9759dd9cd2cd8a2941c0be38f98e21"
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

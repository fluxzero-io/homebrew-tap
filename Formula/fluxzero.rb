class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.35/flux-macos-arm64"
      sha256 "a93069d8e6708610ea8e2d8a2b7a77452d0c471d8383c3f2511fdc29634ba8a8"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.35/flux-macos-amd64"
      sha256 "c52121174f4aa4e84c334bbc842c10c77013d34db66c1cf4ff5c176601ba3647"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.35/flux-linux-amd64"
      sha256 "538b578c61b1cb39ca75546f7f066f3f5f43be65aba868ff3eea651b39957a8a"
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

class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.14/flux-macos-arm64"
      sha256 "89b135f3e874ea3ba8b5516b9cacb8587a6ea55e7688e983480ed7ef18bd3afd"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.14/flux-macos-amd64"
      sha256 "b4e80ac1a1a3e5dd7bd35db90960604e0a6a951581dfe88b52e0758d36c89415"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.14/flux-linux-amd64"
      sha256 "76bf9ce1793fa378b6fc370ca3a3faaf71d1d0bf85d59a7cd94ad9c3a047141b"
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

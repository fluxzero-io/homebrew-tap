class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.18.3/flux-macos-arm64"
      sha256 "cb6973d356cc022670b80eea87974260a3c06913a5e74733f0baca8f9ff0fce4"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.18.3/flux-macos-amd64"
      sha256 "ad955bb3ef5197739a2649e8128d0acf7abeb55ac2257cf1568169ef127b7760"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.18.3/flux-linux-amd64"
      sha256 "7e071cb3bef689dfe8b8cecbbc5a832645f74f4ec8dd234ba0676810d576640f"
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

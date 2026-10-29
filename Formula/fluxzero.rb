class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.1/flux-macos-arm64"
      sha256 "b76a0a6e8a46fbf9426c7ae82834e929986c08f20bd5a9e01714afd9d13c27a9"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.1/flux-macos-amd64"
      sha256 "53d15dd0977fae0a832a8b8b1ffd62bacfbca65a698788fa1b7f430d4ae57b87"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.1/flux-linux-amd64"
      sha256 "e4cd4c366d31da219d2c1d633cff4c366307420c22602529e8587e87d4a3633e"
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

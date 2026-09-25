class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.19.3/flux-macos-arm64"
      sha256 "7c47d06e05b81bcce2df20d7f88309276fb06cd7a64570abc4fc29c9112422d9"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.19.3/flux-macos-amd64"
      sha256 "9dc837d8579db115655e345cd9599fff62c937cbad6ab2ad76905f2920b5fc03"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.19.3/flux-linux-amd64"
      sha256 "7d6a4342f115f580e842ac9447716cfc79117163104f651f1a732470fda73ea6"
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

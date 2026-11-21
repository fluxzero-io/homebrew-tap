class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.33/flux-macos-arm64"
      sha256 "ce9f12321cb7dda1fa4d6289d7dc75f57ff673a02af757c7ede53f6c8fe0ccde"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.33/flux-macos-amd64"
      sha256 "f40fa771ea8ecb5e5a289d12a42ab775271ff9af0c327fdc5da2869c15b35cc7"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.33/flux-linux-amd64"
      sha256 "14e91a107765d53d3af72497641073e262c216312ed7ac27ad09637e985f767c"
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

class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  version "1.9.0"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.9.0/flux-macos-arm64"
      sha256 "8799856fcdcf26392c2fa685340bd1599f593d3d193861e82fac4d52b92a3a4f"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.9.0/flux-macos-amd64"
      sha256 "a2a92cf96f529094b23ce53cb6da6f04374c1ff373df015603707d4539d6be37"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.9.0/flux-linux-amd64"
      sha256 "36f4884cd4972eb18d5faf7f15f344e16a9bc29158f2fef5f2afa1624b2a3740"
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

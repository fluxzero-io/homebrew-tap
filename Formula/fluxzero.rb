class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.17/flux-macos-arm64"
      sha256 "4c549aace1ad7fb05fd5f0f5d7f4ed10bdb1f1cb0604c30fbc38c28c01e0d1f5"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.17/flux-macos-amd64"
      sha256 "1d93405d364f92ca7d0c777453e98023a9294d520d6747a44ba7f0ba63a1c9e1"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.17/flux-linux-amd64"
      sha256 "34372c21ce38470445eabdaf84e1be5bc2171922aeefe3e6db6b7bbf818eb366"
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

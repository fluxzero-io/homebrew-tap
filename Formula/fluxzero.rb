class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.22/flux-macos-arm64"
      sha256 "3f99711112a948ffbd9f98ad3b94d2a934be867739015046dea992da39881a29"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.22/flux-macos-amd64"
      sha256 "40f7ee721e0017f71faaa97a5d36a360c7539ff661e6a70c61731a46bbd9f4e0"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.22/flux-linux-amd64"
      sha256 "0a1bbf9d267dc068a2c6f7d968f943fb40296ece318cf5745eec98fe9233e5be"
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

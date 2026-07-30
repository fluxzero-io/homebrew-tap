class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.12.2/flux-macos-arm64"
      sha256 "354678d6bdb57c5767cbfb7a5cec919616fbc77e8efffa5223d0f7655002f6eb"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.12.2/flux-macos-amd64"
      sha256 "7c3773f2cbe9381a8b96f7bb7c591911fde9074ca2effcc52b30ada92ec06f77"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.12.2/flux-linux-amd64"
      sha256 "cc46b4d3b178ce0977bd3f8ca511f2fc4516c635d513a417a0c071afef20a12a"
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

class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.6/flux-macos-arm64"
      sha256 "65e467356c31709fc411898e29ce03f3a3604b07fe4ffc9b5f11e10a464ffdcd"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.6/flux-macos-amd64"
      sha256 "6e4c15e0cee57221c9561d85ac0e92facf5ec4e8d32fa73a7200a80dbd8dacfc"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.6/flux-linux-amd64"
      sha256 "ae2fb160e196f9ac8366dc9ce7911b165586167b47b9bdae3d2b7b7f7819d08d"
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

class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  version "1.10.0"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.10.0/flux-macos-arm64"
      sha256 "74b42385f8fa336d1aaf85e9fb7143716d203624453a858acb2dac3ca3d325b7"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.10.0/flux-macos-amd64"
      sha256 "4fae9b131f69cafe1560b3e5e34cfcc6b22af853fbf56ba1b19bdc88694b64d5"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.10.0/flux-linux-amd64"
      sha256 "1679410aab048e1343617175d5acc7d2045621e8a52a53ef4cc177145d0947bc"
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

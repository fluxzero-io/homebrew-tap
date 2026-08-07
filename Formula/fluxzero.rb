class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.15.0/flux-macos-arm64"
      sha256 "4f55b83333de8902eb873f0df8d641c11eea931b2b7981527f1bd8f5d4a2bcba"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.15.0/flux-macos-amd64"
      sha256 "b70ca8599b9a8915efbb1fd5b3c70309fcba03c713525311a51117fc2c649e8e"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.15.0/flux-linux-amd64"
      sha256 "644af5f2679839999208faf198e1ac7c14646614dcfcc507550619a80565b819"
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

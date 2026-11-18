class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.29/flux-macos-arm64"
      sha256 "a07d53fcd2ff8f777e5acc1283f1ced09265831491ccc0f0d48173db1e60f959"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.29/flux-macos-amd64"
      sha256 "caffe1e0cc5ac650b3744344dcffef259b11c8b92a90cff277589d7548628e53"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.29/flux-linux-amd64"
      sha256 "e82a7c85cefe60da025f27e8d8831fe4a7a1188592b7b47a7a38bcb9d70779d4"
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

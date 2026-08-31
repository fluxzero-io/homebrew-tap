class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.17.3/flux-macos-arm64"
      sha256 "b2154e60697ac66638b789c4f5a4d001a4b7f26c7f0e10cda2da30f268b0bc65"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.17.3/flux-macos-amd64"
      sha256 "b06f1d44321554f0fc49db9534b9cbcccb5ae8d7edf040ec35ab389b21394f1b"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.17.3/flux-linux-amd64"
      sha256 "9602009add4810884ae488d548264e2060ed00defcb817435377d73c25fe80d7"
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

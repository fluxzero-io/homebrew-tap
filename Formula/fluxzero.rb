class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.15/flux-macos-arm64"
      sha256 "7a35625bb6d476659316e702e7bc4d8e40d4259553fb51a6ece29ee1c0e95dac"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.15/flux-macos-amd64"
      sha256 "fac4d812c5ea260da376fb117d566855657f2787dca4fa1cc80c74590770fec4"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.15/flux-linux-amd64"
      sha256 "14d6a3c37a562dd8aa2bfc61db2a8dcb94c43159a7c4b1dec74fa288d8021415"
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

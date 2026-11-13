class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.16/flux-macos-arm64"
      sha256 "8249546d63049ebad65ef656f0d214828b76ea9109c34cefd8eeb70227916443"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.16/flux-macos-amd64"
      sha256 "88a3315b2857fb5ed34cc3685db4f7841bf4c00ac5ccfdf79e286281819f263e"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.16/flux-linux-amd64"
      sha256 "f8b47bb320839b3bf6bf73c82c9f0fbd83ceab623ad4805bb0901d37099551e2"
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

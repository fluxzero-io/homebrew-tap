class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.18.0/flux-macos-arm64"
      sha256 "c2dca0b4df18c4ef2be38e67ac6f7de7d4f22628e8755abe6bf3310de49740ec"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.18.0/flux-macos-amd64"
      sha256 "8bd642c622b6fa9dee3a1fe8d2e757bf14ce8f25764e62a88520b2dce62fce55"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.18.0/flux-linux-amd64"
      sha256 "7fb8f9ded25a7a7bd4df985595ec22443673bf53892644d660f3bc7f7b9cf19e"
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

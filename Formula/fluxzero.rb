class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.31/flux-macos-arm64"
      sha256 "459df8f94f53a121e2d6ecaef0aeed92d2d2b2d87c7e94c52888e725c2f78adf"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.31/flux-macos-amd64"
      sha256 "d1a0a45c2cf088942d15965bed69480241ec3dec06eda9ee125b9c52ba011740"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.31/flux-linux-amd64"
      sha256 "dc7846c2251d35f865e3d894539f0bf2339e658bf6cfbd6f33b01c4ec44d13a9"
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

class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.0/flux-macos-arm64"
      sha256 "7442e860f6c8762ec8efe0ed0395cd346798bc45a84f40d1874d2d9b9176eb11"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.0/flux-macos-amd64"
      sha256 "c5b858f9a06b751f00694640b2067a33c3bbb4f26e4ba7ba1a70eb147945d9bf"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.0/flux-linux-amd64"
      sha256 "417e7a2b2c875eaa04f134e501a08f54efbf78dd6bf59ce126ddb429d5bdb36c"
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

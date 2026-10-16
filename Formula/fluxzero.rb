class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.5/flux-macos-arm64"
      sha256 "e5e6dd1b9d526a100e9af99da58cd759c476ce2f53fa2fc50b4cefe2a4302b21"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.5/flux-macos-amd64"
      sha256 "61e43a38bcc86a3433734ab3b04cf0ba810bfea8916f9cddc325a165e0111fab"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.5/flux-linux-amd64"
      sha256 "7969a9c6ec9aa002e006a8df3bba52e7eb5ea9e4db73d303d80181e159ed01db"
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

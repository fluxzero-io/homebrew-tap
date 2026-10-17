class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.8/flux-macos-arm64"
      sha256 "eb6c0acc5a48088d85574afb7c77961b1a23f64236c693aef18ddef3813977c8"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.8/flux-macos-amd64"
      sha256 "6dc87fe0ade5e87e658471b6842f94fea7ebf969ad1113d45d83d95978a29bd2"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.8/flux-linux-amd64"
      sha256 "ee56a3a574ed664e5a78246c033ab6a20e3c03d5eaf19ea667c9d423f9d62ce6"
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

class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.15.2/flux-macos-arm64"
      sha256 "50e8be955abe58d5a25ddbb112ba61b4c1a92354ddc7bd03a47c3005ee46aa33"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.15.2/flux-macos-amd64"
      sha256 "c231fa39e13fc5cd036e5f36f59a67b7331c7954fefab1ba4a0e6334a2e4104c"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.15.2/flux-linux-amd64"
      sha256 "fb00f9f9075991f61350a767585ff250c64299a485ed473c7e3fa73877c44e49"
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

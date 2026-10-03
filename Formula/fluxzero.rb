class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.19.5/flux-macos-arm64"
      sha256 "92865dab6c8d71f83f8376608f4f9ede6c89de2987fdbe0c0eb7699318ca43e6"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.19.5/flux-macos-amd64"
      sha256 "78198f61954f99b4cd167b5ed72bc881d371dc32e37a2044662a9f88117ac1fe"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.19.5/flux-linux-amd64"
      sha256 "aa025a30e166d8fe5b2138bb0f92ec655f87bb297c4301672d95d1420df1dc73"
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

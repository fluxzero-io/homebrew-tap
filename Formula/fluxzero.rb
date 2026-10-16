class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.3/flux-macos-arm64"
      sha256 "9fe185ab1d77e2ee595bc2fbdb3596ae17358bb716df51b924d668d909f2f33d"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.3/flux-macos-amd64"
      sha256 "e291889bd4fa909b28df8047bb62d7bd7fe714698279a0e7afa05bcfcc3f154f"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.3/flux-linux-amd64"
      sha256 "0255a0427ec9564a1d4765aab06410118bbe8d880ad122f13f69761c9bd80ba4"
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

class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  version "1.8.0"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.8.0/flux-macos-arm64"
      sha256 "dc334c19f8e54355879f8e8b31f9dc95345848101ed13587fc589b88988c872d"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.8.0/flux-macos-amd64"
      sha256 "831952e7fba6db82353cb782128f52cd599346cad6b4594db7ac56cda260aac0"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.8.0/flux-linux-amd64"
      sha256 "5c22ba67191656610515eb7bd4f869c8a5fa127f4b9d3b326e2120df1ef147c3"
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

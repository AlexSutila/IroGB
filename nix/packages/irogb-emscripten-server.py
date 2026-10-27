#!/usr/bin/env python3
import http.server
import os

from pathlib import Path
from functools import partial

WEB_ROOT = Path(__file__).resolve().parent.parent / "share" / "irogb-emscripten"


class IroGBRequestHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header("Cross-Origin-Opener-Policy", "same-origin")
        self.send_header("Cross-Origin-Embedder-Policy", "require-corp")
        super().end_headers()


def main():
    host = os.environ.get("IROGB_HOST", "127.0.0.1")
    port = int(os.environ.get("IROGB_PORT", "6969"))  # Lol
    handler = partial(IroGBRequestHandler, directory=str(WEB_ROOT))

    with http.server.ThreadingHTTPServer((host, port), handler) as server:
        print(f"IroGB web frontend available at http://{host}:{port}/")
        print(f"Serving files from {WEB_ROOT}")

        try:
            server.serve_forever()
        except KeyboardInterrupt:
            print("\nQuitting")


if __name__ == "__main__":
    main()

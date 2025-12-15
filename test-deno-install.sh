#!/bin/bash
echo "Testing Deno installation in Alpine..."
docker run --rm -it alpine:latest sh -c '
  apk add --no-cache curl unzip bash
  curl -fsSL https://deno.land/install.sh | bash
  /root/.deno/bin/deno --version
' && echo "✅ Deno installation test passed!" || echo "❌ Test failed"

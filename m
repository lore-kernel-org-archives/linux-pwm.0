Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703461;
	b=3tov2Uv8eYpRw94uIelNgv6+sC1N2XkpsAlsPFVd5DDgKe6UV7osSqFjWTZTt3l4asN7
	 kZBNUjyWWhqu5JpJVTxq8ZRfZCbrPlnDBGMTlw91UN1j3i89MMVeJVfYio0oPHJO70p5o
	 1eDPkcYwJYVbNoOUKMsre1dJN3xQdGPsVNY/SXDwChc4PepU6vXHoxmFx3V6iJ673uWZ7
	 xMpcA0JGsO53Oi7QYxn5p0ZpuVNk63DqIxK9btN6bX5O/sGSM13l4Orl/9tmJF1KMVpjN
	 BKV4mVGBBzBhobke2nTZJwy91nXeLjOBNVlfHunFcURsM9bYLttamOQ+tLZb67MQURA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703461;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=b75Uo34PUw4iKamZCCZe1xXf0ksyUJZPIAvMHwurv6A=;
	b=3x+6ZV932gufhcT8UaMg44jx5DJLFIJSSu2EjjpIqowfWcCZq7tzc4v885ZNxda7RdUr
	 185t7XZe2qjErcHnd5srfPKw4HlyCOPvHqrFd1P+Id6yYr9MNDFJFk27FH8/RAZYJ58Kj
	 J0wpm4z+MNvrikV9paZ2Ns1cT8KhsLiBOXKWalT5a+LzAdQ/jzR8eg5TihacK/ZprTVFr
	 ch3WBfUQ8GOJcAW2Phft6Thp5RqeEsXgf+zIR+qQoeBmANY1TZ0EDzqlET5vbKuCs2hhK
	 +Nv84knqCFbIDLPNdP6j2LY3o5XOyMA3S7XvCY6UbYTKQoiTH3vSqP7U5r43r5/B7dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bd0XZfJG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F824606A33B;
	Thu, 26 Nov 2026 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bd0XZfJG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2E41F000CA;
	Thu, 26 Nov 2026 14:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703460;
	bh=b75Uo34PUw4iKamZCCZe1xXf0ksyUJZPIAvMHwurv6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bd0XZfJGoEh8+eXTYsgR8Z7oZnjS21PkrS8yTzRHXwy8bmykTZhAkUKXG4GwTOK2M
	 gK0DaqH0/ziDXSlqQuZQbCeF9sN1DSg/xQ/kBkathsLZnv7NgJRfsZeItj+peVdNJm
	 FK+LOxRF2LZo+F0BHtty1l3JtkE9Y7GB43FduhTGk4UykLbIdUJmiX2gfwM13Huoum
	 /rBBTa8YLyd2U5bUcQi/Z88CLPS9fajydGVagKMk1Z/DfjApdJD0NghbWSFETEGEke
	 6aElkbJpkvESKmqP2IoKl+2UpevnOH7RrhYQbasS83V+J4JeuYtG/3oF2ZvASMtSTW
	 MJ7IelZLGbzew==
From: Geert Uytterhoeven <geert@kernel.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Khanh Le <khanh.le.xr@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 1/6] dt-bindings: pwm: renesas,tpu-pwm: Add support for R-Car X5H
Date: Thu, 26 Nov 2026 15:30:36 +0100
Message-ID: <dd79d734b5e9d3de3c418b92130f51514fe08c3a.1795702568.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795702568.git.geert+renesas@glider.be>
References: <cover.1795702568.git.geert+renesas@glider.be>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Khanh Le <khanh.le.xr@renesas.com>

Document support for the 16-Bit Timer Pulse Unit (TPU) in the Renesas
R-Car X5H (R8A78000) SoC.

Signed-off-by: Khanh Le <khanh.le.xr@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
v2:
  - Add Acked-by.
---
 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
index f85ee5d20ccbb3f9..144a88ff53e5633b 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
@@ -33,6 +33,7 @@ properties:
           - renesas,tpu-r8a779a0  # R-Car V3U
           - renesas,tpu-r8a779g0  # R-Car V4H
           - renesas,tpu-r8a779h0  # R-Car V4M
+          - renesas,tpu-r8a78000  # R-Car X5H
       - const: renesas,tpu
 
   reg:
-- 
2.43.0


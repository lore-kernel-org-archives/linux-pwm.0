Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703465;
	b=I9gAlrs++dqJ418Jmoh6UqERyKgq19wApRWf2284KwEzXd2Gh9jE6vsZ/EwpOdtVeEU1
	 N6IM11DqH1h6YuZ0o79yJkZRGqbc755fQEojicpRE51mAkGShatvUF/AANSEBF75c3GPL
	 6KY9KXNJBP3ydx6JKhhYp9JGNqzSpLARusxThMgMyEhYRlhfocIWcOTzfTK7+ByRxWMEC
	 bM4icfUoJKhVM3s4/vUWwBQXM5yKSYzIIuFRYM5JJk468hpl2vbdOInUHF+OpiHaedbp2
	 Am7fIv1R7lXmq67RAirtRSrxnTvyYH6/RG3fY6vC9N1Q+ROvFgFwNLlqxhLMtpOuseQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703465;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9lAyvwZZT5v+wcmdHg5kmxZfIU39+yV0fKjX8zUkDT8=;
	b=W6+rsxoT1gM6v19ixO2BjpJbGSZgCcAWyPxj2rQuob6eO7elpidwFgpfFPiCU80MfByi
	 f6wfSK+/0qMbSuHd2F25gy09NQwsEoPLUUwq5gDD1M5Jvfl7i2rClj7/mtfxYbklpqTTp
	 hhF4g6fO7sKBiObKgaoLDRaFyrmcTLD3bTOQsmjQEN8X6hq7LYRCrNl2iF3vMFTQuNdja
	 g4+zRvzxf2SMD5ae5ea+AbxNTXbn3D2AW2bpR/gpdfseQXLNxiY8LkamHL7mj/3Ux2CRI
	 1cWYqlkMNWRy1P+aasmt+R0a8GwGhzt9JEKpxQDTdNS926rynS00wDqzJsC19Sm02Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FiV8CNgP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA2606A6AE;
	Thu, 26 Nov 2026 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FiV8CNgP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBAF1F000CA;
	Thu, 26 Nov 2026 14:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703464;
	bh=9lAyvwZZT5v+wcmdHg5kmxZfIU39+yV0fKjX8zUkDT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FiV8CNgPVYOrHabdZiI8fBsgAT4tayHRtJKcJk3tcUKHZegmR2hE58QZHSJC7p4DC
	 cbukvz0Mo887ktpwC3J0mMriCWEj1r31isM6pHGNd+6P/OvzDHUrF2CkgVd2A4Hknj
	 Gx1jVnGDfUa4uD+Cx1rj2nJ6G78N1Z33k8ZXJN3ZhXncUIhfBm4LJO+/X3JBK1p5+Y
	 qq9cfpdXJUlbtrllqiIgfPIPL9xNn2hS2vOaOdgoaepV1gIIk6I+S59HGRgaI0ITMD
	 tqEfiY+efbrK3sPegXI31V5od80Hvh0sGC9pb0vn4d9ZdXm2VQNRbNWVcMA7gyWndy
	 HJK1sIhHjpMYg==
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 2/6] dt-bindings: pwm: renesas,pwm-rcar: Add support for R-Car X5H
Date: Thu, 26 Nov 2026 15:30:37 +0100
Message-ID: <5990ba1efe6a6936272e6dc1993b7e656690b1d4.1795702568.git.geert+renesas@glider.be>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

Document support for the Pulse Width Modulation (PWM) module in the
Renesas R-Car X5H (R8A78000) SoC.

R-Car Gen5 enlarged the PWM output cycle and high-level period fields
from 10 to 24 bits.  While the added register bits have initial states
of all-zeroes, and thus look compatible with previous generations, the
register bits may have been modified before Linux boots.  Hence no
fallback to renesas,pwm-rcar is included.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
v2:
  - Add Reviewed-by.
---
 .../bindings/pwm/renesas,pwm-rcar.yaml        | 61 ++++++++++---------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
index 2fe1992e29088c9a..424ca1e2df15354c 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
@@ -11,34 +11,39 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,pwm-r8a7742   # RZ/G1H
-          - renesas,pwm-r8a7743   # RZ/G1M
-          - renesas,pwm-r8a7744   # RZ/G1N
-          - renesas,pwm-r8a7745   # RZ/G1E
-          - renesas,pwm-r8a77470  # RZ/G1C
-          - renesas,pwm-r8a774a1  # RZ/G2M
-          - renesas,pwm-r8a774b1  # RZ/G2N
-          - renesas,pwm-r8a774c0  # RZ/G2E
-          - renesas,pwm-r8a774e1  # RZ/G2H
-          - renesas,pwm-r8a7778   # R-Car M1A
-          - renesas,pwm-r8a7779   # R-Car H1
-          - renesas,pwm-r8a7790   # R-Car H2
-          - renesas,pwm-r8a7791   # R-Car M2-W
-          - renesas,pwm-r8a7794   # R-Car E2
-          - renesas,pwm-r8a7795   # R-Car H3
-          - renesas,pwm-r8a7796   # R-Car M3-W
-          - renesas,pwm-r8a77961  # R-Car M3-W+
-          - renesas,pwm-r8a77965  # R-Car M3-N
-          - renesas,pwm-r8a77970  # R-Car V3M
-          - renesas,pwm-r8a77980  # R-Car V3H
-          - renesas,pwm-r8a77990  # R-Car E3
-          - renesas,pwm-r8a77995  # R-Car D3
-          - renesas,pwm-r8a779a0  # R-Car V3U
-          - renesas,pwm-r8a779g0  # R-Car V4H
-          - renesas,pwm-r8a779h0  # R-Car V4M
-      - const: renesas,pwm-rcar
+    oneOf:
+      - items:
+          - enum:
+              - renesas,pwm-r8a7742   # RZ/G1H
+              - renesas,pwm-r8a7743   # RZ/G1M
+              - renesas,pwm-r8a7744   # RZ/G1N
+              - renesas,pwm-r8a7745   # RZ/G1E
+              - renesas,pwm-r8a77470  # RZ/G1C
+              - renesas,pwm-r8a774a1  # RZ/G2M
+              - renesas,pwm-r8a774b1  # RZ/G2N
+              - renesas,pwm-r8a774c0  # RZ/G2E
+              - renesas,pwm-r8a774e1  # RZ/G2H
+              - renesas,pwm-r8a7778   # R-Car M1A
+              - renesas,pwm-r8a7779   # R-Car H1
+              - renesas,pwm-r8a7790   # R-Car H2
+              - renesas,pwm-r8a7791   # R-Car M2-W
+              - renesas,pwm-r8a7794   # R-Car E2
+              - renesas,pwm-r8a7795   # R-Car H3
+              - renesas,pwm-r8a7796   # R-Car M3-W
+              - renesas,pwm-r8a77961  # R-Car M3-W+
+              - renesas,pwm-r8a77965  # R-Car M3-N
+              - renesas,pwm-r8a77970  # R-Car V3M
+              - renesas,pwm-r8a77980  # R-Car V3H
+              - renesas,pwm-r8a77990  # R-Car E3
+              - renesas,pwm-r8a77995  # R-Car D3
+              - renesas,pwm-r8a779a0  # R-Car V3U
+              - renesas,pwm-r8a779g0  # R-Car V4H
+              - renesas,pwm-r8a779h0  # R-Car V4M
+          - const: renesas,pwm-rcar
+      - items:
+          - enum:
+              - renesas,pwm-r8a78000  # R-Car X5H
+          - const: renesas,rcar-gen5-pwm
 
   reg:
     # base address and length of the registers block for the PWM.
-- 
2.43.0


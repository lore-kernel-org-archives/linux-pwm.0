Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703478;
	b=UkxqqCUSm57gn0obk+ErR9TpYl7oU4sn+ckt+CuyRPjJr3Us5KeWVEW+ZL9BCx/JAwQF
	 gEBXndgkSYfIWv243lNlHXcFha+//BZPcNB3yEQyW0MmoVH9Kz1/AyKL4HT+CIMgbx1RY
	 9V5K61NtbJyzVX9MhWCvbdsxocOALASqUgoFYYmGLtEGLVSLNc+zI3LSd+7pMNm11grSB
	 x4BW+C+F2H6sFKq+bX+agFhvwgU1zVm8nForJIETYmWDWt0dWQoUoOADKlbvGtYMFB4HZ
	 KYUn6bmHCrIev+9k1m+f2OjAQxsbuRxL6e/TsbkiUyhPUHUAnLAvdVBb1cQABIdmvRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703478;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dqOp3x2OhTFdbiY5eg3d1jl/evxMxcw9ptScest3hww=;
	b=OwRwDpKffeAGq93cEZ0/B+RA/hRR0AeCXZ8yPtAvRmbBzrQLDDQY8S+qDiChIJo3w95+
	 Wj2havMni5TrAhE9aIFQDij9BkBsjGiu5x114sebnQsouYkN9lOvZPVnYbdsLIt7TIMCm
	 FcPMRPUS01YKivkEQijVZt/mHEW6inrUGBwfqTRfO/P3SIgAG8oAq4qjhnzytX0wLefn7
	 5Ha3xKthYkGG1MBMXzfhTHxmbYZXA+nmpfdlsQPRT16yQtPck428PRKztRRshu+fjjJHL
	 ODxz4oWqQWAXfqZuMIkfcnPlqZG8Jlq7i9UGgjC9m979U575TD0Auf4Gh6K0g2TK22w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G/2c6oyT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96370606A6A5;
	Thu, 26 Nov 2026 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G/2c6oyT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19C81F008B2;
	Thu, 26 Nov 2026 14:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703478;
	bh=dqOp3x2OhTFdbiY5eg3d1jl/evxMxcw9ptScest3hww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G/2c6oyT4mkGQ1GvFwW0RWDn6uK67t55gc7COa1Avts+AEEAdFczdaxOZlP3aPIt+
	 CEMoS68X7bGtI107btrvioBgRYuyexRJeV4AhdMWBt94wwsl+SQ3fnMrbt4hnPYHOo
	 oSNhfl1D8WekRCcpk+3Rsnkx9BXUl84fWWd3MDraUm/CX+Grs9/fiGAIvk1jQvm9iU
	 aC3hTYYdOCiQ29uF79ZOI+m1sico6LAEKuPlzfl79Kq55RFxoqziZkGAjkZqheNSUu
	 sLRBB6tNDkOfm6f1n7hZwDE9U2PusAleO6lhOTYT10aDwcJxinJJxlhpuVdf0sX4lq
	 ESbkJ6bmKKG6A==
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
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 6/6] pwm: rcar: Add support for R-Car Gen5
Date: Thu, 26 Nov 2026 15:30:41 +0100
Message-ID: <b85cb5b3a2b580c3ee7dd4c5feeef552783e2321.1795702568.git.geert+renesas@glider.be>
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

R-Car Gen5 enlarged the PWM output cycle and high-level period fields
from 10 to 24 bits.  As the existing register bitfields can accommodate
only 16 bits, the high parts of each field are stored in a new register.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Improve patch description.
---
 drivers/pwm/pwm-rcar.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 3813094c601efc8c..5e91509de7a7c162 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -31,7 +31,8 @@
 #define  RCAR_PWMCR_SS0		BIT(4)
 #define  RCAR_PWMCR_EN0		BIT(0)
 
-#define RCAR_PWMCNT		0x04
+#define RCAR_PWMCNTA		0x04		/* Low part */
+#define RCAR_PWMCNTB		0x08		/* High part (R-Car Gen5) */
 #define  RCAR_PWMCNT_CYC0_MASK	GENMASK(31, 16)
 #define  RCAR_PWMCNT_PH0_MASK	GENMASK(15, 0)
 
@@ -124,9 +125,15 @@ static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, u64 duty_ns,
 		return -EINVAL;
 
 	rcar_pwm_write(rp,
-		       FIELD_PREP(RCAR_PWMCNT_CYC0_MASK, cyc) |
-		       FIELD_PREP(RCAR_PWMCNT_PH0_MASK, ph),
-		       RCAR_PWMCNT);
+		       FIELD_PREP(RCAR_PWMCNT_CYC0_MASK, lower_16_bits(cyc)) |
+		       FIELD_PREP(RCAR_PWMCNT_PH0_MASK, lower_16_bits(ph)),
+		       RCAR_PWMCNTA);
+
+	if (rp->cycle_bits >= 16)
+		rcar_pwm_write(rp,
+		       FIELD_PREP(RCAR_PWMCNT_CYC0_MASK, upper_16_bits(cyc)) |
+		       FIELD_PREP(RCAR_PWMCNT_PH0_MASK, upper_16_bits(ph)),
+		       RCAR_PWMCNTB);
 
 	return 0;
 }
@@ -146,9 +153,14 @@ static int rcar_pwm_enable(struct rcar_pwm_chip *rp)
 	u32 value, cyc, ph;
 
 	/* Don't enable the PWM device if CYC0 or PH0 is 0 */
-	value = rcar_pwm_read(rp, RCAR_PWMCNT);
+	value = rcar_pwm_read(rp, RCAR_PWMCNTA);
 	cyc = FIELD_GET(RCAR_PWMCNT_CYC0_MASK, value);
 	ph = FIELD_GET(RCAR_PWMCNT_PH0_MASK, value);
+	if (rp->cycle_bits >= 16) {
+		value = rcar_pwm_read(rp, RCAR_PWMCNTB);
+		cyc |= FIELD_GET(RCAR_PWMCNT_CYC0_MASK, value) << 16;
+		ph |= FIELD_GET(RCAR_PWMCNT_PH0_MASK, value) << 16;
+	}
 
 	if ((cyc & RCAR_PWM_MAX_CYCLE(rp)) == 0 ||
 	    (ph & RCAR_PWM_MAX_CYCLE(rp)) == 0)
@@ -262,8 +274,13 @@ static const struct rcar_pwm_info rcar_pwm_info = {
 	.cycle_bits = 10,
 };
 
+static const struct rcar_pwm_info rcar_gen5_pwm_info = {
+	.cycle_bits = 24,
+};
+
 static const struct of_device_id rcar_pwm_of_table[] = {
 	{ .compatible = "renesas,pwm-rcar", .data = &rcar_pwm_info },
+	{ .compatible = "renesas,rcar-gen5-pwm", .data = &rcar_gen5_pwm_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rcar_pwm_of_table);
-- 
2.43.0


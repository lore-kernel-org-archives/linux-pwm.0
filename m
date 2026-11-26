Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703475;
	b=TyW0R1uKVLH5NNZYuKzwtY2PWhQhPhhnKwCIX+iv3ZevM8O4xtFa6kwqkKOHqsctBG9A
	 tN9Dd3AfIaW0im2cV0eNlrdt2oK9SZfobDcY+n/x+TGwYIe1kZ+l3s1NCRkzVP8yXzduw
	 c6Jmv/rrTMiiyGNzP7ujZzIT9GkYfbrgxULpCuYO4bu6r8CJN9PDreakya0VTlW03On+G
	 PpcZ1CIybv8KVeWUjpBHO9I1xvjcZVaYOMNdxhC9co8GAGWnqJlrCv3mJ8h5JFMaD9GA+
	 IO0hT/hhkIGSi56S/KwxnFBu5Oi9Oqpuqvm4+MEQrHhINtDsHtCS27zIkwwggDzlCuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703475;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LcCyyNEShtN9NDQID84OguusVHpvilueb19Q0/nztUw=;
	b=lVGikw8ue2590ivzsfh5GVL410/C4bb09VLLN8gS9B1i8xvzoarCBS+ZAQNH/buSNrnM
	 ruxOS0X3RS7imSuzCcnx8WJ2AEqqwJPqDei+7k1s7jK/TO14PKDepLFPZGoxKP3meU3Fy
	 J2PiRxT/ZomLpQshRDjF22dWGIBJbfiED8TDc2LbMBBWWOLSRNUlVXVrXahRE0j7oq42i
	 S8kZvjMtpQop0yDexSoN5K4UQB64k8c0acTX7TymGls8McgL0NeruYaZnLyZlzgtY7Bid
	 97PlmQ4WXshrGA5+bYIprpBCHgGbpdW0QRoWUPsdtwfga4+ZyU19L3olKlbzWsp01Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y1TwWXBB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D76606A32A;
	Thu, 26 Nov 2026 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y1TwWXBB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC361F000D2;
	Thu, 26 Nov 2026 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703474;
	bh=LcCyyNEShtN9NDQID84OguusVHpvilueb19Q0/nztUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y1TwWXBBysulR1Y+3XoqWzYv7qSSg5rw3/lMPVNRv/EgUpr1FJhuoEUS1QZtP1/cC
	 1UlMql6P0Omd1S7T7aUOOV/8keGEy9xrT4eqCj7Z54cGULL9PZq45oEMcCRFQU76uT
	 /VwO/BRE2MqYtc72zXlbhF62QPExUDN1m6n2D79T7AQX+K/pFNPdMZ1dOxQpC19ay9
	 uXMyb1uKIm5xpe4rMPvbqewAZeyzTwgcKkx+E9R3yN0NSDmceKcNOBSdmHz8aJiXjg
	 memlqBLKShEDb06TOgJGqq2wFns0xUSsrZlaxM4UkAJIyP2hL2w98Z70ybIqbGm5yh
	 AFR/qX0/hG6AQ==
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
Subject: [PATCH v2 5/6] pwm: rcar: Parametrize cycle counter field size
Date: Thu, 26 Nov 2026 15:30:40 +0100
Message-ID: <114735221f5a3e9a331768e87ee3c165aa82fcc2.1795702568.git.geert+renesas@glider.be>
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

Prepare for the advent of PWM blocks with output cycle and high-level
period fields larger than 10 bits by parametrizing the field size.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 drivers/pwm/pwm-rcar.c | 51 +++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index f1f68bfe016f729f..3813094c601efc8c 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -22,7 +22,7 @@
 #include <linux/slab.h>
 
 #define RCAR_PWM_MAX_DIVISION	24
-#define RCAR_PWM_MAX_CYCLE	1023
+#define RCAR_PWM_MAX_CYCLE(rp)	GENMASK(rp->cycle_bits - 1, 0)
 
 #define RCAR_PWMCR		0x00
 #define  RCAR_PWMCR_CC0_MASK	GENMASK(19, 16)
@@ -32,14 +32,17 @@
 #define  RCAR_PWMCR_EN0		BIT(0)
 
 #define RCAR_PWMCNT		0x04
-#define  RCAR_PWMCNT_CYC0_MASK	0x03ff0000
-#define  RCAR_PWMCNT_CYC0_SHIFT	16
-#define  RCAR_PWMCNT_PH0_MASK	0x000003ff
-#define  RCAR_PWMCNT_PH0_SHIFT	0
+#define  RCAR_PWMCNT_CYC0_MASK	GENMASK(31, 16)
+#define  RCAR_PWMCNT_PH0_MASK	GENMASK(15, 0)
 
 struct rcar_pwm_chip {
 	void __iomem *base;
 	struct clk *clk;
+	unsigned int cycle_bits;
+};
+
+struct rcar_pwm_info {
+	unsigned int cycle_bits;
 };
 
 static inline struct rcar_pwm_chip *to_rcar_pwm_chip(struct pwm_chip *chip)
@@ -77,7 +80,7 @@ static int rcar_pwm_get_clock_division(struct rcar_pwm_chip *rp, int period_ns)
 	if (clk_rate == 0)
 		return -EINVAL;
 
-	div = (u64)NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE;
+	div = mul_u32_u32(NSEC_PER_SEC, RCAR_PWM_MAX_CYCLE(rp));
 	tmp = (u64)period_ns * clk_rate + div - 1;
 	tmp = div64_u64(tmp, div);
 	div = ilog2(tmp - 1) + 1;
@@ -111,21 +114,19 @@ static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, u64 duty_ns,
 
 	/* div <= 24 == RCAR_PWM_MAX_DIVISION, so the shift doesn't overflow. */
 	tmp = mul_u64_u64_div_u64(period_ns, clk_rate, (u64)NSEC_PER_SEC << div);
-	if (tmp > FIELD_MAX(RCAR_PWMCNT_CYC0_MASK))
-		tmp = FIELD_MAX(RCAR_PWMCNT_CYC0_MASK);
-
-	cyc = FIELD_PREP(RCAR_PWMCNT_CYC0_MASK, tmp);
+	cyc = min(tmp, RCAR_PWM_MAX_CYCLE(rp));
 
 	tmp = mul_u64_u64_div_u64(duty_ns, clk_rate, (u64)NSEC_PER_SEC << div);
-	if (tmp > FIELD_MAX(RCAR_PWMCNT_PH0_MASK))
-		tmp = FIELD_MAX(RCAR_PWMCNT_PH0_MASK);
-	ph = FIELD_PREP(RCAR_PWMCNT_PH0_MASK, tmp);
+	ph = min(tmp, RCAR_PWM_MAX_CYCLE(rp));
 
 	/* Avoid prohibited setting */
 	if (cyc == 0 || ph == 0)
 		return -EINVAL;
 
-	rcar_pwm_write(rp, cyc | ph, RCAR_PWMCNT);
+	rcar_pwm_write(rp,
+		       FIELD_PREP(RCAR_PWMCNT_CYC0_MASK, cyc) |
+		       FIELD_PREP(RCAR_PWMCNT_PH0_MASK, ph),
+		       RCAR_PWMCNT);
 
 	return 0;
 }
@@ -142,12 +143,15 @@ static void rcar_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 
 static int rcar_pwm_enable(struct rcar_pwm_chip *rp)
 {
-	u32 value;
+	u32 value, cyc, ph;
 
 	/* Don't enable the PWM device if CYC0 or PH0 is 0 */
 	value = rcar_pwm_read(rp, RCAR_PWMCNT);
-	if ((value & RCAR_PWMCNT_CYC0_MASK) == 0 ||
-	    (value & RCAR_PWMCNT_PH0_MASK) == 0)
+	cyc = FIELD_GET(RCAR_PWMCNT_CYC0_MASK, value);
+	ph = FIELD_GET(RCAR_PWMCNT_PH0_MASK, value);
+
+	if ((cyc & RCAR_PWM_MAX_CYCLE(rp)) == 0 ||
+	    (ph & RCAR_PWM_MAX_CYCLE(rp)) == 0)
 		return -EINVAL;
 
 	rcar_pwm_update(rp, RCAR_PWMCR_EN0, RCAR_PWMCR_EN0, RCAR_PWMCR);
@@ -202,11 +206,16 @@ static const struct pwm_ops rcar_pwm_ops = {
 
 static int rcar_pwm_probe(struct platform_device *pdev)
 {
+	const struct rcar_pwm_info *info;
 	struct device *dev = &pdev->dev;
 	struct rcar_pwm_chip *rcar_pwm;
 	struct pwm_chip *chip;
 	int ret;
 
+	info = of_device_get_match_data(dev);
+	if (!info)
+		return -ENODEV;
+
 	chip = devm_pwmchip_alloc(dev, 1, sizeof(*rcar_pwm));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
@@ -222,6 +231,8 @@ static int rcar_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(rcar_pwm->clk);
 	}
 
+	rcar_pwm->cycle_bits = info->cycle_bits;
+
 	chip->ops = &rcar_pwm_ops;
 
 	platform_set_drvdata(pdev, chip);
@@ -247,8 +258,12 @@ static void rcar_pwm_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
+static const struct rcar_pwm_info rcar_pwm_info = {
+	.cycle_bits = 10,
+};
+
 static const struct of_device_id rcar_pwm_of_table[] = {
-	{ .compatible = "renesas,pwm-rcar" },
+	{ .compatible = "renesas,pwm-rcar", .data = &rcar_pwm_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rcar_pwm_of_table);
-- 
2.43.0


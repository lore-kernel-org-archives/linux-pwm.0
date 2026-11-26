Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703471;
	b=IvxHX4D5lFbSuWMdD/ktJNS2+jIA8n/xlJquJ16Z23aFs1gRjqWikc+yKOi3nNpj2aTz
	 98xERYnV8+T+M6iw/7UQCWnaoJ6aWY9sl4glieMTYFpk010V8V/+sXFaV8LpH8QmAxN5p
	 NGwOTHwvKls+fO+uwwzFirjdlG8sMSWS48ld5I0NxzCTJyXVzM3ImA9Cfz66tDg/Yid9R
	 HEKMnuWRlEeB789QnsJYzFgndAMjTSLoxWvOa0xZBgt9mYKE0OM0BBqs99ybl5oxt279s
	 yNDWRGpFUnnLtBx3bal3UaPSwMBY1uA3Pk8q3X8fkF6kxDb1k+v/MNiMfncVD2DpuLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703471;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=M64CYlkjLbAvLGKBaVAJzGVW5MF5Pc8UChX7LZBCtj4=;
	b=vB50pEiaSBp/au1NVzU1lOv9j4TkJZY8g9SWoB97YDrD2GxJkl1s8FSCmtB6zACe0wZQ
	 2jzKl9lRJ6PH60lobSUrn29Gfru0F6DzOSJCihhVxWl+k41VQMxwMlTltQsd3Q0thfpZU
	 5G8gA+erxqqHVAPliwUYcDW5+ejP9RB0TRE8sd1g4d2XIlpA9MURU54corng2c0z56w2o
	 alUWJtsq1FXyNSTTh1WVsYJn5v8wxyLfkn3HTSW51MYomFChzJ2IYnbZZnZqS5XZhFGa+
	 ttGW8vdc3IAba/hq8HOAwVFS3Tdyk1UmNi2ZnomQUY8E+LcCjFqHVZwsx5tmL7kwsTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TGthN4Hu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDEF606A687;
	Thu, 26 Nov 2026 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TGthN4Hu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B351F000EE;
	Thu, 26 Nov 2026 14:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703471;
	bh=M64CYlkjLbAvLGKBaVAJzGVW5MF5Pc8UChX7LZBCtj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TGthN4HuAraPddZ8Xqq58e8enVMlXq4Tt0WZ1rhLpCkWmFu/KtlcuP6+/Q7deI/MZ
	 RFX467qezW7gCEarvBe9IIxKn3LTt9PNqb8lcEgVBCPffCx/eCnGyKFEQRjX/IvqxR
	 GoaaA/973s5Tz0Jr1OETNZ2RE7Mu/AUHjq9+R9O9OHit4Jn3kmX6S4EWxnI2lJYYCW
	 Qx8zKAtlrDuOpnxarpJNTFYbXFDj+Rfj+WMkK/jVIW0ItKLd/zlvOEr+g8IuHQH3qN
	 NJUbUO5II/P3x/NWF/+JD56q2xf0t5KikAE1ov9OyABGpKiKg5KGBsRyLlzNDaO4g6
	 +A7Kn1ZSl3B9w==
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
Subject: [PATCH v2 4/6] pwm: rcar: Add helper variable dev to rcar_pwm_probe()
Date: Thu, 26 Nov 2026 15:30:39 +0100
Message-ID: <a49147c8ea94d0f14d3b95b6173d5f5bd1e832cd.1795702568.git.geert+renesas@glider.be>
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

rcar_pwm_probe() has many users of "&pdev->dev".
Introduce a shorthand to simplify the code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 drivers/pwm/pwm-rcar.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 4641f258df531baf..f1f68bfe016f729f 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -202,11 +202,12 @@ static const struct pwm_ops rcar_pwm_ops = {
 
 static int rcar_pwm_probe(struct platform_device *pdev)
 {
-	struct pwm_chip *chip;
+	struct device *dev = &pdev->dev;
 	struct rcar_pwm_chip *rcar_pwm;
+	struct pwm_chip *chip;
 	int ret;
 
-	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*rcar_pwm));
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*rcar_pwm));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	rcar_pwm = to_rcar_pwm_chip(chip);
@@ -215,9 +216,9 @@ static int rcar_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(rcar_pwm->base))
 		return PTR_ERR(rcar_pwm->base);
 
-	rcar_pwm->clk = devm_clk_get(&pdev->dev, NULL);
+	rcar_pwm->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(rcar_pwm->clk)) {
-		dev_err(&pdev->dev, "cannot get clock\n");
+		dev_err(dev, "cannot get clock\n");
 		return PTR_ERR(rcar_pwm->clk);
 	}
 
@@ -225,12 +226,12 @@ static int rcar_pwm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, chip);
 
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_enable(dev);
 
 	ret = pwmchip_add(chip);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to register PWM chip: %d\n", ret);
-		pm_runtime_disable(&pdev->dev);
+		dev_err(dev, "failed to register PWM chip: %d\n", ret);
+		pm_runtime_disable(dev);
 		return ret;
 	}
 
-- 
2.43.0


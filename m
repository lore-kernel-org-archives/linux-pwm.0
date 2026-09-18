Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEDA3559F8
	for <linux-pwm@vger.kernel.org>; Fri, 18 Sep 2026 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742044; cv=none; b=kyQSQquB0g6OUoli6QuJwXFuJwgZvKJ2tGdK0x9huAiEo3hrA+RMtce2B8UJEFOOrQoh45NPFvHHTEWW9+RmO8qLohvgq+0FxU+k8VNIN62zhFFpey4awlKSNuSuLsq+vEk8AjRyFytXh67grv+Bu/54va2rQuaVOp2vkDMkbVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742044; c=relaxed/simple;
	bh=7Cv4SBcra0Ohdz6SOqua5EyRhbXggKO8tv0Gpq49x+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esJQK6y6x2pjrokU4THgvpTvp+h9dAJDGp+sH/Pm3UO4SM14P1C3g/eAIX3S7S5UpvYvsSIvxMhO6nw7DUlIu/XzlUwEF93hII2ov2ZKGeqgAJSiXE8hxymRSf7oOejD+G8h7WANxkdi5jbgelwbBwf6eSEO+gZIyd4pkxE1tnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZhDRM7H8; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ZhDRM7H8"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so526796f8f.3
        for <linux-pwm@vger.kernel.org>; Fri, 18 Sep 2026 07:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789742040; x=1790346840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sjx4o8bJ6g5b8nq5GAvpSa8wVIWcrZHnOeqXqn9scx8=;
        b=ZhDRM7H85uR/DnyY2luQxPixNVkAI1NoICkA5SctxuNa6VrLloCn/NX1Mx/m1Jvqyn
         o7iZKyo0Y1rcTxfIzJS3aebN2B8JoqrqT10sq9YgaSMzq0CtQLI1oU2Yzu6/jTtb4Ygu
         uI1+K8aXOmUxsFhtlGHG64q71pHUEkHa94/ODoKW2SSnY7wojMNUtjm57UpsO+Z8HyFt
         zXXyThBcMYopoIJTaBWJ1QpjhATAY6jqv6z386DF0oCfN4GAep0tzozvSpImIO2oanTk
         tDXDy+npZzBNJz+dfgXj9BeO56DsrnHooYA2C+PlxrbhYdiVf5OrQI7I2gCIqoFTbF/7
         aPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789742040; x=1790346840;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sjx4o8bJ6g5b8nq5GAvpSa8wVIWcrZHnOeqXqn9scx8=;
        b=gdTHfGMDk/8hNVtPg8p1YTlk4K7VgDL/K083+07sxttc+vyG2MgPTG25rV8l9jfwvV
         60dmJAfkouvY1rqCHZLjeAQ4/tP1H8GaQ0n9crwTGI3k0+SGP8XxAM8Eyb7WT8yF24T4
         YzyuaLl0mUOkpeXCVSzP3K4j83+WuzG5P4FX4xFI3pT124oUOqv4hyTEqX8Rxq45p0Aj
         yBMHI9CD6GlmYHaEF5Am8b+aePP3I5xukHD9S1BDp5G7hqTfze2T2CY0uApeZZBiajlV
         CtrUSMgVOw8RwuoG7dLnjbkKD7h7iC41FMBDqikiTcxVQn8P+W4waFJaPfr2rAAKm7B7
         SIIQ==
X-Forwarded-Encrypted: i=1; AKwUvByLxnjeQ5QAPEiWa9gp3ammkeYm2twYQR/0o9Q8ME8v3n6fTTVnrgOj6mxL1IeEGfq0zVmCsQpdG2o=@vger.kernel.org
X-Gm-Message-State: AFuF++nupTSX4Civr2pJ0I55vxABE5qU+Mm6swYo2WBO2UZ7Kl6viBol
	DYGk3fBlQororj2Yyons21dI+VfWQsrDOmU1v3LC64bK0y/rz4bUf+d5A/HkEuQvgOo=
X-Gm-Gg: AYBFou0Q/Srr2Zza0eAp+8mnWCYfO+X/EEVWLLxhD7T0oOT7X4HHyi4CagKepaA6RiR
	OfTYOuExO7LUU7nicBWBa6SXq9uIy+R/A+EF5Ys52OLCfqEYoUcjPNQx5irt1bAz22YgaZm0V23
	g6OdsAxyPc/6S0uo5ViUEIH/Bpbzn17QypPeUrXTuvZpuVvC+8MM8u/bJ1sxf2jnf150vAUnlcU
	uooa+m4yXEuqOZctkGyyhvxFjxzxICQ3tV8juES0GZX6+G0U3iN4VH2Gf/KswMuOQB5EJFOBvNT
	UL1WHCn+5mJpdiDAqxK2P1f5IJKakNvs4kJ37JiAgeT3XvK6tU+ryKnWTsodOsSZfAG2tm/xB2I
	SCLEyMzPsRT5OL5qKcz3Oqa6oJwjs6hQG2RL4dfSBBJtpkKNCCqwmUi21ZkX/oFODFK6X0PaCUQ
	gb6LCimhePSTk4pkZqupijy1wlmDHchzZiLIsCU5gIkQKgjD1NjlA5u7rLKw+2rt1uKuQT/a+3k
	RxARzcUvWBHFcdams/7gQXc5j4QbkwO7NJ2FKSzicV/HR7SFP/QP0e1dP9YFQ==
X-Received: by 2002:adf:e011:0:20b0:487:21a6:51d with SMTP id ffacd0b85a97d-48721a60df4mr1710417f8f.15.1789742040504;
        Fri, 18 Sep 2026 07:34:00 -0700 (PDT)
Received: from localhost (p200300f65f19a90444c8989fe13f5be4.dip0.t-ipconnect.de. [2003:f6:5f19:a904:44c8:989f:e13f:5be4])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4872008160csm5384787f8f.32.2026.09.18.07.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:33:59 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] pwm: tegra: Make use of dev_err_probe()
Date: Fri, 18 Sep 2026 16:33:45 +0200
Message-ID:  <641219a7d76bbcd8fe98b5955f2355ed45f55986.1789741839.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
References: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4230; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=7Cv4SBcra0Ohdz6SOqua5EyRhbXggKO8tv0Gpq49x+8=; b=owGbwMvMwMXY3/A7olbonx/jabUkhqy13mf+ZyUymK5KWyytFmks5K93LOmMm6hGxZRzFw8rV uxNV5jWyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBEONI5GLYcldvP5PT8+RX9 dM6AY99NXvN19Hv9dOGr1kh45nbAr8HHydzqvsmRH6HZtueZD5bP3C+jy31o5pkPV758US/RXDC h91aDs5BoeavFvpnsn9OymUpt/tksEd1Vfm8h4+r09/fKZ93X2Ge2veCveDV/tYn3BbYux3vlYl 9N9fTk9Hu3sMzIzFNqveJVb7Ln9s0tvlknJxsKdbg/Yeax3iXx+qXtO493GZ/2zznWNyVx1R7NB 8LKH88vP6fzZ+MrTZ6DB2pueR185ihcGdEoYXy85Mn7BrPwEv7mXBFHocXNC7jLdnac45+/eYpP bN8tJ3nrfy7WsevWs2ady6+wEX2zVbWhr/yl5qQky/qPAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Usage of dev_err_probe() is more compact than dev_err()'s, emits the
error code and handles -ENOMEM and -EPROBE_DEFER properly. Benefit from
these improvements.

Also add a few messages in error paths that lacked an output before.

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-tegra.c | 52 ++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 5cdbe120ba2d..efb7ab60f602 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -316,14 +316,15 @@ static const struct pwm_ops tegra_pwm_ops = {
 
 static int tegra_pwm_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct pwm_chip *chip;
 	struct tegra_pwm_chip *pc;
 	const struct tegra_pwm_soc *soc;
 	int ret;
 
-	soc = of_device_get_match_data(&pdev->dev);
+	soc = of_device_get_match_data(dev);
 
-	chip = devm_pwmchip_alloc(&pdev->dev, soc->num_channels, sizeof(*pc));
+	chip = devm_pwmchip_alloc(dev, soc->num_channels, sizeof(*pc));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	pc = to_tegra_pwm_chip(chip);
@@ -331,28 +332,39 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	pc->soc = soc;
 
 	pc->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(pc->regs))
+	if (IS_ERR(pc->regs)) {
+		/*
+		 * devm_platform_ioremap_resource() already emits an error
+		 * message with CONFIG_HAS_IOMEM, so don't emit another message
+		 * here.
+		 */
 		return PTR_ERR(pc->regs);
+	}
 
 	platform_set_drvdata(pdev, chip);
 
-	pc->clk = devm_clk_get(&pdev->dev, NULL);
+	pc->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(pc->clk))
-		return PTR_ERR(pc->clk);
+		return dev_err_probe(dev, PTR_ERR(pc->clk), "Failed to get clock\n");
 
-	ret = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
-	if (ret)
+	ret = devm_tegra_core_dev_init_opp_table_common(dev);
+	if (ret) {
+		/*
+		 * devm_tegra_core_dev_init_opp_table_common() emits an error
+		 * message most of the time, so don't add another.
+		 */
 		return ret;
+	}
 
-	pm_runtime_enable(&pdev->dev);
-	ret = pm_runtime_resume_and_get(&pdev->dev);
+	pm_runtime_enable(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to runtime resume device\n");
 
 	/* Set maximum frequency of the IP */
-	ret = dev_pm_opp_set_rate(&pdev->dev, ULONG_MAX);
+	ret = dev_pm_opp_set_rate(dev, ULONG_MAX);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to set max frequency: %d\n", ret);
+		dev_err_probe(dev, ret, "Failed to set max frequency\n");
 		goto put_pm;
 	}
 
@@ -363,8 +375,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	 */
 	pc->clk_rate = clk_get_rate(pc->clk);
 	if (pc->clk_rate < TEGRA_PWM_DEPTH) {
-		dev_err(&pdev->dev, "clock maximum frequency out of range\n");
-		ret = -ERANGE;
+		ret = dev_err_probe(dev, -ERANGE, "Clock maximum frequency out of range\n");
 		goto put_pm;
 	}
 
@@ -372,10 +383,9 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	pc->min_period_ns =
 	    (NSEC_PER_SEC / (pc->clk_rate / TEGRA_PWM_DEPTH)) + 1;
 
-	pc->rst = devm_reset_control_get_exclusive(&pdev->dev, "pwm");
+	pc->rst = devm_reset_control_get_exclusive(dev, "pwm");
 	if (IS_ERR(pc->rst)) {
-		ret = PTR_ERR(pc->rst);
-		dev_err(&pdev->dev, "Reset control is not found: %d\n", ret);
+		ret = dev_err_probe(dev, PTR_ERR(pc->rst), "Failed to get reset control\n");
 		goto put_pm;
 	}
 
@@ -385,17 +395,17 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 	ret = pwmchip_add(chip);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
+		dev_err_probe(dev, ret, "Adding pwmchip failed\n");
 		reset_control_assert(pc->rst);
 		goto put_pm;
 	}
 
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put(dev);
 
 	return 0;
 put_pm:
-	pm_runtime_put_sync_suspend(&pdev->dev);
-	pm_runtime_force_suspend(&pdev->dev);
+	pm_runtime_put_sync_suspend(dev);
+	pm_runtime_force_suspend(dev);
 	return ret;
 }
 
-- 
2.47.3


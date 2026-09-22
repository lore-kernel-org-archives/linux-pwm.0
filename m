Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6510D33689D;
	Tue, 22 Sep 2026 00:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037738; cv=none; b=UI8i+iM3xQzHbX0SvQidvVlwwQ1lOutyls7zz8Dps+QcJ7Xs11FGM+ptP2A3uiCogXLrNzcy27/ljOvC1LZQ/eVlT/qzeqDLxhXP/oUjKzwJRRUuWh4/urwgGe8sZqAcZi2jl20wIXvQARIeqmc5BAOvyQ7UPlWB3MPvYgDeKTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037738; c=relaxed/simple;
	bh=fYgBs0hMO8Rv03e//NL7rKu6soFHZ+KMCw99x+DsGYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BRtQg5BBINFfde18+E/li4uZyQmXOtp6qkELNh7YetuiMH85yWfucV3YvYYt9Or+TXv7CNouTSz0aGSLrmUH967cIuROn3aYx4ddGYKwM5h3bjr0XDRSbFrtiI19fe8efIp5DNgWX2beqJl26qOgz8JWhYzEFbvPCi0gBMd9jhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VmDQkl3N; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VmDQkl3N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=5D
	raQSoeUDlTV5a9KL9CmbEiqVAM6BOedYwwQhvAmxM=; b=VmDQkl3N+Vu/RkC02m
	dazH0kx3nQ8GBd+Og+xrIrvb173kjy9dVOivqJvq+Uqe3F456yUY8izSAU4RBxCi
	yai6P0iztJoVKk9PzLnFs8F+RmybDbmiNoEe9Vo7you+j66rYNjOg0r7SNbPy9rC
	VtSOfziWh/iYZGm/H4alcRYCM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBHFxjTzrFqmpJpAg--.56442S2;
	Tue, 22 Sep 2026 08:41:56 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: ukleinek@kernel.org
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hppiscas@163.com
Subject: [PATCH v2] pwm: fsl-ftm: keep clock ownership balanced after resume failure
Date: Tue, 22 Sep 2026 08:41:54 +0800
Message-ID: <20260922004154.2899-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBHFxjTzrFqmpJpAg--.56442S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw1xXFyDZF18uw1Uuw47twb_yoWxXFyxpF
	WfKr4Fv3ykXrW0gwn3tr4kAr1rtr4xtay5Ca95K3y0kwnIyr4Ig3WrCF9YvFsYyrn7AF1x
	AFs8tFyDGF1UCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRMa0dUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7RXvuGqxztWBIgAA3M

fsl_pwm_resume() ignores clock-enable and regcache_sync() errors. It can
therefore leave requested channels with only some of their clocks enabled
and continue as though register restoration succeeded.

Check each acquisition and unwind only the references acquired by this
resume attempt. Keep the register cache offline and dirty on replay
failure. Retain a suspended state until all clocks and registers have
been restored so a later suspend or free cannot release them twice.

Keep a bitmap of the enabled channels whose functional clocks were
released at suspend. pwm_put() does not necessarily disable the PWM or
clear its cached enabled state. If a channel is freed after a failed
resume, the retry must still restore those functional clocks, while
restoring the interface-clock references only for requested channels.
Otherwise a subsequent request can inherit an enabled state without the
clock references expected by apply().

Reject requests and enabled applies while suspended. A disabled apply
can still mask its cached output and cancel the corresponding functional
clock restoration. This keeps that disable distinct from simply freeing
an enabled PWM.

The issue was found by our static-analysis tool.

Fixes: 97d0b42e39a7 ("pwm: ftm: Add Power Management support for FTM PWM")
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Changes since v1:
- separate successful register replay from error handling
- keep the trailers together without an intervening blank line
- retain suspended ownership across a failed resume and the next cleanup
- restore functional clocks even if an enabled channel was freed after
  the failure; a disable, unlike free, cancels that restoration

Previous version:
https://lore.kernel.org/all/20260828092014.9211-1-pengpeng@iscas.ac.cn/

 drivers/pwm/pwm-fsl-ftm.c | 85 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 75 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 35406b2e1925..21ac97e3ed7a 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -51,6 +51,10 @@ struct fsl_pwm_chip {
 	struct clk *clk[FSL_PWM_CLK_MAX];
 
 	const struct fsl_ftm_soc *soc;
+	/* Functional clock references to restore, even if a channel is freed. */
+	unsigned long suspended_enabled;
+	/* Requested/enabled PWM state no longer implies owned clock references. */
+	bool suspended;
 };
 
 static inline struct fsl_pwm_chip *to_fsl_chip(struct pwm_chip *chip)
@@ -89,6 +93,9 @@ static int fsl_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	int ret;
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 
+	if (fpc->suspended)
+		return -EIO;
+
 	ret = clk_prepare_enable(fpc->ipg_clk);
 	if (!ret && fpc->soc->has_enable_bits)
 		regmap_set_bits(fpc->regmap, FTM_SC, BIT(pwm->hwpwm + 16));
@@ -103,7 +110,8 @@ static void fsl_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (fpc->soc->has_enable_bits)
 		regmap_clear_bits(fpc->regmap, FTM_SC, BIT(pwm->hwpwm + 16));
 
-	clk_disable_unprepare(fpc->ipg_clk);
+	if (!fpc->suspended)
+		clk_disable_unprepare(fpc->ipg_clk);
 }
 
 static unsigned int fsl_pwm_ticks_to_ns(struct fsl_pwm_chip *fpc,
@@ -301,6 +309,17 @@ static int fsl_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pwm_state *oldstate = &pwm->state;
 	int ret;
 
+	if (fpc->suspended) {
+		if (newstate->enabled)
+			return -EIO;
+
+		ret = regmap_set_bits(fpc->regmap, FTM_OUTMASK,
+				      BIT(pwm->hwpwm));
+		if (!ret)
+			fpc->suspended_enabled &= ~BIT(pwm->hwpwm);
+		return ret;
+	}
+
 	/*
 	 * oldstate to newstate : action
 	 *
@@ -476,9 +495,13 @@ static int fsl_pwm_suspend(struct device *dev)
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 	int i;
 
+	if (fpc->suspended)
+		return 0;
+
 	regcache_cache_only(fpc->regmap, true);
 	regcache_mark_dirty(fpc->regmap);
 
+	fpc->suspended_enabled = 0;
 	for (i = 0; i < chip->npwm; i++) {
 		struct pwm_device *pwm = &chip->pwms[i];
 
@@ -490,10 +513,13 @@ static int fsl_pwm_suspend(struct device *dev)
 		if (!pwm_is_enabled(pwm))
 			continue;
 
+		fpc->suspended_enabled |= BIT(i);
 		clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_CNTEN]);
 		clk_disable_unprepare(fpc->clk[fpc->period.clk_select]);
 	}
 
+	fpc->suspended = true;
+
 	return 0;
 }
 
@@ -501,28 +527,67 @@ static int fsl_pwm_resume(struct device *dev)
 {
 	struct pwm_chip *chip = dev_get_drvdata(dev);
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
-	int i;
+	int i, ret;
+
+	if (!fpc->suspended)
+		return 0;
 
 	for (i = 0; i < chip->npwm; i++) {
 		struct pwm_device *pwm = &chip->pwms[i];
+		bool requested = test_bit(PWMF_REQUESTED, &pwm->flags);
 
-		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
-			continue;
-
-		clk_prepare_enable(fpc->ipg_clk);
+		if (requested) {
+			ret = clk_prepare_enable(fpc->ipg_clk);
+			if (ret)
+				goto unwind;
+		}
 
-		if (!pwm_is_enabled(pwm))
+		if (!(fpc->suspended_enabled & BIT(i)))
 			continue;
 
-		clk_prepare_enable(fpc->clk[fpc->period.clk_select]);
-		clk_prepare_enable(fpc->clk[FSL_PWM_CLK_CNTEN]);
+		ret = clk_prepare_enable(fpc->clk[fpc->period.clk_select]);
+		if (ret) {
+			if (requested)
+				clk_disable_unprepare(fpc->ipg_clk);
+			goto unwind;
+		}
+
+		ret = clk_prepare_enable(fpc->clk[FSL_PWM_CLK_CNTEN]);
+		if (ret) {
+			clk_disable_unprepare(fpc->clk[fpc->period.clk_select]);
+			if (requested)
+				clk_disable_unprepare(fpc->ipg_clk);
+			goto unwind;
+		}
 	}
 
 	/* restore all registers from cache */
 	regcache_cache_only(fpc->regmap, false);
-	regcache_sync(fpc->regmap);
+	ret = regcache_sync(fpc->regmap);
+	if (ret) {
+		regcache_cache_only(fpc->regmap, true);
+		regcache_mark_dirty(fpc->regmap);
+		goto unwind;
+	}
+
+	fpc->suspended = false;
+	fpc->suspended_enabled = 0;
 
 	return 0;
+
+unwind:
+	while (i--) {
+		struct pwm_device *pwm = &chip->pwms[i];
+
+		if (fpc->suspended_enabled & BIT(i)) {
+			clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_CNTEN]);
+			clk_disable_unprepare(fpc->clk[fpc->period.clk_select]);
+		}
+		if (test_bit(PWMF_REQUESTED, &pwm->flags))
+			clk_disable_unprepare(fpc->ipg_clk);
+	}
+
+	return ret;
 }
 #endif
 

base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
-- 
2.50.1 (Apple Git-155)


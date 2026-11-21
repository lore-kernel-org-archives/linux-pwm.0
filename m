Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244385;
	b=aHPxW41mT3NMuNjpvyaJec7iARXRxeFHW0EPJsdV5dN3qfWd62N8JFisGk0lrqQpcASc
	 6h6RXPw0qTVYMk1JJJ+Krmpxpy4qc0qEm0RtPE5wxALTf//G6LrW8kns0Og1f2vMJ7aAc
	 fuEdtmnyJwYIwLt4YmiUdxhIa3bUdtW6KeKPsF//tRPxm0tKLA1D/QUAz0j94t9IzBca3
	 KjvZ5llukIG8EhczXyWru+CEhrJx3puMj2krdQjpzcjS3iQbcUGTzgYZjzZeOJ5LAr/oP
	 RIiplokbJwEMOvkf2WPX4+g3v06fXIki08LwU+/fFxeRCGYV5yRgd8Op7WApOCZTpxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244385;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jK2zYQmh64qPZi1PcNYWIZ+ueibLnSi2h0M89dZtMcg=;
	b=IcSdFTk5+JmAgQ/q+YZdv3k3DrNf3wwv97xMWz+NaxxHb3xCFGLYOJXptw9KHVgkZ5mX
	 c0AtQSxp7884jzVdiB7tRUq1oaNq6SAhTDPHxB7/Tv+Gs8AjHwCN7NDWv/YCZzQBge5m+
	 LcnxStfitEESLrMzGBQ08R72D7MaewcOynbOokFTYdeFjYrwkAu3nrrs4PgPfnzhlW+CS
	 dpimn+vPyIj63OsaCMRNhb6HZVUh3rm2kWW2TSAryCDe+OPCu8G1okuLMd7f6hL4CXiqi
	 NoytHkPiqAyPI+fpF8Yv6QDvKjxgN6dDSsxdV4TR2VWKFXknt9XO70+3NgvfWpknP5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="pElU/YCg";
	arc=none smtp.remote-ip=203.205.221.155
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3E0606A330;
	Sat, 21 Nov 2026 06:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F3E0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=pElU/YCg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795244382; bh=jK2zYQmh64qPZi1PcNYWIZ+ueibLnSi2h0M89dZtMcg=;
	h=From:To:Cc:Subject:Date;
	b=pElU/YCguCeDHzYXiYZAXUWSu5OfRdfp7/zbiybcDOhKx5azB2T2jpb+9bNDBA4za
	 VnUdqYjCWEiVCuU0MJ9cRH2F/36K/fzlq5u5YEtx9nkPZ37wC4Q70bE8/dlEtpHBUt
	 HQT874azzwFBb5MmZy7AGV/OiYG9HVnWsVXZUTRE=
Received: from jerry-PC.lan ([2408:8249:5f:7101:71a:8713:56b4:5043])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id EE72042D; Sat, 21 Nov 2026 14:59:39 +0800
X-QQ-mid: xmsmtpt1795244379t6zcn6lw1
Message-ID: <tencent_27C5A1EA3CF33BA5221F7F01A066E92BCC07@qq.com>
X-QQ-XMAILINFO: Mpt5V4XGwnFy4a/nabu402ZCgr4HCjbav7E+2nIRO5S+M9bW9j16AgO0eYZNxO
	 Z/QSlGGFAV96WP9hht/6bqcxhLGoaztLNOYmXxy/3oIqdNhSwMoL0N1Ay1ELmbXRBQB0XM0Gix8k
	 mYFlVQIRKhdEe4hRWIF8JqVcmuj7xapfA/4+QJsSm+sUFi59otfV2fHOjSYlN4PJBoMgoJcuJoWb
	 MgnjNVsIuIQ3XUaWbe6YP+L2+bf7wN0F27uxwmrxnM+WVNdaFdRco3IyTplKdplG317qZH8NX0SS
	 fQll/9vJGL9uB1sxzfDRZTgD3I0bVuc5IcdSD9C7ZVW2cWNovWUHKlTocpuBAglOB6cbAPtMmTKR
	 xqHGMKZc1nE5DtCnAzRyejjiQNQ6FVhIMEKjmOYCtUH6GRR0CAig/F+7aKDfDdKRe7oht/UiTrAU
	 WP/Rb6vHcoClZL3Aw4Umaqiwl1wNaZiYcrKMU+bjXE8XLm2Zoclzh7aJ/ZUpHcSNJ+B+3CYM1P51
	 Hd8TRKzz2ixnJqXD2CY/sYrcpD62cPLyTHDoBajmBgJBlutHGYXURVuvB1An6jAZJrUyAjOi0y2k
	 hCYY3rbXwJDbk320sclhaLTK2aHDWlHfhR436O96XHRRqwruVVEo++iNvUJhA57qlUHdC29cBU/Q
	 YBbPVi828deqwxn4CbmVAsIFyn8G3yThlhF5nzHmt4gIOyWJc9DUfLjWKX+LYqhDfDNLTW6tu8zM
	 /MdCVpvtjYnDl4EUOZiIW0Mjckp1ASLOe/0uGvMpRuD+QUNtZRK7DzbKD4E9BClSMaQk5eqq7QmN
	 NGB3C6VeuWiHE5tHLuIda/9k/XhOVG+bLomj1Uj/MUNBAlXNg3O45aTH0wrIM/hgesw0WxzL73Hd
	 490qOg6sbyb39XeFCm7U9FKmLkBwzvQAnTwF3W1sTkiHFI8DXGCi6/ZWhZdL726oRk8xACoGo2c8
	 jmqahsEIWIZ62rvzD9ugzWGn95WB8pPX8/XnOHmnfZLvXrcquQm3LvirycHSy/Uwp6BmQu0qwLAE
	 YCmGaDvNCLuVxs2bqEH8didhEX23RFne4vGPymTz9S5RLy/5WBrlHL83MISIyPGeyFThp8fKPfAU
	 osIy+e+vo/BXm0oDttX02Dq6h4dG0Q52/rGx2DUUVOGYxqj1k=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: ZhuXiangyu <1194781887@qq.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	ZhuXiangyu <1194781887@qq.com>
Subject: [PATCH 1/2] pwm: rockchip: add PWM v4 support
Date: Sat, 21 Nov 2026 14:59:35 +0800
X-OQ-MSGID: <20261121065936.1125919-1-1194781887@qq.com>
X-Mailer: git-send-email 2.47.3
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

Add basic support for the Rockchip PWM v4 controller found on the
RK3506 and RK3576 SoCs. Compared to the earlier versions, v4 moves the
enable bits into a separate register, uses hiword write masks for the
control fields and latches a new configuration with a control-update
bit.

Only continuous output mode is supported for now.

Tested on an RK3506 board with a 100 kHz output at 40% duty cycle,
including enable/disable, verified on an oscilloscope.

Tested-by: ZhuXiangyu <1194781887@qq.com>
Signed-off-by: ZhuXiangyu <1194781887@qq.com>
---
 drivers/pwm/pwm-rockchip.c | 146 +++++++++++++++++++++++++++++++++----
 1 file changed, 130 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 050ca8aa..aa89f23d 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/limits.h>
 #include <linux/math64.h>
@@ -31,6 +32,27 @@
 #define PWM_LOCK_EN		(1 << 6)
 #define PWM_LP_DISABLE		(0 << 8)
 
+/*
+ * Register layout for PWM v4
+ */
+#define PWM_V4_HIWORD_UPDATE(v, l, h) \
+	((((v) << (l)) & GENMASK((h), (l))) | (GENMASK((h), (l)) << 16))
+
+#define PWM_V4_ENABLE_MASK		GENMASK(1, 0)
+#define PWM_V4_CLK_EN(v)		PWM_V4_HIWORD_UPDATE(v, 0, 0)
+#define PWM_V4_EN(v)			PWM_V4_HIWORD_UPDATE(v, 1, 1)
+#define PWM_V4_CTRL_UPDATE_EN(v)	PWM_V4_HIWORD_UPDATE(v, 2, 2)
+
+#define PWM_V4_MODE(v)			PWM_V4_HIWORD_UPDATE(v, 0, 1)
+#define PWM_V4_CONTINUOUS		1
+#define PWM_V4_POLARITY(v)		PWM_V4_HIWORD_UPDATE(v, 2, 3)
+#define PWM_V4_DUTY_NEGATIVE		(0 << 0)
+#define PWM_V4_DUTY_POSITIVE		BIT(0)
+#define PWM_V4_INACTIVE_NEGATIVE	(0 << 1)
+#define PWM_V4_INACTIVE_POSITIVE	BIT(1)
+#define PWM_V4_CTRL_DUTY_POSITIVE	BIT(2)
+#define PWM_V4_ALIGNED_INVALID(v)	PWM_V4_HIWORD_UPDATE(v, 5, 5)
+
 struct rockchip_pwm_chip {
 	struct clk *clk;
 	struct clk *pclk;
@@ -43,6 +65,7 @@ struct rockchip_pwm_regs {
 	unsigned long period;
 	unsigned long cntr;
 	unsigned long ctrl;
+	unsigned long enable;
 };
 
 struct rockchip_pwm_data {
@@ -88,13 +111,25 @@ static int rockchip_pwm_get_state(struct pwm_chip *chip,
 	tmp *= prescaled_ns;
 	state->duty_cycle =  DIV_U64_ROUND_UP(tmp, clk_rate);
 
-	val = readl_relaxed(pc->base + pc->data->regs.ctrl);
-	state->enabled = (val & enable_conf) == enable_conf;
+	if (pc->data->regs.enable) {
+		val = readl_relaxed(pc->base + pc->data->regs.enable);
+		state->enabled = (val & enable_conf) == enable_conf;
 
-	if (pc->data->supports_polarity && !(val & PWM_DUTY_POSITIVE))
-		state->polarity = PWM_POLARITY_INVERSED;
-	else
-		state->polarity = PWM_POLARITY_NORMAL;
+		val = readl_relaxed(pc->base + pc->data->regs.ctrl);
+		if (pc->data->supports_polarity &&
+		    !(val & PWM_V4_CTRL_DUTY_POSITIVE))
+			state->polarity = PWM_POLARITY_INVERSED;
+		else
+			state->polarity = PWM_POLARITY_NORMAL;
+	} else {
+		val = readl_relaxed(pc->base + pc->data->regs.ctrl);
+		state->enabled = (val & enable_conf) == enable_conf;
+
+		if (pc->data->supports_polarity && !(val & PWM_DUTY_POSITIVE))
+			state->polarity = PWM_POLARITY_INVERSED;
+		else
+			state->polarity = PWM_POLARITY_NORMAL;
+	}
 
 	clk_disable(pc->clk);
 	clk_disable(pc->pclk);
@@ -102,6 +137,47 @@ static int rockchip_pwm_get_state(struct pwm_chip *chip,
 	return 0;
 }
 
+static void rockchip_pwm_config_v4(struct pwm_chip *chip, struct pwm_device *pwm,
+				   const struct pwm_state *state)
+{
+	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
+	u64 prescaled_ns = (u64)pc->data->prescaler * NSEC_PER_SEC;
+	u64 clk_rate, tmp;
+	u32 period_ticks, duty_ticks;
+
+	clk_rate = clk_get_rate(pc->clk);
+
+	tmp = mul_u64_u64_div_u64(clk_rate, state->period, prescaled_ns);
+	if (tmp > U32_MAX)
+		tmp = U32_MAX;
+	period_ticks = tmp;
+
+	tmp = mul_u64_u64_div_u64(clk_rate, state->duty_cycle, prescaled_ns);
+	if (tmp > U32_MAX)
+		tmp = U32_MAX;
+	duty_ticks = tmp;
+
+	writel_relaxed(period_ticks, pc->base + pc->data->regs.period);
+	writel_relaxed(duty_ticks, pc->base + pc->data->regs.duty);
+
+	if (pc->data->supports_polarity) {
+		if (state->polarity == PWM_POLARITY_INVERSED)
+			writel_relaxed(PWM_V4_POLARITY(PWM_V4_DUTY_NEGATIVE |
+						       PWM_V4_INACTIVE_POSITIVE),
+				       pc->base + pc->data->regs.ctrl);
+		else
+			writel_relaxed(PWM_V4_POLARITY(PWM_V4_DUTY_POSITIVE |
+						       PWM_V4_INACTIVE_NEGATIVE),
+				       pc->base + pc->data->regs.ctrl);
+	}
+
+	writel_relaxed(PWM_V4_MODE(PWM_V4_CONTINUOUS) |
+		       PWM_V4_ALIGNED_INVALID(false),
+		       pc->base + pc->data->regs.ctrl);
+	writel_relaxed(PWM_V4_CTRL_UPDATE_EN(true),
+		       pc->base + pc->data->regs.enable);
+}
+
 static void rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			       const struct pwm_state *state)
 {
@@ -175,14 +251,31 @@ static int rockchip_pwm_enable(struct pwm_chip *chip,
 			return ret;
 	}
 
-	val = readl_relaxed(pc->base + pc->data->regs.ctrl);
-
-	if (enable)
-		val |= enable_conf;
-	else
-		val &= ~enable_conf;
+	if (pc->data->regs.enable) {
+		writel_relaxed(PWM_V4_EN(enable) | PWM_V4_CLK_EN(enable),
+			       pc->base + pc->data->regs.enable);
+
+		if (!enable) {
+			struct pwm_state curstate;
+
+			/*
+			 * In continuous mode the disable takes effect at the end
+			 * of the current period, so keep the clock running for
+			 * one more period.
+			 */
+			pwm_get_state(pwm, &curstate);
+			fsleep(DIV_ROUND_UP_ULL(curstate.period, NSEC_PER_USEC));
+		}
+	} else {
+		val = readl_relaxed(pc->base + pc->data->regs.ctrl);
+
+		if (enable)
+			val |= enable_conf;
+		else
+			val &= ~enable_conf;
 
-	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
+		writel_relaxed(val, pc->base + pc->data->regs.ctrl);
+	}
 
 	if (!enable)
 		clk_disable(pc->clk);
@@ -217,7 +310,10 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		enabled = false;
 	}
 
-	rockchip_pwm_config(chip, pwm, state);
+	if (pc->data->regs.enable)
+		rockchip_pwm_config_v4(chip, pwm, state);
+	else
+		rockchip_pwm_config(chip, pwm, state);
 	if (state->enabled != enabled) {
 		ret = rockchip_pwm_enable(chip, pwm, state->enabled);
 		if (ret)
@@ -291,11 +387,26 @@ static const struct rockchip_pwm_data pwm_data_v3 = {
 		       PWM_CONTINUOUS,
 };
 
+static const struct rockchip_pwm_data pwm_data_v4 = {
+	.regs = {
+		.duty = 0x14,
+		.period = 0x10,
+		.ctrl = 0xc,
+		.enable = 0x4,
+	},
+	.prescaler = 1,
+	.supports_polarity = true,
+	.supports_lock = true,
+	.enable_conf = PWM_V4_ENABLE_MASK,
+};
+
 static const struct of_device_id rockchip_pwm_dt_ids[] = {
 	{ .compatible = "rockchip,rk2928-pwm", .data = &pwm_data_v1 },
 	{ .compatible = "rockchip,rk3288-pwm", .data = &pwm_data_v2 },
 	{ .compatible = "rockchip,vop-pwm", .data = &pwm_data_vop },
 	{ .compatible = "rockchip,rk3328-pwm", .data = &pwm_data_v3 },
+	{ .compatible = "rockchip,rk3506-pwm", .data = &pwm_data_v4 },
+	{ .compatible = "rockchip,rk3576-pwm", .data = &pwm_data_v4 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rockchip_pwm_dt_ids);
@@ -327,7 +438,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 
 	count = of_count_phandle_with_args(pdev->dev.of_node,
 					   "clocks", "#clock-cells");
-	if (count == 2)
+	if (count >= 2)
 		pc->pclk = devm_clk_get(&pdev->dev, "pclk");
 	else
 		pc->pclk = pc->clk;
@@ -351,7 +462,10 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	chip->ops = &rockchip_pwm_ops;
 
 	enable_conf = pc->data->enable_conf;
-	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
+	if (pc->data->regs.enable)
+		ctrl = readl_relaxed(pc->base + pc->data->regs.enable);
+	else
+		ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
 	enabled = (ctrl & enable_conf) == enable_conf;
 
 	ret = pwmchip_add(chip);
-- 
2.47.3


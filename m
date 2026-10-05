Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E2C45A288
	for <linux-pwm@vger.kernel.org>; Mon,  5 Oct 2026 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194792; cv=none; b=pRKAvN2+HLmRxFXp+NbuJQmr7t1pn7pxgsmToKuVSKXuHOz2Q6Ips5n8lMJHqnkKLINOJDklvvfKGRRqU0QA7CXZ41D5nn4Qn1Bvt5+X9znvEoocFIM8pxlFATghOsKqv+CP3sMSuthyaLfXa8ikilvlYbmm59Y+wSqDmbpelNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194792; c=relaxed/simple;
	bh=VB8BQ5itOA7qV7pL/JQGpmUuz7Pn5ML+e0XikXEwU/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sEDpSvb+lv2/R9k4B912Cy/pb3tMh51CKEY8z50PbmCWFYOoGchjACVjbmsFQ89fER8qe0WVWbAMwyHxhTj5nF3jgheYHfPobeaQuBAqcYzeml0HOMqZoTh7fD1Y8ODr3L7lGF6gvGG4cQAgpCs5jz2BTjn/x/fc19vagzTL0fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=J7Ja+bUB; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="J7Ja+bUB"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a1f611461so107195966b.1
        for <linux-pwm@vger.kernel.org>; Mon, 05 Oct 2026 03:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791194787; x=1791799587; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7nURLu1/ElhpL7QPrHRaOTl98U+Qppw3030lnepkkiU=;
        b=J7Ja+bUBllAGTjlgMT7bCnvmyCeGPpXRSg0k3fwT84Qe0nBOMRS3SAI/AT070+30tB
         tA5tDKlC0aGZllN9RxE0cqpUUi4FFiD6FUefMB6QvbkAJ0Ql7us9l8OJ/xeaApRsueP+
         HMqpOiy45si7+OBGsen6B7foVjSgrqTDOAJEUoocQoA0fGTw1zDCtiFm+ckyIiNJz4SR
         E3L2+aGfziO4KwgcB6An7UG7AmIBUZBOAtadW+nxNupT/sl5XK/OVNkGvhxt22uW3C9M
         F8KlR9sJlsr+xEpZjdAvvEohu/KmgWX4Iewxws7f7DWPbiBXjL57+V9UzV00F1O16JBc
         wFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791194787; x=1791799587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7nURLu1/ElhpL7QPrHRaOTl98U+Qppw3030lnepkkiU=;
        b=gw53Ywxb/GPjOY9lFTg4duAttwAHIT1HoCHPiC+FzM0CX1DWQklGrJtTD2vXPoDzg/
         L42Knig2aMQIBS77E0SrJje0200H7qd/8ESHMH3ki/uH4IGVGiDDm7uePBLQzbp3N5BY
         BS4SkfYFwUPWiMWiPueT5UpaDrKPuCTMqYLpmWSPPlvmhvbFmA+znPykWswomvZz0CaE
         FkclCox0R/j/2x9nJhF+dJ+/WlWMc2ebYMUFbjQA0XcNMqEhRG6q09fkwp32bS/KXu+g
         CFAE4icV053cFw6skc9aw+jntE16wel4vdjrZk9OAssK0GaK3phZ3f0fImA6FRQxxpl1
         9xHg==
X-Forwarded-Encrypted: i=1; AKwUvBwR3HshDh0sznEuLLIKQlddiKQjxXbcGrmF/WQh0wdw0P1YDAxd65L65ChFspFcS9TNaiioDrGzGlk=@vger.kernel.org
X-Gm-Message-State: AFuF++m1wPJ6st44j4MiT58f8btDrU3asAhZm0Y4FSuGl1cR7sjagZz6
	uVqiO4td9ZhrIsE3gA8hwA36QCMt3vsgLGCwAYmYbn5XfCNT9gk2X0ujPfAgtfQ1SHDzWXzseD9
	TlPPS
X-Gm-Gg: AYBFou3BjuvfOT24IEwozjttbSgQa/379/6F5/KKnEKNtYTbRlKHs9X1H484GjOAQ0j
	jZ5XaZcAVb6vGGEwX4DkowtKzY6uBijgD0QeIFpg2bXijJPl9ePwHBw6GAUZE2BlcApT7Bspmys
	Qd1PPfGNzjnzzSa94y5CSyGHOTPvu9xJME5TWnclTkY7BbZG1j50+WGEKz62D2lZ9O3PKCWqV9w
	VTQTxNMI3/gdLgEFnPk5EsAot4QTbLmeTj+fKeiFWb0SHJYl+KrD4Ayby5v2O8o3c1Ud+Btx0O6
	G2DTS46jZvtvynb2WsrfmK0cew5gXBjlsfCDeuicSV7DI0ZXBSsWjYJRnOt01xBWgkiop0MOt2l
	zWSsCehmUyDcpRMl4kLQL2Kns2sz4xYvrPUjEYQ0v1gxY7by04kg3lakZcIKAY3tJShPX1GQE9B
	e54zClDOgmygbznih4RoojhgH7Kv1rwxyAOrFBOc1Urud+z6Vh2V2xNdVDJnFGCW45HafHWlht6
	8OR7wyjuo9PNP2pJbwv6SIjb1yc6Fteggs9B9hBIvwM/3hf9g==
X-Received: by 2002:a17:907:e8c:b0:c25:f7db:4beb with SMTP id a640c23a62f3a-c2e4ad423b6mr861458166b.17.1791194787222;
        Mon, 05 Oct 2026 03:06:27 -0700 (PDT)
Received: from [192.168.0.42] (host93-7-32-195.dimensionesrl.eu. [195.32.7.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3156360832sm50800766b.75.2026.10.05.03.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 03:06:26 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 05 Oct 2026 12:06:24 +0200
Subject: [PATCH 2/2] drivers: pwm: add mcf54415 mcPWM support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-wip-bl-stmark2-pwm-v1-2-168b9dc653f2@baylibre.com>
References: <20261005-wip-bl-stmark2-pwm-v1-0-168b9dc653f2@baylibre.com>
In-Reply-To: <20261005-wip-bl-stmark2-pwm-v1-0-168b9dc653f2@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.15.2

From: Angelo Dureghello <adureghello@baylibre.com>

Add initial basic mcf54415 mcPWM (motor control PWM) support, to be
used with mcf54415/6/7/8 NXP SoCs.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/pwm/Kconfig   |  11 +
 drivers/pwm/Makefile  |   1 +
 drivers/pwm/pwm-mcf.c | 646 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 658 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 729776086879..ddb98bec33d3 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -486,6 +486,17 @@ config PWM_MC33XS2410
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-mc33xs2410.
 
+config PWM_MCF
+	tristate "NXP ColdFire mcPWM support"
+	depends on M5441x || COMPILE_TEST
+	select REGMAP_MMIO
+	help
+	   NXP ColdFire mcPWM (motor control PWM) support. This module is
+	   available in the mcf5441x CPU family,
+
+	   To compile this driver as a module, choose M here: the module
+	   will be called pwm-mcf.
+
 config PWM_MEDIATEK
 	tristate "MediaTek PWM support"
 	depends on ARCH_MEDIATEK || RALINK || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 5630a521a7cf..471c29e25255 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
 obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
 obj-$(CONFIG_PWM_MAX7360)	+= pwm-max7360.o
 obj-$(CONFIG_PWM_MC33XS2410)	+= pwm-mc33xs2410.o
+obj-$(CONFIG_PWM_MCF)		+= pwm-mcf.o
 obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
 obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
 obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
diff --git a/drivers/pwm/pwm-mcf.c b/drivers/pwm/pwm-mcf.c
new file mode 100644
index 000000000000..b1dec215ef64
--- /dev/null
+++ b/drivers/pwm/pwm-mcf.c
@@ -0,0 +1,646 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: 2026 BayLibre, SAS.
+/*
+ * Simple driver for mcPWM (Motor Control Pulse Width Modulation)
+ * controller, available on ColdFire SoCs mcf54415/6/7/8.
+ *
+ * Reference Manual:
+ * https://www.nxp.com/docs/en/reference-manual/MCF54418RM.pdf
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/log2.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+
+#define MCF_PWM_SUBMODS			0x04
+#define MCF_PWM_SUB_OFFS(n)		((n) * MCFPWM_SUB_SIZE)
+
+#define MCF_PWM_SM_CNT			0x00
+#define MCF_PWM_SM_INIT			0x02
+#define MCF_PWM_SM_CR2			0x04
+#define MCF_PWM_SM_CR2_IND		BIT(13)
+#define MCF_PWM_SM_CR1			0x06
+#define MCF_PWM_SM_CR1_FULL		BIT(10)
+#define MCF_PWM_SM_CR1_PRSC		GENMASK(6, 4)
+#define MCF_PWM_SM_VAL0			0x08
+#define MCF_PWM_SM_VAL1			0x0A
+#define MCF_PWM_SM_VAL2			0x0C
+#define MCF_PWM_SM_VAL3			0x0E
+#define MCF_PWM_SM_VAL4			0x10
+#define MCF_PWM_SM_VAL5			0x12
+#define MCF_PWM_SM_OCR			0x18
+#define MCF_PWM_SM_OCR_POL_A		BIT(10)
+#define MCF_PWM_SM_OCR_POL_B		BIT(9)
+#define MCF_PWM_SM_OCR_POL_X		BIT(8)
+#define MCF_PWM_SM_SR			0x1a
+#define MCF_PWM_SM_DISMAP		0x22
+
+#define MCF_PWM_OUTEN			0x140
+#define MCF_PWM_OUTEN_PWMA_EN		GENMASK(11, 8)
+#define MCF_PWM_MCR			0x148
+#define MCF_PWM_MCR_LDOK		GENMASK(3, 0)
+#define MCF_PWM_MCR_CLDOK		GENMASK(7, 4)
+#define MCF_PWM_MCR_RUN			GENMASK(11, 8)
+#define MCF_PWM_FSR			0x14e
+
+struct pwm_mcf {
+	struct regmap *map;
+	struct clk *clk;
+	unsigned long rate;
+	u64 period_ns_min;
+	u64 period_ns_max;
+};
+
+struct pwm_mcf_waveform {
+	u8 enable;
+	u8 prescaler;
+	s16 init;
+	s16 val0;
+	s16 val1;
+	s16 val2;
+	s16 val3;
+	s16 val4;
+	s16 val5;
+};
+
+static const struct regmap_config pwm_mcf_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 16,
+	.reg_stride = 2,
+	.max_register = MCFPWM_SIZE, /* R.M. Table 34-4, PWM Memory Map */
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+	.reg_format_endian = REGMAP_ENDIAN_BIG,
+};
+
+static inline struct pwm_mcf *pwm_mcf_from_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static int pwm_mcf_regmap_read(struct regmap *map, int submod,
+			       unsigned int reg, unsigned int *val)
+{
+	/* Avoid any global configuration register overwrite. */
+	if (submod >= MCF_PWM_SUBMODS)
+		return -EINVAL;
+
+	return regmap_read(map, MCF_PWM_SUB_OFFS(submod) + reg, val);
+}
+
+static int pwm_mcf_regmap_write(struct regmap *map, int submod,
+				unsigned int reg, unsigned int val)
+{
+	if (submod >= MCF_PWM_SUBMODS)
+		return -EINVAL;
+
+	return regmap_write(map, MCF_PWM_SUB_OFFS(submod) + reg, val);
+}
+
+static int pwm_mcf_regmap_set_bits(struct regmap *map, int submod,
+				   unsigned int reg, unsigned int bits)
+{
+	if (submod >= MCF_PWM_SUBMODS)
+		return -EINVAL;
+
+	return regmap_set_bits(map, MCF_PWM_SUB_OFFS(submod) + reg, bits);
+}
+
+#ifdef DEBUG
+static void pwm_mcf_dump_regs(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_mcf *priv = pwm_mcf_from_chip(chip);
+	struct device *dev = pwmchip_parent(chip);
+	unsigned int val, ch;
+
+	ch = pwm->hwpwm;
+
+	dev_dbg(dev, "***** mcPWM register set       *****\n");
+	regmap_read(priv->map, MCF_PWM_MCR, &val);
+	dev_dbg(dev, "***** MCF_PWM_MCR:        %04x *****\n", val);
+	regmap_read(priv->map, MCF_PWM_FSR, &val);
+	dev_dbg(dev, "***** MCF_PWM_FSR:        %04x *****\n", val);
+	regmap_read(priv->map, MCF_PWM_OUTEN, &val);
+	dev_dbg(dev, "***** MCF_PWM_OUTEN:      %04x *****\n", val);
+	pwm_mcf_regmap_read(priv->map, ch, MCF_PWM_SM_CR1, &val);
+	dev_dbg(dev, "***** MCF_PWM_SM_CR1(%d):  %04x *****\n", ch, val);
+	pwm_mcf_regmap_read(priv->map, ch, MCF_PWM_SM_CR2, &val);
+	dev_dbg(dev, "***** MCF_PWM_SM_CR2(%d):  %04x *****\n", ch, val);
+	pwm_mcf_regmap_read(priv->map, ch, MCF_PWM_SM_CNT, &val);
+	dev_dbg(dev, "***** MCF_PWM_SM_CNT(%d):  %04x *****\n", ch, val);
+	pwm_mcf_regmap_read(priv->map, ch, MCF_PWM_SM_SR, &val);
+	dev_dbg(dev, "***** MCF_PWM_SM_SR(%d):   %04x *****\n", ch, val);
+	pwm_mcf_regmap_read(priv->map, ch, MCF_PWM_SM_OCR, &val);
+	dev_dbg(dev, "***** MCF_PWM_SM_OCR(%d):  %04x *****\n", ch, val);
+	pwm_mcf_regmap_read(priv->map, ch, MCF_PWM_SM_INIT, &val);
+	dev_dbg(dev, "***** MCF_PWM_SM_INIT(%d): %04x *****\n", ch, val);
+	pwm_mcf_regmap_read(priv->map, ch, MCF_PWM_SM_VAL0, &val);
+	dev_dbg(dev, "***** MCF_PWM_SM_VAL0(%d): %04x *****\n", ch, val);
+	pwm_mcf_regmap_read(priv->map, ch, MCF_PWM_SM_VAL1, &val);
+	dev_dbg(dev, "***** MCF_PWM_SM_VAL1(%d): %04x *****\n", ch, val);
+	pwm_mcf_regmap_read(priv->map, ch, MCF_PWM_SM_VAL2, &val);
+	dev_dbg(dev, "***** MCF_PWM_SM_VAL2(%d): %04x *****\n", ch, val);
+	pwm_mcf_regmap_read(priv->map, ch, MCF_PWM_SM_VAL3, &val);
+	dev_dbg(dev, "***** MCF_PWM_SM_VAL3(%d): %04x *****\n", ch, val);
+}
+#endif
+
+/*
+ * From R.M. 34.3.21.
+ * Considering a submodule n, setting the n-th LDOK bit, PWM_SMnCR1[PRSC],
+ * PWM_SMnINIT, and PWM_SMnVAL are loaded into a set of buffers.
+ * The pulse width take effect at the next PWM reload if LDMOD is cleared, or
+ * immediately if LDMOD is set.
+ * As per R.M., any LDOK bit must be set only by reading it, checking if it is
+ * zero, and then writing a logic one to it.
+ */
+static int pwm_mcf_set_mcr_ldok(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_mcf *priv = pwm_mcf_from_chip(chip);
+	unsigned int val, bit;
+	int ch, ret;
+
+	ch = pwm->hwpwm;
+
+	bit = FIELD_PREP(MCF_PWM_MCR_LDOK, BIT(ch));
+	ret = regmap_read_poll_timeout(priv->map, MCF_PWM_MCR, val,
+				       !(val & bit), 10, 1000);
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(priv->map, MCF_PWM_MCR,
+			       FIELD_PREP(MCF_PWM_MCR_LDOK, BIT(ch)));
+}
+
+/*
+ * Any LDOK PWM_MCF bit can be cleared manually setting respective CLDOK bit.
+ */
+static int pwm_mcf_clear_mcr_ldok(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_mcf *priv = pwm_mcf_from_chip(chip);
+	int val;
+
+	val = FIELD_PREP(MCF_PWM_MCR_CLDOK, BIT(pwm->hwpwm));
+
+	return regmap_set_bits(priv->map, MCF_PWM_MCR, val);
+}
+
+static int pwm_mcf_calc_prescaler(u64 period_ns, unsigned long *rate, u8 *presc)
+{
+	u64 ticks = mul_u64_u32_div(period_ns, *rate, NSEC_PER_SEC);
+	u32 pmin = max(1U, DIV_ROUND_UP_ULL(ticks, 65535ULL));
+	u32 ps = roundup_pow_of_two(pmin);
+
+	*rate /= ps;
+	/* Register asks a 3 bit bitmask to reach 128 max. */
+	*presc = ilog2(ps);
+
+	return 0;
+}
+
+static int pwm_mcf_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_mcf *priv = pwm_mcf_from_chip(chip);
+	unsigned int ch;
+	int ret;
+
+	dev_dbg(pwmchip_parent(chip), "%s() enabling ch %d\n",
+		__func__, pwm->hwpwm);
+
+	ch = pwm->hwpwm;
+
+	/*
+	 * RUN specific submodule.
+	 * RM 34.5: initialize all registers and set the PWM_MCR[LDOK]
+	 * bit before setting the PWM_MCR[RUN] bit. We are here always after
+	 * apply, so LDOK bits has been always cleared before.
+	 */
+	ret = pwm_mcf_set_mcr_ldok(chip, pwm);
+	if (ret)
+		return ret;
+
+	/* Remove high impedance now. */
+	ret = regmap_set_bits(priv->map, MCF_PWM_OUTEN,
+			      FIELD_PREP(MCF_PWM_OUTEN_PWMA_EN, BIT(ch)));
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(priv->map, MCF_PWM_MCR,
+			       FIELD_PREP(MCF_PWM_MCR_RUN, BIT(ch)));
+}
+
+static int pwm_mcf_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_mcf *priv = pwm_mcf_from_chip(chip);
+	int ch, val, ret;
+
+	ch = pwm->hwpwm;
+
+	/* STOP specific submodule. */
+	ret = regmap_clear_bits(priv->map, MCF_PWM_MCR,
+				FIELD_PREP(MCF_PWM_MCR_RUN, BIT(ch)));
+	if (ret)
+		return ret;
+
+	/* Set high impedance. */
+	val = FIELD_PREP(MCF_PWM_OUTEN_PWMA_EN, BIT(ch));
+	ret = regmap_clear_bits(priv->map, MCF_PWM_OUTEN, val);
+	if (ret)
+		return ret;
+
+	clk_disable_unprepare(priv->clk);
+
+	return ret;
+}
+
+static int pwm_mcf_round_waveform_tohw(struct pwm_chip *chip,
+				       struct pwm_device *pwm,
+				       const struct pwm_waveform *wf,
+				       void *_wfhw)
+{
+	struct device *dev = pwmchip_parent(chip);
+	struct pwm_mcf *priv = pwm_mcf_from_chip(chip);
+	struct pwm_mcf_waveform *wfhw = _wfhw;
+	u16 half_period, duty;
+	unsigned long rate;
+	u64 period_ns;
+	u8 prescaler;
+	int ret, val;
+
+	/*
+	 * The MCF mcPWM (motor control) module allows to set up and down edges
+	 * separately, for each submodule (channel) and for each output line
+	 * (A and B). Each channel has his own counter.
+	 *
+	 * INIT and VAL0 defines the whole counter range (max steps 2^16) for
+	 *   both A and B channels,
+	 * VAL0 must be the "half" of the counter range,
+	 * VAL2/3, often referred in the R.M. as PWM23, are respectively
+	 *   turn-on and turn-off edges for channel A,
+	 * VAL4/5, often referred in the R.M. as PWM45 are the same for
+	 *   channel B and not used/set.
+	 *
+	 * Timer:      time ->
+	 *
+	 *  VAL1 0x0100            _/|            /.            /.
+	 *    VAL3               _/| |          /  .          /  .
+	 *    VAL5             _/| | |        /    .        /    .
+	 *  VAL0 0x0000 -----_+- |-|-|------+------.------+------. half range
+	 *    VAL4         _/ |  | | |    /        .    /        .    /
+	 *    VAL2       _/ | |  | | |  /          .  /          .  /
+	 *  INIT 0xff00 / | | |  | | |/            ./            ./
+	 *              | |________|    .________.    .________,    .__
+	 *  A out       ._| .____. |_.__| .____. |_.__| .____. |_.__|
+	 *  B out       .___|   |____.____|   |____.____|    |___.____|
+	 *
+	 * Fron R.M. 34.4.1: center aligning the signals is not restricted
+	 * to symmetry around the zero count value, as any other number
+	 * also works. However, centering on zero provides the greatest range
+	 * in signed mode and simplifies the calculations.
+	 *
+	 * Signed values are used to have the prescaler working, using unsigned
+	 * values no PWM signal get generated (hw bug ?) ?
+	 */
+
+	period_ns = wf->period_length_ns;
+
+	if (period_ns == 0) {
+		*wfhw = (typeof(*wfhw)){
+			.enable = 0,
+		};
+		return 0;
+	}
+
+	/* Check min and max nanoseconds limits now. */
+
+	if (period_ns < priv->period_ns_min + 1) {
+		period_ns = priv->period_ns_min + 1;
+		return 1;
+	}
+
+	if (period_ns > priv->period_ns_max) {
+		dev_dbg(dev, "%s() period_ns %llu\n", __func__, period_ns);
+		return -EINVAL;
+	}
+
+	/*
+	 * Setting prescaler here, same function returns correct divided rate
+	 * to calculate period and duty_cycle counts later on.
+	 */
+	rate = priv->rate;
+	ret = pwm_mcf_calc_prescaler(period_ns, &rate, &prescaler);
+	if (ret)
+		return ret;
+
+	/*
+	 * Minimal resolution in ns would be a number.reminder, so using a
+	 * mul_u64_u32_div operation, as period_ns * rate / NSEC_PER_SEC.
+	 */
+	val = mul_u64_u32_div(period_ns, rate, NSEC_PER_SEC);
+	dev_dbg(dev, "%s() period val (count) %u\n", __func__, val);
+
+	half_period = val >> 1;
+
+	duty = mul_u64_u32_div(wf->duty_length_ns, rate, NSEC_PER_SEC);
+	dev_dbg(dev, "%s() duty val (count) %u\n", __func__, duty);
+
+	*wfhw = (typeof(*wfhw)){
+		.enable = 1,
+		.prescaler = prescaler,
+		.init = -half_period,
+		.val0 = 0,
+		.val1 = half_period - 1,
+		.val2 = -half_period,
+		.val3 = -half_period + duty,
+	};
+
+	return 0;
+}
+
+static int pwm_mcf_round_waveform_fromhw(struct pwm_chip *chip,
+					 struct pwm_device *pwm,
+					 const void *_wfhw,
+					 struct pwm_waveform *wf)
+{
+	struct device *dev = pwmchip_parent(chip);
+	struct pwm_mcf *priv = pwm_mcf_from_chip(chip);
+	const struct pwm_mcf_waveform *wfhw = _wfhw;
+	unsigned long rate;
+
+	if (wfhw->enable) {
+		rate = priv->rate >> wfhw->prescaler;
+
+		*wf = (typeof(*wf)){
+			.period_length_ns =
+				DIV_ROUND_UP_ULL((u64)(-wfhw->init << 1)
+				* NSEC_PER_SEC, rate),
+			.duty_length_ns =
+				DIV_ROUND_UP_ULL((u64)(wfhw->val3 - wfhw->init)
+				* NSEC_PER_SEC, rate),
+		};
+	} else {
+		*wf = (typeof(*wf)){
+			.period_length_ns = 0,
+			.duty_length_ns = 0,
+		};
+	}
+
+	dev_dbg(dev, "pwm#%u: INIT: %04x, VAL0: %04x, VAL1: %04x, VAL2: %04x\n",
+		pwm->hwpwm, wfhw->init, wfhw->val0, wfhw->val1, wfhw->val2);
+	dev_dbg(dev, "VAL3 %04x @%lu -> %lld/%lld [+%lld]\n", wfhw->val3, rate,
+		wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns);
+
+	return 0;
+}
+
+static int pwm_mcf_read_waveform(struct pwm_chip *chip, struct pwm_device *pwm,
+				 void *_wfhw)
+{
+	struct pwm_mcf *priv = pwm_mcf_from_chip(chip);
+	struct pwm_mcf_waveform *wfhw = _wfhw;
+	unsigned int val, ch;
+	int ret;
+
+	ch = pwm->hwpwm;
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(priv->map, MCF_PWM_MCR, &val);
+	if (ret)
+		goto read_rw_exit;
+
+	wfhw->enable = FIELD_GET(MCF_PWM_MCR_RUN, val) & BIT(ch);
+
+	if (wfhw->enable) {
+		ret = pwm_mcf_regmap_read(priv->map, ch, MCF_PWM_SM_INIT, &val);
+		if (ret)
+			goto read_rw_exit;
+		wfhw->init = (s16)val;
+		ret = pwm_mcf_regmap_read(priv->map, ch, MCF_PWM_SM_VAL0, &val);
+		if (ret)
+			goto read_rw_exit;
+		wfhw->val0 = (s16)val;
+		ret = pwm_mcf_regmap_read(priv->map, ch, MCF_PWM_SM_VAL1, &val);
+		if (ret)
+			goto read_rw_exit;
+		wfhw->val1 = (s16)val;
+		ret = pwm_mcf_regmap_read(priv->map, ch, MCF_PWM_SM_VAL2, &val);
+		if (ret)
+			goto read_rw_exit;
+		wfhw->val2 = (s16)val;
+		ret = pwm_mcf_regmap_read(priv->map, ch, MCF_PWM_SM_VAL3, &val);
+		if (ret)
+			goto read_rw_exit;
+		wfhw->val3 = (s16)val;
+		ret = pwm_mcf_regmap_read(priv->map, ch, MCF_PWM_SM_CR1, &val);
+		if (ret)
+			goto read_rw_exit;
+		wfhw->prescaler = FIELD_GET(MCF_PWM_SM_CR1_PRSC, val);
+	}
+
+read_rw_exit:
+	clk_disable_unprepare(priv->clk);
+
+	return ret;
+}
+
+static int pwm_mcf_write_waveform(struct pwm_chip *chip, struct pwm_device *pwm,
+				  const void *_wfhw)
+{
+	struct pwm_mcf *priv = pwm_mcf_from_chip(chip);
+	const struct pwm_mcf_waveform *wfhw = _wfhw;
+	unsigned int ch, val;
+	int ret;
+
+	ch = pwm->hwpwm;
+
+	if (!wfhw->enable) {
+		if (pwm->state.enabled)
+			pwm_mcf_disable(chip, pwm);
+
+		return 0;
+	}
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	/* Be sure MCF LDOK is cleared before finally load any value. */
+	ret = pwm_mcf_clear_mcr_ldok(chip, pwm);
+	if (ret)
+		goto out;
+
+	ret = pwm_mcf_regmap_write(priv->map, ch, MCF_PWM_SM_INIT, wfhw->init);
+	if (ret)
+		goto out;
+	ret = pwm_mcf_regmap_write(priv->map, ch, MCF_PWM_SM_VAL0, wfhw->val0);
+	if (ret)
+		goto out;
+	ret = pwm_mcf_regmap_write(priv->map, ch, MCF_PWM_SM_VAL1, wfhw->val1);
+	if (ret)
+		goto out;
+	ret = pwm_mcf_regmap_write(priv->map, ch, MCF_PWM_SM_VAL2, wfhw->val2);
+	if (ret)
+		goto out;
+	ret = pwm_mcf_regmap_write(priv->map, ch, MCF_PWM_SM_VAL3, wfhw->val3);
+	if (ret)
+		goto out;
+
+	/* Force independent mode (using sub-ch A only). */
+	ret = pwm_mcf_regmap_set_bits(priv->map, ch, MCF_PWM_SM_CR2,
+				      MCF_PWM_SM_CR2_IND);
+	if (ret)
+		goto out;
+
+	/* Set reload fixed at full cycle as more accurate mode. */
+	ret = pwm_mcf_regmap_set_bits(priv->map, ch, MCF_PWM_SM_CR1,
+				      MCF_PWM_SM_CR1_FULL);
+	if (ret)
+		goto out;
+
+	val = FIELD_PREP(MCF_PWM_SM_CR1_PRSC, wfhw->prescaler);
+	ret = pwm_mcf_regmap_set_bits(priv->map, ch, MCF_PWM_SM_CR1, val);
+	if (ret)
+		goto out;
+
+	ret = pwm_mcf_enable(chip, pwm);
+
+#ifdef DEBUG
+	pwm_mcf_dump_regs(chip, pwm);
+#endif
+	return ret;
+
+out:
+	clk_disable_unprepare(priv->clk);
+
+	return ret;
+}
+
+static int pwm_mcf_init(struct pwm_chip *chip)
+{
+	struct device *dev = pwmchip_parent(chip);
+	struct pwm_mcf *priv = pwm_mcf_from_chip(chip);
+	int i, ret;
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	/*
+	 * To fast-up operations, calculating here all the values that cannot
+	 * change after hw power on.
+	 */
+	ret = clk_rate_exclusive_get(priv->clk);
+	if (ret)
+		goto exit_init;
+
+	priv->rate = clk_get_rate(priv->clk);
+	if (priv->rate == 0) {
+		ret = -EINVAL;
+		goto exit_init;
+	}
+
+	/*
+	 * Calculating fixed minimum/maximum nanosecs period possible,
+	 * considering the possible maximum prescaler value as 7 (fclk/128).
+	 */
+	priv->period_ns_min = div_u64(NSEC_PER_SEC, priv->rate) + 1;
+	priv->period_ns_max = mul_u64_u32_div(65535ULL, NSEC_PER_SEC,
+					      (priv->rate >> 7));
+
+	dev_dbg(dev, "%s() period limits: min %llu, max %llu\n",
+		__func__, priv->period_ns_min, priv->period_ns_max);
+
+	/*
+	 * Set independent mode for all submodules:
+	 * default is "complementary", and on apply only PWM "A" is used,
+	 * so in complementary mode, for safety reason (motor control with
+	 * a wrong complementary drive) the PWM is not started at all on RUN.
+	 */
+	for (i = 0, ret = 0; i < MCF_PWM_SUBMODS && ret == 0; i++) {
+		ret = pwm_mcf_regmap_set_bits(priv->map, i, MCF_PWM_SM_CR2,
+					      MCF_PWM_SM_CR2_IND);
+	}
+
+exit_init:
+	clk_disable_unprepare(priv->clk);
+
+	return ret;
+}
+
+static const struct pwm_ops pwm_mcf_ops = {
+	.sizeof_wfhw = sizeof(struct pwm_mcf_waveform),
+	.round_waveform_tohw = pwm_mcf_round_waveform_tohw,
+	.round_waveform_fromhw = pwm_mcf_round_waveform_fromhw,
+	.read_waveform = pwm_mcf_read_waveform,
+	.write_waveform = pwm_mcf_write_waveform,
+};
+
+static int pwm_mcf_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
+	struct pwm_mcf *priv;
+	void __iomem *regs;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, MCF_PWM_SUBMODS, sizeof(*priv));
+	if (IS_ERR(chip))
+		return dev_err_probe(dev, PTR_ERR(chip),
+				     "Failed to allocate priv memory.\n");
+
+	priv = pwm_mcf_from_chip(chip);
+
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs))
+		return dev_err_probe(dev, PTR_ERR(regs),
+				     "Failed to get io regs\n");
+
+	priv->map = devm_regmap_init_mmio(dev, regs, &pwm_mcf_regmap_config);
+	if (IS_ERR(priv->map))
+		return dev_err_probe(dev, PTR_ERR(priv->map),
+				     "Failed mmio regmap init\n");
+
+	priv->clk = devm_clk_get(dev, "mcfpwm");
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "Failed getting clock\n");
+
+	chip->ops = &pwm_mcf_ops;
+
+	ret = pwm_mcf_init(chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize PWM\n");
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to register pwmchip\n");
+
+	return 0;
+}
+
+static const struct platform_device_id pwm_mcf_ids[] = {
+	{ .name = "mcfpwm" },
+	{ }
+};
+
+static struct platform_driver pwm_mcf_driver = {
+	.driver = {
+		.name = "pwm-mcf",
+	},
+	.probe = pwm_mcf_probe,
+	.id_table = pwm_mcf_ids,
+};
+module_platform_driver(pwm_mcf_driver);
+
+MODULE_DESCRIPTION("mcf54415 Motor Control Pulse Width Modulation driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Angelo Dureghello <adureghello@baylibre.com>");

-- 
2.55.0


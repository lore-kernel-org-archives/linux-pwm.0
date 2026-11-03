Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695239;
	b=5SNzUFYvArUBSL6yXL69IdL5/g/nPKxmOSl2mw5t0wSMx5loWgWnk/ECT0oIiGfEGYuU
	 L0+sfuibkX0N6Fke5H4c2fpyaMEtIB/GLEEnbrEuwjm/Um1IfPscnaZ/uDGfq8N378Vxw
	 tM+RDrKH/Gha843xiBKGGtVoCyAblnjJrEelMiPd0oeCwHLLfyPA32+ATeFIbLT5gNi/H
	 IPRc53VkDC9H61L8Xc5A5Ce0O5Ap7b05Hmu69nVqOLGq0YI5ZGv0bbkx465ITm3Z7YLqP
	 TApTZoq7cUVfK3z5LCfbX7mVe2Enq9euIQsUZ0ot9s3fv1KQEl/0T8z0K3HpDVDU9qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=wVUrGHWUazMkQfkNxvRuSlykd4L0BZwuc90KbAxywBg=;
	b=cOZUFFW06JwC8FC2PT+h8FJhfNWItzGjI1Gwq6L/Vf6Tkbnu+uVBSYaEsfqvdPC4L/IJ
	 Fs1yGD0DFQOsuAwQiKnLXeWdlATxqMwTiZ332LBcgT03y8Jvxx/TWSESVNdDljUgYyCKB
	 +GZniv2hn5inmFBNCyWohO2UzjJuPJoiNOUuAvLwh1pc43I1AcQewe+tZeQgL2r31INH4
	 WJOPCTts7+X9CzUq9SQu5sYxEKfPbyWnFI4+is3UTkhiWbixmSZ6JdOl2oQ7gszRGx8M8
	 IhexTWRabBoFanQ/YS/F7mhr+1cfe/NF655F9pJuVYwJ+thxgQ1pDwY0CW4iPEo9QDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="n/hHxUZB";
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826FA606B6DD
	for <linux-pwm@vger.kernel.org>; Tue,  3 Nov 2026 08:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 826FA606B6DD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n/hHxUZB
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-70b875f6f13so3635449eaf.0
        for <linux-pwm@vger.kernel.org>; Tue, 03 Nov 2026 00:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793695237; x=1794300037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wVUrGHWUazMkQfkNxvRuSlykd4L0BZwuc90KbAxywBg=;
        b=n/hHxUZB/bDxgQvzgvIrwmD7Onv40fsqUDx7JjMJCKPPkqV/DFrecnAOCDisY7K1I6
         bMWR9JnyB7yxkl3DS+dYBPeOdD1JDyiMXQq0ABDUyPQTxIit3P7zFKYSgN0Im5YtCwS3
         fF2tuWViJRVfIV5xXiKGG5LDCsY0RiDaeXa5rFpMejKuist/fQLY9e6w5bpOnTRep/G3
         KhgX2Q2STgdBN3TnDl6/x3amIREiiFYJnM3JAi8hN+MMuhmAlSoDWFvbBr2sZRUXwII2
         AD7AyZhsdBW/lvaw6iGiOBBVW+SUxqMFLjjxj4Ut+SIjTgs2X7frEajKd3a1QLcKSfvz
         gWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695237; x=1794300037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wVUrGHWUazMkQfkNxvRuSlykd4L0BZwuc90KbAxywBg=;
        b=qDf0unWW5bsrHSaxOd8aEjQYH7B8RK3uNLa99aFjQwNDCvojq8ZP78DU8J0gN+G6Bf
         qVWBkrTXILz0luqbTjj+cCHHDlb1z/D2Iqon+TCMEK3TGxQBATY/y5uWN6bsjFoaIfod
         3wudSdvvE0j1iMvk3ayzZ5z1SxB4cY+X5wlJ2kVi1IV1OE7uRxv/QuzO9VnLcQ39uRFB
         4QgaJwXDPh6GUH7T7JUJyLHn960JPxI6AC2eOUBaU+60whl+l/Y09dFHyTFkGNgHeWBx
         nTmUnPGuzyqfys2gDMphWXX3M5idW0Ad9wrH7dF3SOvYk+OcOjaziJs6bNlv4YRp4oSe
         xUAA==
X-Forwarded-Encrypted: i=1; AKwUvByonTmRTEar8m1wXqaoKJsGQ5S1EZCACXYOkrvBpvK/K8AVaNCw5ntF114KtL5HrWE3bLT9zfKhiMg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9erGGo6XyPpX1DBscUZCt8BT0UjdCueZ1lryAlun75M2M3t2Uu
	nM90+EybX47jAW6B2JLw1snwvY3qKu00oMosnbKDoRTYmv/ZE6Aq72Af
X-Gm-Gg: AYBFou0Udm8g74NGNYxp0xWG3lQBkvd8kUHiL5xdONwA5Dbu432Epe0M5YBbb6fw3tK
	V5jHAAztmHgBuJRaw4xDaRglPftygOUbY1n+ow8qT51dDnEW0T8bSsBzZJjQhKqDbz+I0ci4OSO
	/XY8UC5ps6UhcgmH/4MYH+09ForIpmk5ZtZqJjw2W0ltoAQ9lMfxNwFKj4GDZn12v1jzhjcwdhO
	ZmbwW0xXLcU2bwt8Cmm83VnQ8uW2zQCSGvKZME2E+FuObl7uijgBwEMKMFfccH54/INUd2iXAOx
	MQXGmKkPfs0vfvB/Vl0r/JwJbPrT4uOFlu4mSYmdE6O4MKF/FOH+jUxQFmYxKyKgjJJHAoUIhix
	6RLCI2Pd4Onaz5OQ4UAdeTMFmnKdk7qMMK4zGz9j/SJSl2uT++qpQJZDf6uXodGqaQQQeEVkmpn
	/fqzLHt4nPxahL6BTbO9QZtc5PE66VCvz7ZK08+aR136RvInBbLWPqZqmoe27jeSIcKIM+Esi54
	yJ/mIhX/HR7Yn4eIeOlveCuh+iu7z0JCy8tPpoSCYi2Cx9Vu2j0cFLKzGqTnUUMZkERB5Sp3fo6
	+dj/JP0LdDfuNOfZmzfO6LQKMr14S7PZ5rKFgX5K+OzdttOIqZHDsA5a5DpMaNzwmHhS8GQZ+hl
	XKDcoRP7m6wgZ02Vicp5FHb9JEWJoMXQx30u5PGSNaeJhLbwk/ySZMYJQfbj5l4xhsvragqZHnV
	51CTNaY3lyULU4dK2XFDrbMeGo1UYIx71o6kcwRwxTeUzZi5slxBG/
X-Received: by 2002:a05:6820:80a:b0:70b:f166:ee63 with SMTP id 006d021491bc7-714f23fb95bmr6655421eaf.25.1793695237218;
        Tue, 03 Nov 2026 00:40:37 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f3081097sm10520397eaf.13.2026.11.03.00.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:40:36 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 01:40:27 -0700
Subject: [PATCH v11 2/5] pwm: sun8i: Add H616 PWM support
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-h616-pwm-v8-v11-2-07abb59575c3@gmail.com>
References: <20261103-h616-pwm-v8-v11-0-07abb59575c3@gmail.com>
In-Reply-To: <20261103-h616-pwm-v8-v11-0-07abb59575c3@gmail.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Paul Kocialkowski <paulk@sys-base.io>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 John Stultz <jstultz@google.com>, Joao Schim <joao@schimsalabim.eu>, 
 bigunclemax@gmail.com, linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

From: Richard Genoud <richard.genoud@bootlin.com>

Add waveform support for the six-channel Allwinner H616 PWM controller.
Each pair of outputs shares a source mux, gate and power-of-two divider;
each channel has its own prescaler and period/duty registers. Model the
shared pair clocks in CCF and program the channel-local dividers directly.

Protect the pair rate while a PWM is active. Also check the hardware enable
bits before retuning or gating a pair, since firmware may have left an
output running without a Linux consumer. Preserve such outputs until a
consumer explicitly changes them; do not implement an unused-PWM sweep.

Round period, duty and offset in the order required by the waveform API,
including the hardware bypass path and the 65536-tick period boundary.
Compare exact tick-to-rate ratios before converting to nanoseconds, so
periods that round to the same nanosecond remain correctly ordered. Use
half-cycle units to include the bypass output in that comparison.
Wait for pending period updates and quiesce the channel when changing its
clock, prescaler, polarity or bypass mode. Live period updates additionally
require PCLK to be faster than the PWM clock, as specified by the manual.

Encode the channel register values during waveform conversion. Keep rate
protection, safe quiescing and clock rollback in one preparation helper,
leaving the write callback to apply the prepared values. Select candidates
using one ordered comparison while retaining the bounded divider search.

Pulse and coupled dead-zone modes cannot be represented by this API. Reject
active unsupported modes, but clear dormant dead-zone configuration before
programming an ordinary waveform.

Allocate the fixed six-channel topology with the pwm_chip. Register the
per-device clocks with managed helpers after deasserting reset.

Acquire separate pair-clock consumer handles only while PWMs are requested,
so internal clock references cannot prevent module removal. Use CCF's
provider-owned handles for notifiers and rate readback, including readback
of channels which have not been requested.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
Co-developed-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/pwm/Kconfig     |   11 +
 drivers/pwm/Makefile    |    1 +
 drivers/pwm/pwm-sun8i.c | 1129 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1141 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 729776086879..d87d166e7836 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -748,6 +748,17 @@ config PWM_SUN4I
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sun4i.
 
+config PWM_SUN8I
+	tristate "Allwinner sun8i/sun50i PWM support"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on HAS_IOMEM && COMMON_CLK
+	help
+	  PWM framework driver for Allwinner controllers whose channels share
+	  paired source clocks.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-sun8i.
+
 config PWM_SUNPLUS
 	tristate "Sunplus PWM support"
 	depends on ARCH_SUNPLUS || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 5630a521a7cf..9c922b1fd0b4 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
 obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
 obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
 obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
+obj-$(CONFIG_PWM_SUN8I)		+= pwm-sun8i.o
 obj-$(CONFIG_PWM_SUNPLUS)	+= pwm-sunplus.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
 obj-$(CONFIG_PWM_TH1520)	+= pwm_th1520.o
diff --git a/drivers/pwm/pwm-sun8i.c b/drivers/pwm/pwm-sun8i.c
new file mode 100644
index 000000000000..bcc2c5744378
--- /dev/null
+++ b/drivers/pwm/pwm-sun8i.c
@@ -0,0 +1,1129 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for Allwinner sun8i Pulse Width Modulation Controller
+ *
+ * (C) Copyright 2025 Richard Genoud, Bootlin <richard.genoud@bootlin.com>
+ * (C) Copyright 2026 James Hilliard <james.hilliard1@gmail.com>
+ *
+ * Based on drivers/pwm/pwm-sun4i.c with Copyright:
+ *
+ * Copyright (C) 2014 Alexandre Belloni <alexandre.belloni@bootlin.com>
+ *
+ * Channels are paired (0/1, 2/3, 4/5). Each pair shares a clock source and
+ * first prescaler (div_m), while each channel has its own second prescaler
+ * (div_k) and bypass path.
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/limits.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/time.h>
+
+#define SUN8I_PWM_NPWM			6
+#define SUN8I_PWM_NPAIRS			(SUN8I_PWM_NPWM / 2)
+
+/* PWMCC Pairs Clock Configuration Registers */
+#define SUN8I_PWM_PCCR(pair)		(0x20 + ((pair) * 0x4))
+#define SUN8I_PWM_PCCR_SRC_SHIFT	7
+#define SUN8I_PWM_PCCR_SRC_MASK		GENMASK(1, 0)
+#define SUN8I_PWM_PCCR_GATE_BIT		4
+#define SUN8I_PWM_PCCR_GATE		BIT(SUN8I_PWM_PCCR_GATE_BIT)
+#define SUN8I_PWM_PCCR_BYPASS_BIT(chan)	((chan) % 2 + 5)
+#define SUN8I_PWM_PCCR_DIV_M_SHIFT	0
+#define SUN8I_PWM_PCCR_DIV_M_WIDTH	4
+
+/* PWM Enable Register */
+#define SUN8I_PWM_PER			0x40
+#define SUN8I_PWM_ENABLE(chan)		BIT(chan)
+
+/* PWM Control Register */
+#define SUN8I_PWM_PCR(chan)		(0x60 + (chan) * 0x20)
+#define SUN8I_PWM_PCR_PRESCAL_K_MASK	GENMASK(7, 0)
+#define SUN8I_PWM_PCR_ACTIVE_STATE	BIT(8)
+#define SUN8I_PWM_PCR_MODE		BIT(9)
+#define SUN8I_PWM_PCR_PULSE_START	BIT(10)
+#define SUN8I_PWM_PCR_PERIOD_READY	BIT(11) /* 0: ready, 1: busy */
+#define SUN8I_PWM_PCR_WAVEFORM_MASK	(SUN8I_PWM_PCR_PRESCAL_K_MASK | \
+					 SUN8I_PWM_PCR_ACTIVE_STATE)
+
+/* PWM Period Register */
+#define SUN8I_PWM_PPR(chan)		(0x64 + (chan) * 0x20)
+#define SUN8I_PWM_PPR_PERIOD_MASK	GENMASK(31, 16)
+#define SUN8I_PWM_PPR_DUTY_MASK		GENMASK(15, 0)
+#define SUN8I_PWM_PPR_PERIOD_VALUE(reg)	(FIELD_GET(SUN8I_PWM_PPR_PERIOD_MASK, reg) + 1)
+#define SUN8I_PWM_PPR_DUTY_VALUE(reg)	FIELD_GET(SUN8I_PWM_PPR_DUTY_MASK, reg)
+#define SUN8I_PWM_PPR_PERIOD(prd)	FIELD_PREP(SUN8I_PWM_PPR_PERIOD_MASK, (prd) - 1)
+#define SUN8I_PWM_PPR_DUTY(dty)		FIELD_PREP(SUN8I_PWM_PPR_DUTY_MASK, dty)
+#define SUN8I_PWM_PPR_PERIOD_MAX	(FIELD_MAX(SUN8I_PWM_PPR_PERIOD_MASK) + 1)
+
+/* PWM pair dead-zone control registers. */
+#define SUN8I_PWM_PDZCR(pair)		(0x30 + ((pair) * 0x4))
+#define SUN8I_PWM_PDZCR_ENABLE		BIT(0)
+
+#define SUN8I_PWM_PERIOD_READY_MARGIN_US	50
+#define SUN8I_PWM_PERIOD_READY_MIN_POLL_US	10
+#define SUN8I_PWM_PERIOD_READY_MAX_POLL_US	10000
+#define SUN8I_PWM_PERIOD_READY_POLL_COUNT	1024
+
+#define SUN8I_PWM_PAIR_IDX(chan)	((chan) >> 1)
+
+/*
+ * Block diagram of the PWM clock controller:
+ *
+ *             _____      ______      ________
+ * OSC24M --->|     |    |      |    |        |
+ * APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> SUN8I_PWM_clock_src_xy
+ *            |_____|    |______|    |________|
+ *                               ________
+ *                              |        |
+ *                           +->| /div_k |---> SUN8I_PWM_clock_x
+ *                           |  |________|
+ *                           |    ______
+ *                           |   |      |
+ *                           +-->| Gate |----> SUN8I_PWM_bypass_clock_x
+ *                           |   |______|
+ * SUN8I_PWM_clock_src_xy ---+   ________
+ *                           |  |        |
+ *                           +->| /div_k |---> SUN8I_PWM_clock_y
+ *                           |  |________|
+ *                           |    ______
+ *                           |   |      |
+ *                           +-->| Gate |----> SUN8I_PWM_bypass_clock_y
+ *                               |______|
+ *
+ * NB: when the bypass is set, all the PWM logic is bypassed.
+ * So, the duty cycle and polarity can't be modified (we just have a clock).
+ * The bypass in PWM mode is used to achieve a 1/2 relative duty cycle with the
+ * fastest clock.
+ *
+ */
+
+/* /div_m is a power-of-two divider limited to /256. */
+static const struct clk_div_table sun8i_pwm_div_m_table[] = {
+	{ .val = 0, .div = 1 },
+	{ .val = 1, .div = 2 },
+	{ .val = 2, .div = 4 },
+	{ .val = 3, .div = 8 },
+	{ .val = 4, .div = 16 },
+	{ .val = 5, .div = 32 },
+	{ .val = 6, .div = 64 },
+	{ .val = 7, .div = 128 },
+	{ .val = 8, .div = 256 },
+	{ /* sentinel */ }
+};
+
+struct sun8i_pwm_chip;
+
+struct sun8i_pwm_pair {
+	struct clk_mux mux;
+	struct clk_hw gate_hw;
+	struct clk_divider divider;
+	struct clk_hw *hw;
+	struct notifier_block rate_nb;
+	struct sun8i_pwm_chip *chip;
+	unsigned int index;
+};
+
+struct sun8i_pwm_channel {
+	/* Separate CCF consumer, held only from PWM request to free. */
+	struct clk *pair_clk;
+	u64 pending_period_ns;
+	bool rate_exclusive;
+};
+
+struct sun8i_pwm_chip {
+	struct sun8i_pwm_pair pairs[SUN8I_PWM_NPAIRS];
+	struct sun8i_pwm_channel channels[SUN8I_PWM_NPWM];
+	struct clk *bus_clk;
+	void __iomem *base;
+	/* Protects shared registers and rate_exclusive. */
+	spinlock_t lock;
+};
+
+struct sun8i_pwm_waveform {
+	u32 pcr;
+	u32 ppr;
+	u32 pair_rate;
+	bool enabled;
+	bool bypass_en;
+};
+
+static inline struct sun8i_pwm_chip *sun8i_pwm_from_chip(const struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static unsigned long sun8i_pwm_get_pair_rate(struct sun8i_pwm_chip *sun8i_chip,
+					     unsigned int idx)
+{
+	struct sun8i_pwm_pair *pair = &sun8i_chip->pairs[SUN8I_PWM_PAIR_IDX(idx)];
+
+	/* Readback also runs on channels without a PWM request. */
+	return clk_get_rate(pair->hw->clk);
+}
+
+static inline u32 sun8i_pwm_readl(struct sun8i_pwm_chip *sun8i_chip,
+				  unsigned long offset)
+{
+	return readl(sun8i_chip->base + offset);
+}
+
+static inline void sun8i_pwm_writel(struct sun8i_pwm_chip *sun8i_chip,
+				    u32 val, unsigned long offset)
+{
+	writel(val, sun8i_chip->base + offset);
+}
+
+static void sun8i_pwm_set_bypass_locked(struct sun8i_pwm_chip *sun8i_chip,
+					unsigned int idx, bool enable)
+{
+	unsigned long reg_offset;
+	u32 val;
+
+	lockdep_assert_held(&sun8i_chip->lock);
+
+	reg_offset = SUN8I_PWM_PCCR(SUN8I_PWM_PAIR_IDX(idx));
+	val = sun8i_pwm_readl(sun8i_chip, reg_offset);
+	if (enable)
+		val |= BIT(SUN8I_PWM_PCCR_BYPASS_BIT(idx));
+	else
+		val &= ~BIT(SUN8I_PWM_PCCR_BYPASS_BIT(idx));
+
+	sun8i_pwm_writel(sun8i_chip, val, reg_offset);
+}
+
+static void sun8i_pwm_set_enabled_locked(struct sun8i_pwm_chip *sun8i_chip,
+					 unsigned int idx, bool enable)
+{
+	u32 val;
+
+	lockdep_assert_held(&sun8i_chip->lock);
+
+	val = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
+	if (enable)
+		val |= SUN8I_PWM_ENABLE(idx);
+	else
+		val &= ~SUN8I_PWM_ENABLE(idx);
+	sun8i_pwm_writel(sun8i_chip, val, SUN8I_PWM_PER);
+}
+
+static bool
+sun8i_pwm_channel_is_enabled_locked(struct sun8i_pwm_chip *sun8i_chip,
+				    unsigned int idx)
+{
+	unsigned int pair = SUN8I_PWM_PAIR_IDX(idx);
+	u32 pccr, per;
+
+	lockdep_assert_held(&sun8i_chip->lock);
+
+	pccr = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair));
+	per = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
+
+	return (pccr & SUN8I_PWM_PCCR_GATE) &&
+	       (per & SUN8I_PWM_ENABLE(idx));
+}
+
+static u32 sun8i_pwm_pair_enable_mask(unsigned int pair)
+{
+	return GENMASK(pair * 2 + 1, pair * 2);
+}
+
+static inline struct sun8i_pwm_pair *
+sun8i_pwm_pair_from_gate_hw(struct clk_hw *hw)
+{
+	return container_of(hw, struct sun8i_pwm_pair, gate_hw);
+}
+
+static int sun8i_pwm_pair_gate_enable(struct clk_hw *hw)
+{
+	struct sun8i_pwm_pair *pair = sun8i_pwm_pair_from_gate_hw(hw);
+	struct sun8i_pwm_chip *sun8i_chip = pair->chip;
+	u32 pccr;
+
+	guard(spinlock_irqsave)(&sun8i_chip->lock);
+	pccr = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair->index));
+	pccr |= SUN8I_PWM_PCCR_GATE;
+	sun8i_pwm_writel(sun8i_chip, pccr, SUN8I_PWM_PCCR(pair->index));
+
+	return 0;
+}
+
+static void sun8i_pwm_pair_gate_disable(struct clk_hw *hw)
+{
+	struct sun8i_pwm_pair *pair = sun8i_pwm_pair_from_gate_hw(hw);
+	struct sun8i_pwm_chip *sun8i_chip = pair->chip;
+	unsigned long reg = SUN8I_PWM_PCCR(pair->index);
+	u32 pccr, per;
+
+	/* CCF counts do not include outputs awaiting firmware-state handoff. */
+	guard(spinlock_irqsave)(&sun8i_chip->lock);
+	per = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
+	if (!(per & sun8i_pwm_pair_enable_mask(pair->index))) {
+		pccr = sun8i_pwm_readl(sun8i_chip, reg);
+		pccr &= ~SUN8I_PWM_PCCR_GATE;
+		sun8i_pwm_writel(sun8i_chip, pccr, reg);
+	}
+}
+
+static int sun8i_pwm_pair_gate_is_enabled(struct clk_hw *hw)
+{
+	struct sun8i_pwm_pair *pair = sun8i_pwm_pair_from_gate_hw(hw);
+	struct sun8i_pwm_chip *sun8i_chip = pair->chip;
+	unsigned long reg = SUN8I_PWM_PCCR(pair->index);
+
+	guard(spinlock_irqsave)(&sun8i_chip->lock);
+
+	return !!(sun8i_pwm_readl(sun8i_chip, reg) & SUN8I_PWM_PCCR_GATE);
+}
+
+static const struct clk_ops sun8i_pwm_pair_gate_ops = {
+	.enable = sun8i_pwm_pair_gate_enable,
+	.disable = sun8i_pwm_pair_gate_disable,
+	.is_enabled = sun8i_pwm_pair_gate_is_enabled,
+};
+
+static int sun8i_pwm_pair_rate_notifier(struct notifier_block *nb,
+					unsigned long event, void *data)
+{
+	struct sun8i_pwm_pair *pair =
+		container_of(nb, struct sun8i_pwm_pair, rate_nb);
+	struct sun8i_pwm_chip *sun8i_chip = pair->chip;
+	bool active;
+
+	if (event != PRE_RATE_CHANGE)
+		return NOTIFY_DONE;
+
+	guard(spinlock_irqsave)(&sun8i_chip->lock);
+	active = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER) &
+		 sun8i_pwm_pair_enable_mask(pair->index);
+
+	return active ? NOTIFY_BAD : NOTIFY_OK;
+}
+
+static void sun8i_pwm_put_rate(struct sun8i_pwm_chip *sun8i_chip,
+			       unsigned int idx)
+{
+	struct sun8i_pwm_channel *chan = &sun8i_chip->channels[idx];
+	bool exclusive;
+
+	scoped_guard(spinlock_irqsave, &sun8i_chip->lock) {
+		exclusive = chan->rate_exclusive;
+		chan->rate_exclusive = false;
+	}
+	/* CCF takes the prepare mutex and may call back into this driver. */
+	if (exclusive)
+		clk_rate_exclusive_put(chan->pair_clk);
+}
+
+static int sun8i_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct sun8i_pwm_chip *sun8i_chip = sun8i_pwm_from_chip(chip);
+	struct sun8i_pwm_channel *chan = &sun8i_chip->channels[pwm->hwpwm];
+	unsigned int idx = pwm->hwpwm;
+	struct clk_hw *parent = sun8i_chip->pairs[SUN8I_PWM_PAIR_IDX(idx)].hw;
+	bool was_enabled;
+	int ret;
+
+	scoped_guard(spinlock_irqsave, &sun8i_chip->lock) {
+		was_enabled =
+			sun8i_pwm_channel_is_enabled_locked(sun8i_chip, idx);
+	}
+
+	chan->pair_clk = clk_hw_get_clk(parent, NULL);
+	if (IS_ERR(chan->pair_clk)) {
+		ret = PTR_ERR(chan->pair_clk);
+		goto err_clear_clock;
+	}
+
+	if (was_enabled) {
+		ret = clk_rate_exclusive_get(chan->pair_clk);
+		if (ret)
+			goto err_put_clock;
+		scoped_guard(spinlock_irqsave, &sun8i_chip->lock)
+			chan->rate_exclusive = true;
+	}
+
+	ret = clk_prepare_enable(chan->pair_clk);
+	if (ret) {
+		sun8i_pwm_put_rate(sun8i_chip, idx);
+		goto err_put_clock;
+	}
+
+	return 0;
+
+err_put_clock:
+	clk_put(chan->pair_clk);
+err_clear_clock:
+	chan->pair_clk = NULL;
+
+	return ret;
+}
+
+static void sun8i_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct sun8i_pwm_chip *sun8i_chip = sun8i_pwm_from_chip(chip);
+	struct sun8i_pwm_channel *chan = &sun8i_chip->channels[pwm->hwpwm];
+
+	scoped_guard(spinlock_irqsave, &sun8i_chip->lock) {
+		sun8i_pwm_set_enabled_locked(sun8i_chip, pwm->hwpwm, false);
+		sun8i_pwm_set_bypass_locked(sun8i_chip, pwm->hwpwm, false);
+	}
+
+	sun8i_pwm_put_rate(sun8i_chip, pwm->hwpwm);
+	clk_disable_unprepare(chan->pair_clk);
+	clk_put(chan->pair_clk);
+	chan->pair_clk = NULL;
+}
+
+static int sun8i_pwm_read_waveform(struct pwm_chip *chip,
+				   struct pwm_device *pwm,
+				   void *_wfhw)
+{
+	struct sun8i_pwm_waveform *wfhw = _wfhw;
+	struct sun8i_pwm_chip *sun8i_chip = sun8i_pwm_from_chip(chip);
+	unsigned int pair = SUN8I_PWM_PAIR_IDX(pwm->hwpwm);
+	unsigned long pair_rate;
+	u32 pccr, pcr, pdzcr, per, ppr;
+
+	pair_rate = sun8i_pwm_get_pair_rate(sun8i_chip, pwm->hwpwm);
+	if (pair_rate > U32_MAX)
+		return -ERANGE;
+
+	scoped_guard(spinlock_irqsave, &sun8i_chip->lock) {
+		pccr = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair));
+		per = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
+		pcr = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCR(pwm->hwpwm));
+		ppr = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PPR(pwm->hwpwm));
+		pdzcr = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PDZCR(pair));
+	}
+
+	*wfhw = (struct sun8i_pwm_waveform) {
+		.enabled = !!(pccr & SUN8I_PWM_PCCR_GATE) &&
+			   !!(per & SUN8I_PWM_ENABLE(pwm->hwpwm)),
+		.bypass_en = !!(pccr &
+				 BIT(SUN8I_PWM_PCCR_BYPASS_BIT(pwm->hwpwm))),
+		.pcr = pcr & SUN8I_PWM_PCR_WAVEFORM_MASK,
+		.ppr = ppr,
+		.pair_rate = pair_rate,
+	};
+
+	/* The waveform API cannot describe coupled dead-zone or pulse mode. */
+	if (wfhw->enabled && !wfhw->bypass_en &&
+	    ((pdzcr & SUN8I_PWM_PDZCR_ENABLE) || (pcr & SUN8I_PWM_PCR_MODE)))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static u64 sun8i_pwm_ticks_to_ns(u32 ticks, u16 div_k, u32 pair_rate)
+{
+	return DIV_ROUND_UP_ULL(NSEC_PER_SEC * (u64)ticks * div_k,
+				pair_rate);
+}
+
+static u64 sun8i_pwm_period_ns(const struct sun8i_pwm_waveform *wfhw)
+{
+	if (wfhw->bypass_en)
+		return DIV_ROUND_UP_ULL(NSEC_PER_SEC, wfhw->pair_rate);
+
+	return sun8i_pwm_ticks_to_ns(SUN8I_PWM_PPR_PERIOD_VALUE(wfhw->ppr),
+		FIELD_GET(SUN8I_PWM_PCR_PRESCAL_K_MASK, wfhw->pcr) + 1,
+		wfhw->pair_rate);
+}
+
+static void
+__sun8i_pwm_round_waveform_fromhw(const struct sun8i_pwm_waveform *wfhw,
+				  struct pwm_waveform *wf)
+{
+	u32 pair_rate = wfhw->pair_rate;
+	u32 period_ticks = SUN8I_PWM_PPR_PERIOD_VALUE(wfhw->ppr);
+	u32 duty_ticks = SUN8I_PWM_PPR_DUTY_VALUE(wfhw->ppr);
+	u16 div_k = FIELD_GET(SUN8I_PWM_PCR_PRESCAL_K_MASK, wfhw->pcr) + 1;
+
+	wf->duty_offset_ns = 0;
+
+	if (!wfhw->enabled || !pair_rate) {
+		wf->period_length_ns = 0;
+		wf->duty_length_ns = 0;
+		return;
+	}
+
+	wf->period_length_ns = sun8i_pwm_period_ns(wfhw);
+	if (wfhw->bypass_en) {
+		wf->duty_length_ns =
+			DIV_ROUND_UP_ULL(NSEC_PER_SEC,
+					 2ULL * pair_rate);
+		return;
+	}
+
+	duty_ticks = min(duty_ticks, period_ticks);
+	if (!(wfhw->pcr & SUN8I_PWM_PCR_ACTIVE_STATE)) {
+		/* Constant outputs have no edge and therefore no offset. */
+		if (duty_ticks && duty_ticks < period_ticks)
+			wf->duty_offset_ns =
+				sun8i_pwm_ticks_to_ns(duty_ticks, div_k, pair_rate);
+		duty_ticks = period_ticks - duty_ticks;
+	}
+	wf->duty_length_ns = sun8i_pwm_ticks_to_ns(duty_ticks, div_k, pair_rate);
+}
+
+static int sun8i_pwm_round_waveform_fromhw(struct pwm_chip *chip,
+					   struct pwm_device *pwm,
+					   const void *_wfhw,
+					   struct pwm_waveform *wf)
+{
+	const struct sun8i_pwm_waveform *wfhw = _wfhw;
+
+	__sun8i_pwm_round_waveform_fromhw(wfhw, wf);
+
+	dev_dbg(pwmchip_parent(chip),
+		"pwm#%u: pair-rate=%u, pcr=%#x, ppr=%#x, bypass=%u -> %llu/%llu [+%llu]\n",
+		pwm->hwpwm, wfhw->pair_rate, wfhw->pcr, wfhw->ppr,
+		wfhw->bypass_en,
+		wf->duty_length_ns, wf->period_length_ns,
+		wf->duty_offset_ns);
+
+	return 0;
+}
+
+static bool
+sun8i_pwm_pair_rate_constrained(struct sun8i_pwm_chip *sun8i_chip,
+				unsigned int idx)
+{
+	unsigned int sibling = idx ^ 1;
+
+	guard(spinlock_irqsave)(&sun8i_chip->lock);
+	return sun8i_chip->channels[sibling].rate_exclusive ||
+	       sun8i_pwm_channel_is_enabled_locked(sun8i_chip, sibling);
+}
+
+static int sun8i_pwm_clear_idle_deadzone(struct sun8i_pwm_chip *sun8i_chip,
+					 unsigned int idx)
+{
+	unsigned int pair = SUN8I_PWM_PAIR_IDX(idx);
+	u32 pdzcr, per;
+
+	guard(spinlock_irqsave)(&sun8i_chip->lock);
+	pdzcr = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PDZCR(pair));
+	if (!(pdzcr & SUN8I_PWM_PDZCR_ENABLE))
+		return 0;
+
+	per = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
+	if (per & sun8i_pwm_pair_enable_mask(pair))
+		return -EOPNOTSUPP;
+
+	pdzcr &= ~SUN8I_PWM_PDZCR_ENABLE;
+	sun8i_pwm_writel(sun8i_chip, pdzcr, SUN8I_PWM_PDZCR(pair));
+
+	return 0;
+}
+
+static u64 sun8i_pwm_max_period_ns(struct sun8i_pwm_chip *sun8i_chip,
+				   unsigned int idx)
+{
+	unsigned long pair_rate;
+	u32 pcr;
+	u16 div_k;
+
+	pair_rate = sun8i_pwm_get_pair_rate(sun8i_chip, idx);
+	if (!pair_rate || pair_rate > U32_MAX)
+		return 0;
+
+	scoped_guard(spinlock_irqsave, &sun8i_chip->lock) {
+		pcr = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCR(idx));
+	}
+	div_k = FIELD_GET(SUN8I_PWM_PCR_PRESCAL_K_MASK, pcr) + 1;
+
+	return sun8i_pwm_ticks_to_ns(SUN8I_PWM_PPR_PERIOD_MAX, div_k,
+				     pair_rate);
+}
+
+static int sun8i_pwm_wait_period_ready(struct pwm_chip *chip, unsigned int idx)
+{
+	struct sun8i_pwm_chip *sun8i_chip = sun8i_pwm_from_chip(chip);
+	struct sun8i_pwm_channel *chan = &sun8i_chip->channels[idx];
+	unsigned long poll_us;
+	u64 period_ns, timeout_us;
+	u32 val;
+	int ret;
+
+	/* PPR contains the pending value, not necessarily the active period. */
+	period_ns = chan->pending_period_ns;
+	if (!period_ns)
+		period_ns = sun8i_pwm_max_period_ns(sun8i_chip, idx);
+	timeout_us = DIV_ROUND_UP_ULL(period_ns, NSEC_PER_USEC) +
+		     SUN8I_PWM_PERIOD_READY_MARGIN_US;
+	poll_us = clamp_t(u64,
+			  DIV_ROUND_UP_ULL(timeout_us,
+					   SUN8I_PWM_PERIOD_READY_POLL_COUNT),
+			  SUN8I_PWM_PERIOD_READY_MIN_POLL_US,
+			  SUN8I_PWM_PERIOD_READY_MAX_POLL_US);
+
+	ret = readl_poll_timeout(sun8i_chip->base + SUN8I_PWM_PCR(idx), val,
+				 !(val & SUN8I_PWM_PCR_PERIOD_READY), poll_us,
+				 timeout_us);
+	if (!ret)
+		chan->pending_period_ns = 0;
+	else
+		dev_err_ratelimited(pwmchip_parent(chip),
+				    "pwm#%u: update timeout after %llu us\n",
+				    idx, timeout_us);
+
+	return ret;
+}
+
+/*
+ * Protect the rate and quiesce the output if a live update is unsafe. On
+ * failure restore the old clock before restarting an output we stopped.
+ * CCF operations must stay outside the register lock.
+ */
+static int sun8i_pwm_prepare_update(struct pwm_chip *chip, unsigned int idx,
+				    const struct sun8i_pwm_waveform *wfhw,
+				  struct sun8i_pwm_waveform *old)
+{
+	struct sun8i_pwm_chip *sun8i_chip = sun8i_pwm_from_chip(chip);
+	struct sun8i_pwm_channel *chan = &sun8i_chip->channels[idx];
+	unsigned long rate, bus_rate;
+	bool had_exclusive, stop;
+	u32 pccr;
+	int ret, restore_ret;
+
+	scoped_guard(spinlock_irqsave, &sun8i_chip->lock)
+		had_exclusive = chan->rate_exclusive;
+
+	if (!had_exclusive) {
+		ret = clk_rate_exclusive_get(chan->pair_clk);
+		if (ret)
+			return ret;
+		scoped_guard(spinlock_irqsave, &sun8i_chip->lock)
+			chan->rate_exclusive = true;
+	}
+
+	/* Sample the old rate only after excluding other rate changes. */
+	rate = sun8i_pwm_get_pair_rate(sun8i_chip, idx);
+	if (!rate || rate > U32_MAX) {
+		ret = -ERANGE;
+		goto put_rate;
+	}
+	old->pair_rate = rate;
+	scoped_guard(spinlock_irqsave, &sun8i_chip->lock) {
+		old->enabled = sun8i_pwm_channel_is_enabled_locked(sun8i_chip, idx);
+		pccr = sun8i_pwm_readl(sun8i_chip,
+				       SUN8I_PWM_PCCR(SUN8I_PWM_PAIR_IDX(idx)));
+		old->bypass_en = !!(pccr & BIT(SUN8I_PWM_PCCR_BYPASS_BIT(idx)));
+		old->pcr = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCR(idx));
+		old->ppr = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PPR(idx));
+	}
+
+	if (rate != wfhw->pair_rate &&
+	    sun8i_pwm_pair_rate_constrained(sun8i_chip, idx)) {
+		ret = -EBUSY;
+		goto put_rate;
+	}
+
+	/* Live PPR updates require unchanged configuration and a faster PCLK. */
+	bus_rate = clk_get_rate(sun8i_chip->bus_clk);
+	stop = old->enabled &&
+		(old->bypass_en != wfhw->bypass_en || rate != wfhw->pair_rate ||
+		 (!wfhw->bypass_en &&
+		  (((old->pcr ^ wfhw->pcr) &
+		    (SUN8I_PWM_PCR_WAVEFORM_MASK | SUN8I_PWM_PCR_MODE)) ||
+		   bus_rate <= DIV_ROUND_UP_ULL(wfhw->pair_rate,
+			FIELD_GET(SUN8I_PWM_PCR_PRESCAL_K_MASK, wfhw->pcr) + 1))));
+	if (stop) {
+		scoped_guard(spinlock_irqsave, &sun8i_chip->lock)
+			sun8i_pwm_set_enabled_locked(sun8i_chip, idx, false);
+	}
+
+	if (rate == wfhw->pair_rate)
+		return 0;
+
+	ret = clk_set_rate(chan->pair_clk, wfhw->pair_rate);
+	if (!ret && sun8i_pwm_get_pair_rate(sun8i_chip, idx) == wfhw->pair_rate)
+		return 0;
+	if (!ret)
+		ret = -EINVAL;
+
+	if (sun8i_pwm_get_pair_rate(sun8i_chip, idx) != rate) {
+		restore_ret = clk_set_rate(chan->pair_clk, rate);
+		if (restore_ret || sun8i_pwm_get_pair_rate(sun8i_chip, idx) != rate) {
+			dev_err(pwmchip_parent(chip),
+				"pwm#%u: failed to restore pair clock rate %lu\n",
+				idx, rate);
+			goto put_rate;
+		}
+	}
+	if (stop) {
+		scoped_guard(spinlock_irqsave, &sun8i_chip->lock)
+			sun8i_pwm_set_enabled_locked(sun8i_chip, idx, true);
+	}
+put_rate:
+	if (!had_exclusive)
+		sun8i_pwm_put_rate(sun8i_chip, idx);
+
+	return ret;
+}
+
+static int sun8i_pwm_write_waveform(struct pwm_chip *chip,
+				    struct pwm_device *pwm, const void *_wfhw)
+{
+	const struct sun8i_pwm_waveform *wfhw = _wfhw;
+	struct sun8i_pwm_chip *sun8i_chip = sun8i_pwm_from_chip(chip);
+	struct sun8i_pwm_channel *chan = &sun8i_chip->channels[pwm->hwpwm];
+	struct sun8i_pwm_waveform old;
+	u64 old_ns = 0, new_ns;
+	u32 pcr;
+	int ret;
+
+	if (!wfhw->enabled) {
+		scoped_guard(spinlock_irqsave, &sun8i_chip->lock) {
+			sun8i_pwm_set_enabled_locked(sun8i_chip, pwm->hwpwm, false);
+			sun8i_pwm_set_bypass_locked(sun8i_chip, pwm->hwpwm, false);
+		}
+		sun8i_pwm_put_rate(sun8i_chip, pwm->hwpwm);
+		return 0;
+	}
+
+	if (!wfhw->bypass_en) {
+		ret = sun8i_pwm_clear_idle_deadzone(sun8i_chip, pwm->hwpwm);
+		if (ret)
+			return ret;
+		ret = sun8i_pwm_wait_period_ready(chip, pwm->hwpwm);
+		if (ret)
+			return ret;
+	}
+
+	ret = sun8i_pwm_prepare_update(chip, pwm->hwpwm, wfhw, &old);
+	if (ret)
+		return ret;
+
+	if (!wfhw->bypass_en) {
+		/* Apply only waveform fields; never replay status or W1S bits. */
+		pcr = old.pcr & ~(SUN8I_PWM_PCR_WAVEFORM_MASK |
+				  SUN8I_PWM_PCR_MODE | SUN8I_PWM_PCR_PULSE_START |
+				  SUN8I_PWM_PCR_PERIOD_READY);
+		sun8i_pwm_writel(sun8i_chip, pcr | wfhw->pcr,
+				 SUN8I_PWM_PCR(pwm->hwpwm));
+
+		if (old.enabled && !old.bypass_en)
+			old_ns = sun8i_pwm_period_ns(&old);
+		new_ns = sun8i_pwm_period_ns(wfhw);
+		chan->pending_period_ns = max(old_ns, new_ns);
+		sun8i_pwm_writel(sun8i_chip, wfhw->ppr, SUN8I_PWM_PPR(pwm->hwpwm));
+	}
+
+	scoped_guard(spinlock_irqsave, &sun8i_chip->lock) {
+		sun8i_pwm_set_bypass_locked(sun8i_chip, pwm->hwpwm, wfhw->bypass_en);
+		sun8i_pwm_set_enabled_locked(sun8i_chip, pwm->hwpwm, true);
+	}
+
+	return 0;
+}
+
+struct sun8i_pwm_rounding {
+	const struct pwm_waveform *requested;
+	struct sun8i_pwm_waveform best;
+	struct pwm_waveform best_wf;
+	u32 current_pair_rate;
+	bool have_best;
+};
+
+/* Half pair-clock ticks retain the bypass clock's half-period high time. */
+struct sun8i_pwm_ticks {
+	u32 period;
+	u32 duty;
+	u32 offset;
+};
+
+static struct sun8i_pwm_ticks
+sun8i_pwm_waveform_ticks(const struct sun8i_pwm_waveform *wfhw)
+{
+	u32 period = SUN8I_PWM_PPR_PERIOD_VALUE(wfhw->ppr);
+	u32 duty = SUN8I_PWM_PPR_DUTY_VALUE(wfhw->ppr);
+	u32 unit = 2 * (FIELD_GET(SUN8I_PWM_PCR_PRESCAL_K_MASK, wfhw->pcr) + 1);
+	u32 offset = 0;
+
+	if (wfhw->bypass_en)
+		return (struct sun8i_pwm_ticks) { .period = 2, .duty = 1 };
+
+	duty = min(duty, period);
+	if (!(wfhw->pcr & SUN8I_PWM_PCR_ACTIVE_STATE)) {
+		if (duty && duty < period)
+			offset = duty;
+		duty = period - duty;
+	}
+
+	return (struct sun8i_pwm_ticks) {
+		.period = period * unit,
+		.duty = duty * unit,
+		.offset = offset * unit,
+	};
+}
+
+static int sun8i_pwm_cmp_ticks(u32 a, u32 a_rate, u32 b, u32 b_rate)
+{
+	/* Each product is at most 2 * 65536 * 256 * U32_MAX, below 2^57. */
+	u64 lhs = (u64)a * b_rate;
+	u64 rhs = (u64)b * a_rate;
+
+	return (lhs > rhs) - (lhs < rhs);
+}
+
+static void
+sun8i_pwm_choose_waveform(struct sun8i_pwm_rounding *rounding,
+			  const struct sun8i_pwm_waveform *candidate)
+{
+	const struct pwm_waveform *requested = rounding->requested;
+	const struct pwm_waveform *best = &rounding->best_wf;
+	struct pwm_waveform wf;
+	bool better;
+
+	__sun8i_pwm_round_waveform_fromhw(candidate, &wf);
+	/* A zero-duty, zero-offset cycle-mode candidate always exists. */
+	if (wf.duty_length_ns > requested->duty_length_ns ||
+	    wf.duty_offset_ns > requested->duty_offset_ns)
+		return;
+
+	if (!rounding->have_best) {
+		better = true;
+	} else {
+		struct sun8i_pwm_ticks a = sun8i_pwm_waveform_ticks(candidate);
+		struct sun8i_pwm_ticks b = sun8i_pwm_waveform_ticks(&rounding->best);
+		u32 a_rate = candidate->pair_rate, b_rate = rounding->best.pair_rate;
+		bool a_down = wf.period_length_ns <= requested->period_length_ns;
+		bool b_down = best->period_length_ns <= requested->period_length_ns;
+		int period = sun8i_pwm_cmp_ticks(a.period, a_rate, b.period, b_rate);
+		int duty = sun8i_pwm_cmp_ticks(a.duty, a_rate, b.duty, b_rate);
+		int offset = sun8i_pwm_cmp_ticks(a.offset, a_rate, b.offset, b_rate);
+
+		/* Compare before rounding so duty cannot mask a better period. */
+		if (a_down != b_down)
+			better = a_down;
+		else if (period)
+			better = a_down ? period > 0 : period < 0;
+		else if (duty)
+			better = duty > 0;
+		else if (offset)
+			better = offset > 0;
+		else
+			/* Prefer the current pair rate for exactly equal waveforms. */
+			better = a_rate == rounding->current_pair_rate &&
+				 b_rate != rounding->current_pair_rate;
+	}
+	if (!better)
+		return;
+
+	rounding->best = *candidate;
+	rounding->best_wf = wf;
+	rounding->have_best = true;
+}
+
+static struct sun8i_pwm_waveform
+sun8i_pwm_round_cycle(const struct pwm_waveform *requested, u32 pair_rate,
+		      u16 div_k)
+{
+	struct sun8i_pwm_waveform candidate = {
+		.enabled = true,
+		.pair_rate = pair_rate,
+		.pcr = FIELD_PREP(SUN8I_PWM_PCR_PRESCAL_K_MASK, div_k - 1),
+	};
+	u64 denominator = NSEC_PER_SEC * (u64)div_k;
+	u64 duty_ticks, period_ticks;
+	u32 inactive_ticks;
+
+	/* Floor division rounds down, except for the minimum one-tick period. */
+	period_ticks = mul_u64_u64_div_u64(requested->period_length_ns,
+					   pair_rate, denominator);
+	period_ticks = clamp_t(u64, period_ticks, 1, SUN8I_PWM_PPR_PERIOD_MAX);
+	duty_ticks = mul_u64_u64_div_u64(requested->duty_length_ns,
+					 pair_rate, denominator);
+	duty_ticks = min(duty_ticks, period_ticks);
+
+	/*
+	 * Zero active ticks encode either constant level. For a toggling
+	 * waveform, active-low mode places the rising edge after the inactive
+	 * part, which is the only non-zero offset supported by the hardware.
+	 */
+	if (!duty_ticks) {
+		candidate.pcr |= SUN8I_PWM_PCR_ACTIVE_STATE;
+	} else if (duty_ticks == period_ticks) {
+		duty_ticks = 0;
+	} else {
+		inactive_ticks = period_ticks - duty_ticks;
+		if (sun8i_pwm_ticks_to_ns(inactive_ticks, div_k, pair_rate) <=
+		    requested->duty_offset_ns)
+			duty_ticks = inactive_ticks;
+		else
+			candidate.pcr |= SUN8I_PWM_PCR_ACTIVE_STATE;
+	}
+
+	candidate.ppr = SUN8I_PWM_PPR_PERIOD(period_ticks) |
+			SUN8I_PWM_PPR_DUTY(duty_ticks);
+
+	return candidate;
+}
+
+static void
+sun8i_pwm_consider_pair_rate(struct sun8i_pwm_rounding *rounding, u32 pair_rate)
+{
+	struct sun8i_pwm_waveform candidate;
+
+	for (unsigned int div_k = 1; div_k <= 256; div_k++) {
+		candidate = sun8i_pwm_round_cycle(rounding->requested, pair_rate, div_k);
+		sun8i_pwm_choose_waveform(rounding, &candidate);
+	}
+
+	candidate = (struct sun8i_pwm_waveform) {
+		.pair_rate = pair_rate,
+		.enabled = true,
+		.bypass_en = true,
+	};
+	sun8i_pwm_choose_waveform(rounding, &candidate);
+}
+
+static int sun8i_pwm_round_waveform_tohw(struct pwm_chip *chip,
+					 struct pwm_device *pwm,
+					 const struct pwm_waveform *wf,
+					 void *_wfhw)
+{
+	struct sun8i_pwm_chip *sun8i_chip = sun8i_pwm_from_chip(chip);
+	struct sun8i_pwm_pair *pair =
+		&sun8i_chip->pairs[SUN8I_PWM_PAIR_IDX(pwm->hwpwm)];
+	struct sun8i_pwm_waveform *wfhw = _wfhw;
+	struct sun8i_pwm_rounding rounding = {
+		.requested = wf,
+	};
+	unsigned long current_rate;
+
+	if (!wf->period_length_ns) {
+		*wfhw = (struct sun8i_pwm_waveform) {
+			.enabled = false,
+		};
+		return 0;
+	}
+
+	current_rate = sun8i_pwm_get_pair_rate(sun8i_chip, pwm->hwpwm);
+	if (!current_rate || current_rate > U32_MAX)
+		return -ERANGE;
+	rounding.current_pair_rate = current_rate;
+
+	if (sun8i_pwm_pair_rate_constrained(sun8i_chip, pwm->hwpwm)) {
+		sun8i_pwm_consider_pair_rate(&rounding, current_rate);
+	} else {
+		for (unsigned int parent_idx = 0;
+		     parent_idx < clk_hw_get_num_parents(pair->hw);
+		     parent_idx++) {
+			struct clk_hw *parent;
+			unsigned long parent_rate;
+
+			parent = clk_hw_get_parent_by_index(pair->hw, parent_idx);
+			if (!parent)
+				continue;
+			parent_rate = clk_hw_get_rate(parent);
+			if (!parent_rate)
+				continue;
+
+			for (unsigned int i = 0; sun8i_pwm_div_m_table[i].div;
+			     i++) {
+				u16 div_m = sun8i_pwm_div_m_table[i].div;
+				u64 pair_rate;
+
+				pair_rate = DIV_ROUND_UP_ULL(parent_rate, div_m);
+				if (!pair_rate || pair_rate > U32_MAX)
+					continue;
+				sun8i_pwm_consider_pair_rate(&rounding, pair_rate);
+			}
+		}
+	}
+
+	if (!rounding.have_best)
+		return -EINVAL;
+	*wfhw = rounding.best;
+
+	dev_dbg(pwmchip_parent(chip),
+		"pwm#%u: %llu/%llu [+%llu] -> pair-rate=%u, pcr=%#x, ppr=%#x, bypass=%u\n",
+		pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns,
+		wf->duty_offset_ns, wfhw->pair_rate, wfhw->pcr, wfhw->ppr,
+		wfhw->bypass_en);
+
+	return rounding.best_wf.period_length_ns > wf->period_length_ns;
+}
+
+static const struct pwm_ops sun8i_pwm_ops = {
+	.request = sun8i_pwm_request,
+	.free = sun8i_pwm_free,
+	.sizeof_wfhw = sizeof(struct sun8i_pwm_waveform),
+	.round_waveform_tohw = sun8i_pwm_round_waveform_tohw,
+	.round_waveform_fromhw = sun8i_pwm_round_waveform_fromhw,
+	.read_waveform = sun8i_pwm_read_waveform,
+	.write_waveform = sun8i_pwm_write_waveform,
+};
+
+/* Register the shared mux, gate and /div_m clock for each channel pair. */
+static int sun8i_pwm_register_pair_clocks(struct device *dev,
+					  struct sun8i_pwm_chip *sun8i_chip)
+{
+	static const struct clk_parent_data parent_data[] = {
+		{ .index = 0 },
+		{ .index = 1 },
+	};
+
+	for (unsigned int i = 0; i < SUN8I_PWM_NPAIRS; i++) {
+		struct sun8i_pwm_pair *pair = &sun8i_chip->pairs[i];
+		void __iomem *reg = sun8i_chip->base + SUN8I_PWM_PCCR(i);
+		const char *name;
+		int ret;
+
+		name = devm_kasprintf(dev, GFP_KERNEL,
+				      "%s#pwm-clk-src%u%u", dev_name(dev),
+				       i * 2, i * 2 + 1);
+		if (!name)
+			return -ENOMEM;
+
+		pair->mux.reg = reg;
+		pair->mux.shift = SUN8I_PWM_PCCR_SRC_SHIFT;
+		pair->mux.mask = SUN8I_PWM_PCCR_SRC_MASK;
+		pair->mux.flags = CLK_MUX_ROUND_CLOSEST;
+		pair->mux.lock = &sun8i_chip->lock;
+
+		pair->chip = sun8i_chip;
+		pair->index = i;
+
+		pair->divider.reg = reg;
+		pair->divider.shift = SUN8I_PWM_PCCR_DIV_M_SHIFT;
+		pair->divider.width = SUN8I_PWM_PCCR_DIV_M_WIDTH;
+		pair->divider.table = sun8i_pwm_div_m_table;
+		pair->divider.lock = &sun8i_chip->lock;
+
+		pair->hw = devm_clk_hw_register_composite_pdata(dev, name,
+								parent_data,
+								ARRAY_SIZE(parent_data),
+			&pair->mux.hw, &clk_mux_ops,
+			&pair->divider.hw, &clk_divider_ops,
+			&pair->gate_hw, &sun8i_pwm_pair_gate_ops, 0);
+		if (IS_ERR(pair->hw))
+			return dev_err_probe(dev, PTR_ERR(pair->hw),
+					     "Failed to register pair %u clock\n", i);
+
+		/* Borrow CCF's handle so registration cannot pin this module. */
+		pair->rate_nb.notifier_call = sun8i_pwm_pair_rate_notifier;
+		ret = devm_clk_notifier_register(dev, pair->hw->clk, &pair->rate_nb);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to protect pair %u clock rate\n", i);
+	}
+
+	return 0;
+}
+
+/*
+ * A disabled pair gate makes any set PER bits ineffective. Clear those stale
+ * enables before a clock consumer can turn the shared gate on and expose an
+ * unrequested output.
+ */
+static void
+sun8i_pwm_sanitize_disabled_pairs(struct sun8i_pwm_chip *sun8i_chip)
+{
+	u32 per;
+
+	guard(spinlock_irqsave)(&sun8i_chip->lock);
+	per = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
+	for (unsigned int pair = 0; pair < SUN8I_PWM_NPAIRS; pair++) {
+		unsigned int first = pair * 2;
+		u32 pccr;
+
+		pccr = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair));
+		if (pccr & SUN8I_PWM_PCCR_GATE)
+			continue;
+
+		per &= ~sun8i_pwm_pair_enable_mask(pair);
+		pccr &= ~BIT(SUN8I_PWM_PCCR_BYPASS_BIT(first));
+		pccr &= ~BIT(SUN8I_PWM_PCCR_BYPASS_BIT(first + 1));
+		sun8i_pwm_writel(sun8i_chip, pccr, SUN8I_PWM_PCCR(pair));
+	}
+	sun8i_pwm_writel(sun8i_chip, per, SUN8I_PWM_PER);
+}
+
+static int sun8i_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sun8i_pwm_chip *sun8i_chip;
+	struct reset_control *rst;
+	struct pwm_chip *chip;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, SUN8I_PWM_NPWM, sizeof(*sun8i_chip));
+	if (IS_ERR(chip))
+		return dev_err_probe(dev, PTR_ERR(chip),
+				     "Failed to allocate pwmchip\n");
+
+	sun8i_chip = sun8i_pwm_from_chip(chip);
+	spin_lock_init(&sun8i_chip->lock);
+	sun8i_chip->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(sun8i_chip->base))
+		return dev_err_probe(dev, PTR_ERR(sun8i_chip->base),
+				     "Failed to get PWM base address\n");
+
+	sun8i_chip->bus_clk = devm_clk_get_enabled(dev, "bus");
+	if (IS_ERR(sun8i_chip->bus_clk))
+		return dev_err_probe(dev, PTR_ERR(sun8i_chip->bus_clk),
+				     "Failed to get bus clock\n");
+
+	rst = devm_reset_control_get_shared_deasserted(dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst),
+				     "Failed to get reset control\n");
+
+	chip->ops = &sun8i_pwm_ops;
+
+	sun8i_pwm_sanitize_disabled_pairs(sun8i_chip);
+
+	ret = sun8i_pwm_register_pair_clocks(dev, sun8i_chip);
+	if (ret)
+		return ret;
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
+
+	return 0;
+}
+
+static const struct of_device_id sun8i_pwm_dt_ids[] = {
+	{
+		.compatible = "allwinner,sun50i-h616-pwm",
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, sun8i_pwm_dt_ids);
+
+static struct platform_driver sun8i_pwm_driver = {
+	.driver = {
+		.name = "sun8i-pwm",
+		.of_match_table = sun8i_pwm_dt_ids,
+	},
+	.probe = sun8i_pwm_probe,
+};
+module_platform_driver(sun8i_pwm_driver);
+
+MODULE_AUTHOR("Richard Genoud <richard.genoud@bootlin.com>");
+MODULE_DESCRIPTION("Allwinner sun8i PWM driver");
+MODULE_LICENSE("GPL");

-- 
2.53.0


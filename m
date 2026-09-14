Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE84F440636
	for <linux-pwm@vger.kernel.org>; Mon, 14 Sep 2026 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789384080; cv=none; b=MC9ZrkjGD76aXMrtg3v01WRQGrHoHJZACSzX3/X0GukdV1aApWxbj77dc3J4HODjTZCpBhLNIQRMrYtsmnyyceylJZT7DwILTPlywDlrBykSmGB+Xi0o9kly6c5gH7ccVZn8S239IzmoPzYCRBwx+IgdXR2lTYizZ/Wygz96w0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789384080; c=relaxed/simple;
	bh=8CVlEdTUPZyqpE/wvA5bWHWaiuKmPuNHNPr5xgaN1qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RuTMnCuWTht11JpfiTwvvjd6LQhzPQyCJANWhBPNApIggLUKillJpzWJ1XWYQjADpnWnqUwttJUbDB/HWxZKt+/eky35qQbAzZ4+daF9hJQEjiUcp4IIonl0Bf9sN1TcweDCQ56nVY4luUnFd2X3lnotXFIDEsU5zf+ce0El8ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOCmby7/; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOCmby7/"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so1549805a91.1
        for <linux-pwm@vger.kernel.org>; Mon, 14 Sep 2026 04:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789384077; x=1789988877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yZ9RlkaTeZXfa/E/pJBZ/0+OW6X5wQzN+v8yUCtqC70=;
        b=oOCmby7/KWlETrXArOD+/QTr6MZ+RxrwUyJHGPtiHeyba+qCrdnuFFTVsNhc0cHV16
         RYXy4+t9dX34xDJ+adXhGfae3iIHU52nJQQoT0GaJrJz9JaCUGNkNfxFFvRvo8VlCo2E
         HQITDg76fCx+gq9lLrFYhOSxANgS6Nz5M9JGwbbEqeU0w2h5H3zpE0FdGFjInn9rUHy5
         09o1lBORgOHqYaJviIYa9zmXxBxDMmGxgThcPsW2iLk5yPDNB/bttvfsOe8zxV8GShb7
         0WzJpae/QM3ime/b5ucuSleLneu4S2TBToAeScOeea+oi5BPmqX8+oZTWo3DHf9t+TBe
         CWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789384077; x=1789988877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yZ9RlkaTeZXfa/E/pJBZ/0+OW6X5wQzN+v8yUCtqC70=;
        b=BHV+28Eua4D5z4pyk+onqFOXhL1Gmbk8En2F27S4WgIs/AX9TLzDRkLxRhwPdD7t9y
         NYAgAV8FHSuK3op/TH2B228FncZNz1oWn5Ci1S6P7V6r1yPJjNtXDiNPbfgeqeEWKBap
         25mBex67nEAyok+tCu/Gkcp2/XgPuNk+HvbKeHZJ58CrcBhIgs567DjzNpj/vQ6/3Oug
         znQA9Ezw6c/yioKjmB0SZBVq9MqdXeH2C+8g1BWdcgFCd/p8mc0bmJRjTQHgf4QL5pd+
         OAvCkz1F6dcM0uJZBcB6kUrE5JxZf8daDgzI9qBbL8d0dmtQyyQy60EVCKMkkg9wO8If
         g45g==
X-Forwarded-Encrypted: i=1; AKwUvBz+Mz8IVUwhR5XlVXgXvZ5N75kIXB2yXH5B9endBBNue47zEkMwKTnI+pY0GWzgUEnOlnr9ZGKSLXE=@vger.kernel.org
X-Gm-Message-State: AFuF++lFiJmUv4HLHypwseTA29gFn7kV/vGbV5Sc7QgHolhx0msQVa5y
	qjO6m/sKfbJEkWo+/iZWI0VDOUg+/5rND3FUz35N7kfHyry+uV96y1Xj
X-Gm-Gg: AYBFou0QtBxBly7dGxHvxOwT0R/JIDL+W1CkApJSZpd6fWJkmmoGXEx4X+0o9OROwz5
	kfO9YW1CLQHOyvb4tJ7AxR8qWgB1aLvs19MgCIp1FCm20oNtpJwZ8Ls9QgA7RRMIkRTiNSs4dIw
	ctQuedCcSvo6IJl0LMydAhPnam7lCjo/8vo1ChhqLVuytJWKbh3NlHyVM995Hz2N7SndCAOhjXX
	Lf/gTl+T2zm22MDzlflfdPeVMuQFk1lK4YXii1trMVewUbUs7VW5kF7EPPWyq2+/6NeJi7vWRQh
	QMuTWbbcrh3OaCzmTDTXmFC1N5VbIVuCkXKR1EboAgQl5xqky2byQn1O9toEtPON4JTGfDaJKAa
	2HcRq5AsJjteo+YJyIn7IZhho6Yuf61UECXBYImycKxVv6hZvJXRBZxU4EvP1vzv7d+trdLcO4h
	nSeCCcTbz2lf3oyKvA6DHNoIdl+eGG8NtM5q34no8LsWqiE8uzWzIZQ4fxcsiSxHf3sIn81Wa5K
	Syb3MVZijPpIjkM48F98OVSPen9Tm3dgbBYtlYZEnZaF6PjA+GzkT/PPdWX
X-Received: by 2002:a17:90b:39cc:b0:39d:b769:3067 with SMTP id 98e67ed59e1d1-39debdffe17mr4591852a91.0.1789384077156;
        Mon, 14 Sep 2026 04:07:57 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9540fd76sm22996627a91.9.2026.09.14.04.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:07:56 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com
Subject: [PATCH v6 2/2] pwm: Add Nuvoton MA35D1 PWM controller support
Date: Mon, 14 Sep 2026 19:07:39 +0800
Message-Id: <20260914110739.203479-3-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260914110739.203479-1-cwweng.linux@gmail.com>
References: <20260914110739.203479-1-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chi-Wen Weng <cwweng@nuvoton.com>

Add a PWM framework driver for the Nuvoton MA35D1 EPWM controller.

The controller provides 6 PWM channels. The initial driver supports
up-counting, auto-reload, independent output mode and period loading
mode.

Configure the waveform generator to drive the output high at the zero
point and low at the compare-up point. In up-counting mode the counter
counts from 0 to PERIOD inclusive. CMPDAT = 0 therefore generates a 0%
duty cycle, while CMPDAT > PERIOD generates a 100% duty cycle.

Limit the period to 0xffff counter cycles so that PERIOD is at most
0xfffe and CMPDAT = 0xffff remains available to represent a 100% duty
cycle.

The clock prescaler is shared by each pair of PWM channels. Preserve
the existing prescaler value and account for CLKPSC + 1 when calculating
and reporting the period and duty cycle.

Do not modify the controller during probe, preserving PWM outputs that
may have been configured by firmware. Configure only the requested
channel from the apply callback, and refuse to change an active
complementary pair to independent mode if doing so would disturb the
paired output.

Period and compare values use the hardware period-loading buffers.
Because PERIOD and CMPDAT are written separately, a period boundary
between the two writes can result in one transitional cycle using the
new period with the previous duty cycle.

When disabling a channel, clear its output-enable and counter-enable
bits. Clearing the output-enable bit places the output pin in high
impedance.

Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
---
 drivers/pwm/Kconfig      |  10 +
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-ma35d1.c | 387 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 398 insertions(+)
 create mode 100644 drivers/pwm/pwm-ma35d1.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index e8886a9b64d9..d971760b37c6 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -463,6 +463,16 @@ config PWM_LPSS_PLATFORM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-lpss-platform.
 
+config PWM_MA35D1
+	tristate "Nuvoton MA35D1 PWM support"
+	depends on ARCH_MA35 || COMPILE_TEST
+	help
+	  Generic PWM framework driver for the Nuvoton MA35D1 PWM
+	  controller, which provides 6 PWM outputs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-ma35d1.
+
 config PWM_MAX7360
 	tristate "MAX7360 PWMs"
 	depends on MFD_MAX7360
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 5630a521a7cf..7ad761ea27d1 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
 obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
 obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
 obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
+obj-$(CONFIG_PWM_MA35D1)	+= pwm-ma35d1.o
 obj-$(CONFIG_PWM_MAX7360)	+= pwm-max7360.o
 obj-$(CONFIG_PWM_MC33XS2410)	+= pwm-mc33xs2410.o
 obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
diff --git a/drivers/pwm/pwm-ma35d1.c b/drivers/pwm/pwm-ma35d1.c
new file mode 100644
index 000000000000..0db9a6729d3f
--- /dev/null
+++ b/drivers/pwm/pwm-ma35d1.c
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the Nuvoton MA35D1 PWM controller
+ *
+ * Copyright (C) 2026 Nuvoton Corporation
+ *               Chi-Wen Weng <cwweng@nuvoton.com>
+ *
+ * Reference Manual:
+ * https://www.nuvoton.com/resource-download.jsp?tp_GUID=DA05-MA35D16
+ *
+ * Limitations:
+ * - The hardware supports 6 PWM channels.
+ * - The hardware supports up, down and up-down counter types. This driver
+ *   supports up-counting mode only.
+ * - The hardware supports auto-reload and one-shot counter modes. This driver
+ *   supports auto-reload mode only.
+ * - The hardware supports independent and complementary output modes. This
+ *   driver supports independent mode only. If a channel pair is already active
+ *   in complementary mode, applying a new state to one channel fails with
+ *   -EBUSY to avoid disturbing the paired output.
+ * - The hardware supports period, immediate, window and center loading modes.
+ *   This driver supports period loading mode only.
+ * - The hardware supports programmable waveform actions at zero, period and
+ *   compare points. This driver uses zero point high and compare-up point low
+ *   actions for normal PWM output.
+ * - In up-counting mode, the counter counts from 0 to PERIOD inclusive. With
+ *   zero point high and compare-up point low actions, CMPDAT = 0 produces 0%
+ *   duty and CMPDAT > PERIOD produces 100% duty.
+ * - The driver limits the period to 0xffff counter cycles so that CMPDAT can
+ *   be set greater than PERIOD to generate a 100% duty cycle.
+ * - Period and duty cycle changes are buffered by hardware and take effect at
+ *   the end of the current period.
+ * - The clock prescaler is shared by each channel pair. The driver preserves
+ *   the current prescaler and accounts for it in period and duty calculations.
+ * - Polarity and waveform-control changes are applied directly and may cause
+ *   a transient output change if the PWM output is running.
+ * - When disabled, the output pin is put in tri-state by clearing POENn.
+ */
+
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+#define MA35D1_REG_PWM_CTL0			0x00
+#define MA35D1_REG_PWM_CTL1			0x04
+#define MA35D1_REG_PWM_CLKPSC(ch)		(0x14 + 4 * ((ch) / 2))
+#define MA35D1_REG_PWM_CNTEN			0x20
+#define MA35D1_REG_PWM_PERIOD(ch)		(0x30 + 4 * (ch))
+#define MA35D1_REG_PWM_CMPDAT(ch)		(0x50 + 4 * (ch))
+#define MA35D1_REG_PWM_WGCTL0			0xb0
+#define MA35D1_REG_PWM_WGCTL1			0xb4
+#define MA35D1_REG_PWM_POLCTL			0xd4
+#define MA35D1_REG_PWM_POEN			0xd8
+
+#define MA35D1_PWM_CTL0_CTRLD(ch)		BIT(ch)
+#define MA35D1_PWM_CTL0_WINLDEN(ch)		BIT(8 + (ch))
+#define MA35D1_PWM_CTL0_IMMLDEN(ch)		BIT(16 + (ch))
+
+#define MA35D1_PWM_CTL1_CNTTYPE_MASK(ch)	(0x3 << (2 * (ch)))
+#define MA35D1_PWM_CTL1_CNTMODE_MASK(ch)	BIT(16 + (ch))
+#define MA35D1_PWM_CTL1_OUTMODE_MASK(ch)	BIT(24 + ((ch) / 2))
+
+#define MA35D1_PWM_WGCTL_ACTION_MASK		0x3
+#define MA35D1_PWM_WGCTL_ACTION(ch)		\
+	(MA35D1_PWM_WGCTL_ACTION_MASK << (2 * (ch)))
+#define MA35D1_PWM_WGCTL_ACTION_VAL(ch, action)	((action) << (2 * (ch)))
+#define MA35D1_PWM_WGCTL_ACTION_LOW		1
+#define MA35D1_PWM_WGCTL_ACTION_HIGH		2
+
+#define MA35D1_PWM_CLKPSC_MASK			GENMASK(11, 0)
+#define MA35D1_PWM_DATA_MASK			GENMASK(15, 0)
+#define MA35D1_PWM_MAX_CYCLES			0xffff
+
+#define MA35D1_PWM_CNTEN_EN(ch)			BIT(ch)
+#define MA35D1_PWM_POEN_EN(ch)			BIT(ch)
+#define MA35D1_PWM_POLCTL_INV(ch)		BIT(ch)
+
+#define MA35D1_PWM_NUM_CHANNELS			6
+
+struct nuvoton_pwm {
+	void __iomem *base;
+	unsigned long clkrate;
+};
+
+static inline struct nuvoton_pwm *nuvoton_pwm_from_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static inline u32 nuvoton_pwm_readl(struct nuvoton_pwm *nvtpwm,
+				    unsigned int offset)
+{
+	return readl(nvtpwm->base + offset);
+}
+
+static inline void nuvoton_pwm_writel(struct nuvoton_pwm *nvtpwm,
+				      unsigned int offset, u32 value)
+{
+	writel(value, nvtpwm->base + offset);
+}
+
+static inline void nuvoton_pwm_rmw(struct nuvoton_pwm *nvtpwm,
+				   unsigned int offset, u32 mask, u32 value)
+{
+	u32 reg;
+
+	reg = nuvoton_pwm_readl(nvtpwm, offset);
+	reg &= ~mask;
+	reg |= value & mask;
+	nuvoton_pwm_writel(nvtpwm, offset, reg);
+}
+
+static bool nuvoton_pwm_channel_active(struct nuvoton_pwm *nvtpwm,
+				       unsigned int ch)
+{
+	u32 cnten, poen;
+	u32 mask = BIT(ch);
+
+	cnten = nuvoton_pwm_readl(nvtpwm, MA35D1_REG_PWM_CNTEN);
+	poen = nuvoton_pwm_readl(nvtpwm, MA35D1_REG_PWM_POEN);
+
+	return (cnten | poen) & mask;
+}
+
+static u32 nuvoton_pwm_get_prescale(struct nuvoton_pwm *nvtpwm,
+				    unsigned int ch)
+{
+	return nuvoton_pwm_readl(nvtpwm, MA35D1_REG_PWM_CLKPSC(ch)) &
+	       MA35D1_PWM_CLKPSC_MASK;
+}
+
+static int nuvoton_pwm_config_channel(struct nuvoton_pwm *nvtpwm,
+				      unsigned int ch)
+{
+	u32 ctl0_mask;
+	u32 ctl1, ctl1_mask, outmode_mask;
+	u32 wgctl0_mask, wgctl0_val;
+	u32 wgctl1_mask, wgctl1_val;
+
+	outmode_mask = MA35D1_PWM_CTL1_OUTMODE_MASK(ch);
+	ctl1 = nuvoton_pwm_readl(nvtpwm, MA35D1_REG_PWM_CTL1);
+
+	if ((ctl1 & outmode_mask) &&
+	    nuvoton_pwm_channel_active(nvtpwm, ch ^ 1))
+		return -EBUSY;
+
+	/*
+	 * IMMLDENn = 0, WINLDENn = 0 and CTRLDn = 0 select period loading
+	 * mode for up-counting operation.
+	 */
+	ctl0_mask = MA35D1_PWM_CTL0_IMMLDEN(ch);
+	ctl0_mask |= MA35D1_PWM_CTL0_WINLDEN(ch);
+	ctl0_mask |= MA35D1_PWM_CTL0_CTRLD(ch);
+
+	/*
+	 * CNTTYPEn = 00: up counter type
+	 * CNTMODEn = 0: auto-reload mode
+	 * OUTMODEn = 0: independent mode
+	 */
+	ctl1_mask = MA35D1_PWM_CTL1_CNTTYPE_MASK(ch);
+	ctl1_mask |= MA35D1_PWM_CTL1_CNTMODE_MASK(ch);
+	ctl1_mask |= outmode_mask;
+
+	/*
+	 * ZPCTLn = 10: output high at zero point
+	 * PRDPCTLn = 00: do nothing at period point
+	 */
+	wgctl0_mask = MA35D1_PWM_WGCTL_ACTION(ch);
+	wgctl0_mask |= MA35D1_PWM_WGCTL_ACTION(ch) << 16;
+	wgctl0_val = MA35D1_PWM_WGCTL_ACTION_VAL(ch,
+						 MA35D1_PWM_WGCTL_ACTION_HIGH);
+
+	/*
+	 * CMPUCTLn = 01: output low at compare up point
+	 * CMPDCTLn = 00: do nothing at compare down point
+	 */
+	wgctl1_mask = MA35D1_PWM_WGCTL_ACTION(ch);
+	wgctl1_mask |= MA35D1_PWM_WGCTL_ACTION(ch) << 16;
+	wgctl1_val = MA35D1_PWM_WGCTL_ACTION_VAL(ch,
+						 MA35D1_PWM_WGCTL_ACTION_LOW);
+
+	nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_CTL0, ctl0_mask, 0);
+	nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_CTL1, ctl1_mask, 0);
+	nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_WGCTL0,
+			wgctl0_mask, wgctl0_val);
+	nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_WGCTL1,
+			wgctl1_mask, wgctl1_val);
+
+	return 0;
+}
+
+static int nuvoton_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	struct nuvoton_pwm *nvtpwm = nuvoton_pwm_from_chip(chip);
+	unsigned int ch = pwm->hwpwm;
+	u64 duty_cycles, period_cycles;
+	u64 divisor;
+	u32 cmpdat, period, prescale;
+	int ret;
+
+	if (!state->enabled) {
+		/* Clearing POENn disables the output driver and makes the pin high-Z. */
+		nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_POEN,
+				MA35D1_PWM_POEN_EN(ch), 0);
+		nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_CNTEN,
+				MA35D1_PWM_CNTEN_EN(ch), 0);
+
+		return 0;
+	}
+
+	prescale = nuvoton_pwm_get_prescale(nvtpwm, ch);
+	divisor = (u64)NSEC_PER_SEC * (prescale + 1);
+
+	period_cycles = mul_u64_u64_div_u64(nvtpwm->clkrate,
+					    state->period, divisor);
+	if (!period_cycles)
+		return -EINVAL;
+
+	if (period_cycles > MA35D1_PWM_MAX_CYCLES)
+		period_cycles = MA35D1_PWM_MAX_CYCLES;
+
+	duty_cycles = mul_u64_u64_div_u64(nvtpwm->clkrate,
+					  state->duty_cycle, divisor);
+	if (duty_cycles > period_cycles)
+		duty_cycles = period_cycles;
+
+	ret = nuvoton_pwm_config_channel(nvtpwm, ch);
+	if (ret)
+		return ret;
+
+	if (state->polarity == PWM_POLARITY_NORMAL)
+		nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_POLCTL,
+				MA35D1_PWM_POLCTL_INV(ch), 0);
+	else
+		nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_POLCTL,
+				MA35D1_PWM_POLCTL_INV(ch),
+				MA35D1_PWM_POLCTL_INV(ch));
+
+	/*
+	 * In up-counting mode the counter counts from 0 to PERIOD inclusive.
+	 * With zero point high and compare-up point low actions:
+	 * - CMPDAT = 0 produces 0% duty.
+	 * - CMPDAT > PERIOD produces 100% duty.
+	 *
+	 * period_cycles is limited to 0xffff, so PERIOD is at most 0xfffe
+	 * and a 100% duty cycle can be represented by CMPDAT = 0xffff.
+	 */
+	period = period_cycles - 1;
+	cmpdat = duty_cycles;
+
+	/*
+	 * PERIOD and CMPDAT are loaded into their active buffers at a period
+	 * boundary. If a period boundary occurs between these two writes, one
+	 * cycle can use the new PERIOD value with the previous CMPDAT value.
+	 * The following period then uses both new values.
+	 */
+	nuvoton_pwm_writel(nvtpwm, MA35D1_REG_PWM_PERIOD(ch), period);
+	nuvoton_pwm_writel(nvtpwm, MA35D1_REG_PWM_CMPDAT(ch), cmpdat);
+
+	nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_POEN,
+			MA35D1_PWM_POEN_EN(ch), MA35D1_PWM_POEN_EN(ch));
+	nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_CNTEN,
+			MA35D1_PWM_CNTEN_EN(ch), MA35D1_PWM_CNTEN_EN(ch));
+
+	return 0;
+}
+
+static int nuvoton_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	struct nuvoton_pwm *nvtpwm = nuvoton_pwm_from_chip(chip);
+	unsigned int ch = pwm->hwpwm;
+	u32 cmpdat, cnten, period, poen, polctl, prescale;
+	u64 duty_cycles, period_cycles;
+	u64 prescaled_cycles;
+
+	cnten = nuvoton_pwm_readl(nvtpwm, MA35D1_REG_PWM_CNTEN);
+	poen = nuvoton_pwm_readl(nvtpwm, MA35D1_REG_PWM_POEN);
+	polctl = nuvoton_pwm_readl(nvtpwm, MA35D1_REG_PWM_POLCTL);
+	prescale = nuvoton_pwm_get_prescale(nvtpwm, ch);
+	period = nuvoton_pwm_readl(nvtpwm, MA35D1_REG_PWM_PERIOD(ch)) &
+		 MA35D1_PWM_DATA_MASK;
+	cmpdat = nuvoton_pwm_readl(nvtpwm, MA35D1_REG_PWM_CMPDAT(ch)) &
+		 MA35D1_PWM_DATA_MASK;
+
+	period_cycles = period + 1;
+	if (cmpdat > period)
+		duty_cycles = period_cycles;
+	else
+		duty_cycles = cmpdat;
+
+	state->enabled = (cnten & MA35D1_PWM_CNTEN_EN(ch)) &&
+			 (poen & MA35D1_PWM_POEN_EN(ch));
+	state->polarity = (polctl & MA35D1_PWM_POLCTL_INV(ch)) ?
+			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+
+	prescaled_cycles = period_cycles * (prescale + 1);
+	state->period = DIV64_U64_ROUND_UP(prescaled_cycles * NSEC_PER_SEC,
+					   nvtpwm->clkrate);
+
+	prescaled_cycles = duty_cycles * (prescale + 1);
+	state->duty_cycle =
+		DIV64_U64_ROUND_UP(prescaled_cycles * NSEC_PER_SEC,
+				   nvtpwm->clkrate);
+
+	return 0;
+}
+
+static const struct pwm_ops nuvoton_pwm_ops = {
+	.apply = nuvoton_pwm_apply,
+	.get_state = nuvoton_pwm_get_state,
+};
+
+static int nuvoton_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
+	struct nuvoton_pwm *nvtpwm;
+	struct clk *clk;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, MA35D1_PWM_NUM_CHANNELS,
+				  sizeof(*nvtpwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	nvtpwm = nuvoton_pwm_from_chip(chip);
+
+	nvtpwm->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(nvtpwm->base))
+		return PTR_ERR(nvtpwm->base);
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "Unable to get the clock\n");
+
+	ret = devm_clk_rate_exclusive_get(dev, clk);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Unable to get exclusive clock rate\n");
+
+	nvtpwm->clkrate = clk_get_rate(clk);
+	if (!nvtpwm->clkrate)
+		return dev_err_probe(dev, -EINVAL,
+				     "PWM clock rate is zero\n");
+
+	if (nvtpwm->clkrate > NSEC_PER_SEC)
+		return dev_err_probe(dev, -EINVAL,
+				     "PWM clock out of range (%lu)\n",
+				     nvtpwm->clkrate);
+
+	chip->ops = &nuvoton_pwm_ops;
+	chip->atomic = true;
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to add PWM chip\n");
+
+	return 0;
+}
+
+static const struct of_device_id nuvoton_pwm_of_match[] = {
+	{ .compatible = "nuvoton,ma35d1-pwm" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, nuvoton_pwm_of_match);
+
+static struct platform_driver nuvoton_pwm_driver = {
+	.probe = nuvoton_pwm_probe,
+	.driver = {
+		.name = "nuvoton-pwm",
+		.of_match_table = nuvoton_pwm_of_match,
+	},
+};
+module_platform_driver(nuvoton_pwm_driver);
+
+MODULE_AUTHOR("Chi-Wen Weng <cwweng@nuvoton.com>");
+MODULE_DESCRIPTION("Nuvoton MA35D1 PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


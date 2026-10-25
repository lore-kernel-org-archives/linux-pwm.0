Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792955789;
	b=yYYHX+2Io5lDxWWu+QaHXYXTYQZ0WeELVBGLTmVMPMmmnWlyX7aACa3d/mM6LxUhNQCL
	 kKP4BebljMYqZdgW4qG4tFt4CCshSdBs/08f/SL9Q/4AMveuh9PATs8Omwc1ND/vWXdDa
	 Y7vHDvMpuYyitDvkl53RpedA4zawRvab7pHe+zpe1kM1aHZI0pJsRZJgnuRURHCwLu1Tq
	 IDT1MvQ3k5WQLQVDuXFBO+LvYgMPtumT/SXadcsEFl2WdlKsWtcSw2nKYwPQGRzBreV3L
	 HUpVr6vBdQHzpKqlt0vJfyHK8t/JNa6WSpRNzuagWd37u/Yd9ke8GLy5sRAO/MUEwwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792955789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=shKs+84YFZWm8V4NxmW82M6dcuAtIzUXrpL2zUFyQkQ=;
	b=YUMls3WmrIGnfwg9UdDcpgAcjP07jkI7aa1dC0aBpjA7Kjo2M5Dpf2SnHQrwMBKMpG4F
	 LkkJz+a9Finz3em/qqhjTqLNz69/pZYRNdwskRHEKrwDOrrDXq7sQE1AXZqKpx/VFskzN
	 VlS68akz7zc/dZjdGzGKoQIboQpOkmYe7d5nOFgyS1CuuH84Lk5LDyUXxHFbTOyif4kMw
	 Sw6WisN3ax3RDhrQel6HMUcYy2SU7B4ODhQcIP9XghmWOx01tlHD4oxHHa7nvMK3Th8Cg
	 FKMmsspxBekZmVjGud/Ebw+24o/mCn70xg7McqwG7TmDf6QRzLvCozd45StsWtx3v4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=U8Qcwrll;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044FF606A327
	for <linux-pwm@vger.kernel.org>; Sun, 25 Oct 2026 19:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 044FF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=U8Qcwrll
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48c4d870d54so1367611f8f.2
        for <linux-pwm@vger.kernel.org>; Sun, 25 Oct 2026 12:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792955787; x=1793560587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=shKs+84YFZWm8V4NxmW82M6dcuAtIzUXrpL2zUFyQkQ=;
        b=U8QcwrllUv/1g3l4wdbLJQYb+BNf2wY1221QSR13Pl1paWzFiZw09ejvf+azMdR3eT
         D6FyoXscbem2eHrxMiIXbueJBQrGhC1YhTSuJEZJ6xS3ios5rUtMyE/y2pOigAZQ/BBr
         ntcef6KJOnHuJORj0Op572MSyLYiV44QvfvtN4Gf1iLvsVMPdeY+LsNdXZm1nc+7jwnP
         9+gs1e/1tTZv6No0SNMhRB2v4jpY+DEeNF+vY69abr0oHty4lI5zuL0aZaSlSM9brVrp
         LOWnJPA7ZQcCshHZh3ZQfO1YDfOs6I04ZcO9FCaD5Kvjb6z0BjZIfvI6epZ+3lqjJ+np
         B8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792955787; x=1793560587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=shKs+84YFZWm8V4NxmW82M6dcuAtIzUXrpL2zUFyQkQ=;
        b=hW5UMdBqdoYXPtDmx447Nhr26jjyujv1908bi1P3Cp2PGYVEoGewvmHg+QbaghstE0
         MpvD3SYEWQN+b+q92+U9W/OLTo2EvMlAk3H55cpD3z6L4URI+DVlTDD/AkeWYswYcnCT
         TS6CVVG7k5dBO0WmfOcWK7AV1PDi+WI+OvK74R4RU4TsBZum4hFv8OF8P+vgnIOGtBJc
         ZCUMRXDiu5aYyN4qJ7X8/EF74g3ePj/C4VkeiYywDNi2ukmPIRQ2nrfaaxI/bxKWbzxJ
         zaBiaIC63kokH1jx34kR29fqt2lSzomh3If8uKv4jPLQDNfsleXtXjhQVGvKW7Zehmp6
         Ag8w==
X-Forwarded-Encrypted: i=1; AKwUvBxu9VXnQP1Mg2Rnb2anW3T7mlXqRFTH/95jdiyAyMaDCAZeFlTbi3Wxtgxy7ajIFBDtpa/ZzWS8vlY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwuiQ5K168j3KfDC2LSOA13R3X16EiO5+qfJqEblu5b/drWEXj
	AxilXtFFx4YQb0bVu1SAskNiVZE/sunYsPEdQBo6eozROpLplTqQQoHZvW9jTu8SlRA=
X-Gm-Gg: AYBFou1AhVsaRUkPw5Q8/nAwttn8v3FaAvD9d2G9LRjk7/x15p6GtWONx4OLLT2gx9u
	F13+OWYhpJN2JUYwnozuvAV4jA+r56YXEdXSJk0ZAeHo+2Th2pJLhcaa2P62AnL45AD46hDRGjc
	7q5l8xSyYsBxQV29iDW3LH4RSJUdIjOjZQSiUOJDDNm8i9ohYC6ZGtq6kie2DfKWWW9z2TMd8yE
	MWSJ47IbAUdARVmquZWbLZyFoWYfOGr96LmCv7GKMUlo2i/KmLLz5mUydj9z3PNYiU6aRXTxt85
	3VkvUQH8o+GX3FFUYjTtZiZYdD1BE3qFDYMEItGw/v9Zb8m2o08osZKTstr4bt7fqkzORYAWvYU
	G4VapMCETC1QhXXBAs2vh+6zVVsridp+wJNS7u1NWk7oqYocIwNJ0PRO8OpYY0c2KXOLRsij6wh
	PLk+fomDMp5hTEZ4/j234fBBOazxHAUmWU/BVeVjnw56FRCu1ZsGFfE55d7/Q3lqGy8V2I5Zt8B
	AcaybJVDomTDJairXUUijWn071td/OIibutd/HihdvZwuPFNyOvGZRXOKXQXwZp3Np7fWnXF2c2
	/W41q7I5OvbcOH8=
X-Received: by 2002:a5d:5f81:0:b0:48e:390:80cf with SMTP id ffacd0b85a97d-48e3eb99b12mr8126524f8f.32.1792955787353;
        Sun, 25 Oct 2026 12:16:27 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:6dfc:5715:ead7:7540])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3bcdsm10082051f8f.13.2026.10.25.12.16.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Oct 2026 12:16:26 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH v2 2/2] pwm: Add a driver for the Ingenic X1600 PWM controller
Date: Sun, 25 Oct 2026 20:16:24 +0100
Message-ID: <20261025191624.9219-3-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261025191624.9219-1-olivier@mgcrea.io>
References: <20261025191624.9219-1-olivier@mgcrea.io>
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

The X1600 has a PWM controller of its own, separate from the TCU timers
that pwm-jz4740 drives on earlier Ingenic SoCs (X1600 programming manual,
chapter 13): eight channels, each with a power-of-two clock divider and a
waveform word holding the counts at the high and at the low level, the
channel's initial level picking which comes first. So the duty offset is
0 or period - duty, and since neither count may be zero, a duty cycle of 0
or 100% switches the channel off with its idle level set accordingly.

The driver implements the waveform callbacks. It follows the manual's
order: the divider is only changed with the channel off, and a running
channel takes a new word through the update register.

Tested on a HiBy R1, whose backlight is channel 0.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
v2:
- Read a channel that is off with both counts loaded as disabled.
- Refuse a clock rate of 0 in round_waveform_tohw() and write_waveform().

 MAINTAINERS                     |   1 +
 drivers/pwm/Kconfig             |  11 ++
 drivers/pwm/Makefile            |   1 +
 drivers/pwm/pwm-ingenic-x1600.c | 280 ++++++++++++++++++++++++++++++++
 4 files changed, 293 insertions(+)
 create mode 100644 drivers/pwm/pwm-ingenic-x1600.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c905aa13bcbc..c090512468a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12882,6 +12882,7 @@ INGENIC X1600 PWM DRIVER
 M:	Olivier Louvignes <olivier@mgcrea.io>
 S:	Maintained
 F:	Documentation/devicetree/bindings/pwm/ingenic,x1600-pwm.yaml
+F:	drivers/pwm/pwm-ingenic-x1600.c
 
 INJOINIC IP5xxx POWER BANK IC DRIVER
 M:	Samuel Holland <samuel@sholland.org>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 729776086879..244c8f4f140e 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -381,6 +381,17 @@ config PWM_JZ4740
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-jz4740.
 
+config PWM_INGENIC_X1600
+	tristate "Ingenic X1600 PWM support"
+	depends on MACH_INGENIC || COMPILE_TEST
+	depends on COMMON_CLK && OF && HAS_IOMEM
+	help
+	  Generic PWM framework driver for the PWM controller of the
+	  Ingenic X1600.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-ingenic-x1600.
+
 config PWM_KEEMBAY
 	tristate "Intel Keem Bay PWM driver"
 	depends on ARCH_KEEMBAY || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 5630a521a7cf..5c59b54e0029 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
 obj-$(CONFIG_PWM_INTEL_LGM)	+= pwm-intel-lgm.o
 obj-$(CONFIG_PWM_IPQ)		+= pwm-ipq.o
 obj-$(CONFIG_PWM_IQS620A)	+= pwm-iqs620a.o
+obj-$(CONFIG_PWM_INGENIC_X1600)	+= pwm-ingenic-x1600.o
 obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
 obj-$(CONFIG_PWM_KEEMBAY)	+= pwm-keembay.o
 obj-$(CONFIG_PWM_LOONGSON)	+= pwm-loongson.o
diff --git a/drivers/pwm/pwm-ingenic-x1600.c b/drivers/pwm/pwm-ingenic-x1600.c
new file mode 100644
index 000000000000..5865ff0cf298
--- /dev/null
+++ b/drivers/pwm/pwm-ingenic-x1600.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PWM controller of the Ingenic X1600
+ *
+ * Copyright (c) 2026 Olivier Louvignes <olivier@mgcrea.io>
+ *
+ * Eight channels, each with a power-of-two clock divider and a waveform word
+ * holding the counts at the high and at the low level; the channel's initial
+ * level picks which comes first (X1600 programming manual, chapter 13). Unlike
+ * the JZ47xx and X1000, whose PWMs are TCU timer channels (pwm-jz4740), the
+ * X1600 has this separate controller.
+ *
+ * Limitations:
+ * - The duty offset is 0 or period - duty (the high level last).
+ * - Neither count may be zero, so a duty cycle of 0 or 100% switches the
+ *   channel off and holds its output at the idle level instead.
+ * - A disabled channel drives its idle level, low.
+ * - Changing the divider or the initial level stops the channel first, which
+ *   cuts the current period short.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#define X1600_PWM_ENS			0x00	/* write 1: switch a channel on */
+#define X1600_PWM_ENC			0x04	/* write 1: switch a channel off */
+#define X1600_PWM_EN			0x08	/* the channels switched on */
+#define X1600_PWM_UPT			0x10	/* write 1: load the waveform word */
+#define X1600_PWM_BUSY			0x14	/* a load is pending */
+#define X1600_PWM_MS			0x20	/* 0: waveform word, 1: DMA */
+#define X1600_PWM_INL			0x24	/* the level a period starts with */
+#define X1600_PWM_IDL			0x28	/* the level while off */
+#define X1600_PWM_CCFG(n)		(0x40 + 4 * (n))
+#define X1600_PWM_WCFG(n)		(0x80 + 4 * (n))
+
+#define X1600_PWM_CCFG_PRESCALE		GENMASK(3, 0)	/* divide by 2^PRESCALE */
+#define X1600_PWM_WCFG_HIGH		GENMASK(31, 16)
+#define X1600_PWM_WCFG_LOW		GENMASK(15, 0)
+
+#define X1600_PWM_NUM			8
+#define X1600_PWM_MAX_COUNT		0xffff
+#define X1600_PWM_MAX_PRESCALE		7
+
+struct x1600_pwm {
+	void __iomem *base;
+	struct clk *clk;
+};
+
+struct x1600_pwm_wfhw {
+	u32 wcfg;
+	u8 prescale;
+	bool enabled;
+	bool inl;
+	bool idl;
+};
+
+static u64 x1600_pwm_counts(u64 ns, unsigned long rate, unsigned int prescale)
+{
+	return mul_u64_u64_div_u64(ns, rate, (u64)NSEC_PER_SEC << prescale);
+}
+
+static u64 x1600_pwm_ns(u64 counts, unsigned long rate, unsigned int prescale)
+{
+	return DIV64_U64_ROUND_UP((counts * NSEC_PER_SEC) << prescale, rate);
+}
+
+static int x1600_pwm_round_waveform_tohw(struct pwm_chip *chip, struct pwm_device *pwm,
+					 const struct pwm_waveform *wf, void *_wfhw)
+{
+	struct x1600_pwm *x = pwmchip_get_drvdata(chip);
+	unsigned long rate = clk_get_rate(x->clk);
+	struct x1600_pwm_wfhw *wfhw = _wfhw;
+	u64 period, high, offset;
+	unsigned int prescale;
+	int ret = 0;
+
+	*wfhw = (struct x1600_pwm_wfhw){ };
+	if (!wf->period_length_ns)
+		return 0;
+
+	if (!rate)
+		return -EINVAL;
+
+	for (prescale = 0; prescale < X1600_PWM_MAX_PRESCALE; prescale++)
+		if (x1600_pwm_counts(wf->period_length_ns, rate, prescale) <=
+		    X1600_PWM_MAX_COUNT)
+			break;
+
+	period = min(x1600_pwm_counts(wf->period_length_ns, rate, prescale),
+		     X1600_PWM_MAX_COUNT);
+	if (period < 2) {
+		period = 2;
+		ret = 1;
+	}
+	high = min(x1600_pwm_counts(wf->duty_length_ns, rate, prescale), period);
+	offset = x1600_pwm_counts(wf->duty_offset_ns, rate, prescale);
+
+	wfhw->prescale = prescale;
+	wfhw->wcfg = FIELD_PREP(X1600_PWM_WCFG_HIGH, high) |
+		     FIELD_PREP(X1600_PWM_WCFG_LOW, period - high);
+	wfhw->enabled = high && high < period;
+	/* Low first only if the requested offset reaches period - duty. */
+	wfhw->inl = !wfhw->enabled || offset < period - high;
+	wfhw->idl = high == period;
+
+	return ret;
+}
+
+static int x1600_pwm_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_device *pwm,
+					   const void *_wfhw, struct pwm_waveform *wf)
+{
+	struct x1600_pwm *x = pwmchip_get_drvdata(chip);
+	unsigned long rate = clk_get_rate(x->clk);
+	const struct x1600_pwm_wfhw *wfhw = _wfhw;
+	u32 high = FIELD_GET(X1600_PWM_WCFG_HIGH, wfhw->wcfg);
+	u32 low = FIELD_GET(X1600_PWM_WCFG_LOW, wfhw->wcfg);
+
+	*wf = (struct pwm_waveform){ };
+
+	/*
+	 * A channel that is off drives its idle level. Both counts set means
+	 * it was stopped with a waveform still loaded: it is off. One count
+	 * zero is how 0 and 100% are written, and the idle level says which.
+	 */
+	if (!wfhw->enabled && high && low)
+		return 0;
+
+	if (!rate)
+		return -EINVAL;
+
+	wf->period_length_ns = x1600_pwm_ns(high + low, rate, wfhw->prescale);
+	if (!wfhw->enabled) {
+		wf->duty_length_ns = wfhw->idl ? wf->period_length_ns : 0;
+		return 0;
+	}
+
+	wf->duty_length_ns = x1600_pwm_ns(high, rate, wfhw->prescale);
+	wf->duty_offset_ns = wfhw->inl ? 0 : x1600_pwm_ns(low, rate, wfhw->prescale);
+
+	return 0;
+}
+
+static int x1600_pwm_read_waveform(struct pwm_chip *chip, struct pwm_device *pwm,
+				   void *_wfhw)
+{
+	struct x1600_pwm *x = pwmchip_get_drvdata(chip);
+	struct x1600_pwm_wfhw *wfhw = _wfhw;
+	unsigned int ch = pwm->hwpwm;
+
+	wfhw->enabled = readl(x->base + X1600_PWM_EN) & BIT(ch);
+	wfhw->inl = readl(x->base + X1600_PWM_INL) & BIT(ch);
+	wfhw->idl = readl(x->base + X1600_PWM_IDL) & BIT(ch);
+	wfhw->prescale = FIELD_GET(X1600_PWM_CCFG_PRESCALE,
+				   readl(x->base + X1600_PWM_CCFG(ch)));
+	wfhw->wcfg = readl(x->base + X1600_PWM_WCFG(ch));
+
+	return 0;
+}
+
+static void x1600_pwm_set_bit(struct x1600_pwm *x, unsigned int reg,
+			      unsigned int ch, bool set)
+{
+	u32 val = readl(x->base + reg);
+
+	if (set)
+		val |= BIT(ch);
+	else
+		val &= ~BIT(ch);
+	writel(val, x->base + reg);
+}
+
+static int x1600_pwm_write_waveform(struct pwm_chip *chip, struct pwm_device *pwm,
+				    const void *_wfhw)
+{
+	struct x1600_pwm *x = pwmchip_get_drvdata(chip);
+	const struct x1600_pwm_wfhw *wfhw = _wfhw;
+	unsigned long rate = clk_get_rate(x->clk);
+	struct x1600_pwm_wfhw cur;
+	unsigned int ch = pwm->hwpwm;
+	u32 busy;
+
+	if (!rate)
+		return -EINVAL;
+
+	x1600_pwm_read_waveform(chip, pwm, &cur);
+
+	/*
+	 * Running with the same divider and initial level: load the new word,
+	 * which the channel takes at the end of its period.
+	 */
+	if (cur.enabled && wfhw->enabled && cur.prescale == wfhw->prescale &&
+	    cur.inl == wfhw->inl) {
+		writel(wfhw->wcfg, x->base + X1600_PWM_WCFG(ch));
+		writel(BIT(ch), x->base + X1600_PWM_UPT);
+		return readl_poll_timeout(x->base + X1600_PWM_BUSY, busy,
+					  !(busy & BIT(ch)), 10,
+					  DIV_ROUND_UP_ULL(2ULL * USEC_PER_SEC *
+							   (X1600_PWM_MAX_COUNT << cur.prescale),
+							   rate));
+	}
+
+	/* The idle level first, so that stopping holds the right level. */
+	x1600_pwm_set_bit(x, X1600_PWM_IDL, ch, wfhw->idl);
+	if (cur.enabled)
+		writel(BIT(ch), x->base + X1600_PWM_ENC);
+
+	/* The prescaler only changes while the channel is off. */
+	writel(FIELD_PREP(X1600_PWM_CCFG_PRESCALE, wfhw->prescale),
+	       x->base + X1600_PWM_CCFG(ch));
+	x1600_pwm_set_bit(x, X1600_PWM_INL, ch, wfhw->inl);
+	writel(wfhw->wcfg, x->base + X1600_PWM_WCFG(ch));
+	x1600_pwm_set_bit(x, X1600_PWM_MS, ch, false);
+
+	if (wfhw->enabled)
+		writel(BIT(ch), x->base + X1600_PWM_ENS);
+
+	return 0;
+}
+
+static const struct pwm_ops x1600_pwm_ops = {
+	.sizeof_wfhw = sizeof(struct x1600_pwm_wfhw),
+	.round_waveform_tohw = x1600_pwm_round_waveform_tohw,
+	.round_waveform_fromhw = x1600_pwm_round_waveform_fromhw,
+	.read_waveform = x1600_pwm_read_waveform,
+	.write_waveform = x1600_pwm_write_waveform,
+};
+
+static int x1600_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
+	struct x1600_pwm *x;
+
+	chip = devm_pwmchip_alloc(dev, X1600_PWM_NUM, sizeof(*x));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	x = pwmchip_get_drvdata(chip);
+
+	x->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(x->base))
+		return PTR_ERR(x->base);
+
+	x->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(x->clk))
+		return dev_err_probe(dev, PTR_ERR(x->clk), "Unable to get clock\n");
+
+	chip->ops = &x1600_pwm_ops;
+	return devm_pwmchip_add(dev, chip);
+}
+
+static const struct of_device_id x1600_pwm_of_match[] = {
+	{ .compatible = "ingenic,x1600-pwm" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, x1600_pwm_of_match);
+
+static struct platform_driver x1600_pwm_driver = {
+	.driver = {
+		.name = "ingenic-x1600-pwm",
+		.of_match_table = x1600_pwm_of_match,
+	},
+	.probe = x1600_pwm_probe,
+};
+module_platform_driver(x1600_pwm_driver);
+
+MODULE_AUTHOR("Olivier Louvignes <olivier@mgcrea.io>");
+MODULE_DESCRIPTION("Ingenic X1600 PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5


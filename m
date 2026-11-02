Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650485;
	b=CkwdxZGr5HasOHfjll2p4nqIB8kK3e0Cmb1GIfHcBpQ71nSGSeFiT+MLPkeAbs1d+3rh
	 LQ8Ttkxt+zAy3Aw6rVflDse4Nuk24JO7voPak95PTjmwMzEhtp60K1olWhF6ZQWb3XhT4
	 OPcIkeYXavxUYMd7ZqCw7boUXKT6HVl/nYD45Ckh/MJPzFCLa13S+ADsR4USsvRt2InHA
	 0xIgjFHAQL9sqcZ8BXt2eXJqAl9iV+sOxBuxS1PpEDSk75wNjwnpmAKh5gLFyRIg+T6U2
	 Spt7Y+mCS5gUzpTZN5g3wJKEPPA5ceRYn07KGrRBcYrylUqWwls6f1D5+uy8a9GLpyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FrzZUUjmSb0UwFew5M9bmNoE5V/vsksNWSR2i1xT9hk=;
	b=W+gr+/43tAUquMwAxWOetizZdaf4tZ56cqHDgPCJrERKZzZiB9+yO1Up/q6UGxgc63QN
	 Vad1r7cOOAW6ewCGuPl8hGlAuTQSC63MKb7ZlZbQfGTnLWmMMQZwuLAYpWvLktYFMMsKW
	 OkuVvZj2LgflpULO5nCtBvYreKW74klMzNymoXKWOJcsoQBeNynq5Upp1nXAhF6lrdNBt
	 SssKdqTpIaBFr48N0pdjjFvRxqMXzKh5A2bD0Y6mZMmRHjTnAZdULAvvh+x7lbfXA2pKd
	 mLWCoJu0F6/B9Ays1xZQwY6XYs+f2XJtxXm7lyWEBlhXa+wDdSCLfW4xuDYfFnKurRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=l5kOQO+Y;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E33C606D80B
	for <linux-pwm@vger.kernel.org>; Mon,  2 Nov 2026 20:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E33C606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=l5kOQO+Y
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so38942905e9.2
        for <linux-pwm@vger.kernel.org>; Mon, 02 Nov 2026 12:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20260707.gappssmtp.com; s=20260707; t=1793650482; x=1794255282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FrzZUUjmSb0UwFew5M9bmNoE5V/vsksNWSR2i1xT9hk=;
        b=l5kOQO+YOnKBZz48Qwd2VRKsuV4/XQF7EqT3eqlQmZLw7yWWeyY15huU2SimyFRMry
         e4+pLwD9/yjQ3Q6qiBxKhAajejON2sMyH9Wsl1oi0Hu6P4N/TdTlXIu+iv+54eAdHrB1
         AOk1ZiDw7zMt4aG4CNP426F2x5dbuTEn2wrodT/hmUgbsoCy7w0z6Qf2ZO5/p9r7YATY
         1aEi5fIwADVhZyXjVyBbZUi2BrS4GVzh+uLAQLb7L/3CQYUfbhHkkKQKTWj+dLSM6C2f
         8dIBFWqxk30FjWLTfz4ia8KVeDxiqdhJhuke7wdJnEykkkimUPBs7bOW0efNuSW0S9I4
         RJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793650482; x=1794255282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FrzZUUjmSb0UwFew5M9bmNoE5V/vsksNWSR2i1xT9hk=;
        b=eqYM+2sfTgUDkdLa05xs4vNEDL1SIqij/w4c2oh7XDO0AdHpssjf0HZ06XSgzGT57b
         wPmIOfy9w4mRLS0VoQ5iDncpyxYm83k+QXv+VMCBdCeV+Iw+gVGzDOi5XRNDInFJUbs1
         FLL88+abomLzHo0eOLnbMZqxuuU+8oW+PCEt7Oqg4jthhc78VILsueVZI1VQPbgvkT52
         DjurL08hI/gCj1l2uF02+9n641iUAOo+4rK49KjYCQNiyZxLeUUfItUfv3suEbysVFBW
         m+3/unIbzuPD/cHNBA8lNnVnaZ4fBzHXXzmyrSOm/P9FoSwoQhtlRbkAwWGGJbD6U4oR
         MegQ==
X-Forwarded-Encrypted: i=1; AKwUvBymOEFCWGxbDK8zsVGiyfXelmxS/4RBKblCsVWASBchDEf1EAdl4Q6K2WMW/Ypfl2u9Iu7TBSATn1I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLmnDl/KXBcEHuNECAuUX8G0cLZkSwK8kWUmDUr2fOlKmnx+6Hj
	LygSD9HdiOpheIVWUA21t5h2Qa2XOvdRHwAlWjiCz18XMZIMBRtKpu5DIoWEOxaQ/sk=
X-Gm-Gg: AYBFou2kRdMM0d8Ek2RpP3ZEcVFE2N9a6T49G4PuzqFfxsEDa2bNEkbQsPKsh5HXczM
	S2UbK48vImvmSfvbIq9FpJUsT1Bo/Vbf770o2BXQnx3K6Qp2yqPVsYICA2HtWJc2jc87yeZ35BV
	lmakLs2Mgckk0fzZkuks330DM0Eq3vS9F+l4S3aZs8ngBiupRMbBPTbEqAAcelgeoStMJfirs/h
	vGb9A0hDjcC1uaaCrZOYkiY/GHxvx/4GxVPOUQM+tozAyOVrlWDLDbFqlf04EHTC+FNd3vFVc9b
	8PucU+SAM5Q/sQF45wB2/zf23LGyCPD2GnTDCdJ0dPnFu076T7y2qjKdPNVmXX4F3KIR8NDCeQE
	NDDcRPZ5UMY4cQBP1b2Rw/hd6iHLKz9M7s4wR1+WBzXVbdGFtQwOGpN8BJe/ZKlnLeLX9yjz9+s
	Ah0foE8u7Ac2451rhc6OHRZcg5KyP4dr3W3/8aRarzxiIb4N+vheDxIWvn/nrERf/JMI6OdJkVE
	1KuNAQfAejNhdUlDdmx8HP1muz2nYva/I/+3txna8MlCan4IESA9h/Mhv6cnfOF1gVQvLFMISAt
	9Qa7hCcWA4b8X3BoEIGoYKhw5FaQMHIWi3kaSaH/WgblFAkCIuvuOI2aC9+uN393Fv3TeR904h0
	0ziYbWQ==
X-Received: by 2002:a05:600c:1d28:b0:4a2:1612:637a with SMTP id 5b1f17b1804b1-4ac1793fb6bmr309859715e9.16.1793650482499;
        Mon, 02 Nov 2026 12:14:42 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:6412:7406:ded:3229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a8d60bc5sm9559305e9.8.2026.11.02.12.14.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 12:14:42 -0800 (PST)
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
Subject: [PATCH v3 2/2] pwm: Add a driver for the Ingenic X1600 PWM controller
Date: Mon,  2 Nov 2026 21:13:25 +0100
Message-ID: <20261102201325.29507-3-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102201325.29507-1-olivier@mgcrea.io>
References: <20261102201325.29507-1-olivier@mgcrea.io>
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

The driver implements the waveform callbacks. A new word and initial
level go through the update register, which loads them at the end of the
running period, or when the channel starts; a load requested while one is
pending replaces it, so nothing waits and the chip is atomic. The manual
sets the divider before a channel is enabled, and on the R1 a divider
written to a running channel takes effect at once, so changing it changes
the length of the period then running.

Tested on a HiBy R1, whose backlight is channel 0.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
v3: the changes are listed in the cover letter.

 MAINTAINERS                     |   1 +
 drivers/pwm/Kconfig             |  11 ++
 drivers/pwm/Makefile            |   1 +
 drivers/pwm/pwm-ingenic-x1600.c | 289 ++++++++++++++++++++++++++++++++
 4 files changed, 302 insertions(+)
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
index 729776086879..d3bf11b94c43 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -336,6 +336,17 @@ config PWM_IMX_TPM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-imx-tpm.
 
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
 config PWM_INTEL_LGM
 	tristate "Intel LGM PWM support"
 	depends on HAS_IOMEM
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 5630a521a7cf..4b1a1784692a 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
 obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
 obj-$(CONFIG_PWM_IMX27)		+= pwm-imx27.o
 obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
+obj-$(CONFIG_PWM_INGENIC_X1600)	+= pwm-ingenic-x1600.o
 obj-$(CONFIG_PWM_INTEL_LGM)	+= pwm-intel-lgm.o
 obj-$(CONFIG_PWM_IPQ)		+= pwm-ipq.o
 obj-$(CONFIG_PWM_IQS620A)	+= pwm-iqs620a.o
diff --git a/drivers/pwm/pwm-ingenic-x1600.c b/drivers/pwm/pwm-ingenic-x1600.c
new file mode 100644
index 000000000000..1855e0cb1a56
--- /dev/null
+++ b/drivers/pwm/pwm-ingenic-x1600.c
@@ -0,0 +1,289 @@
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
+ * Reference manual:
+ * https://github.com/Ingenic-community/datasheets/blob/main/X/X1600_PM_20220117.pdf
+ *
+ * Limitations:
+ * - The duty offset is 0 or period - duty (the high level last).
+ * - Neither count may be zero, so for a duty cycle of 0 or 100% the channel
+ *   is switched off, its output held low or high by its idle level.
+ * - A disabled channel finishes its period, then drives its idle level, low.
+ * - A new divider takes effect at once, so the period then running ends at
+ *   the new rate; the other settings take effect when that period ends.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#define X1600_PWM_ENS			0x00	/* write 1: switch a channel on */
+#define X1600_PWM_ENC			0x04	/* write 1: switch a channel off */
+#define X1600_PWM_EN			0x08	/* the channels switched on */
+#define X1600_PWM_UPT			0x10	/* write 1: load the word at period end */
+#define X1600_PWM_BUSY			0x14	/* a load is pending */
+#define X1600_PWM_MS			0x20	/* 0: waveform word, 1: DMA */
+#define X1600_PWM_INL			0x24	/* a period's first level, taken at load */
+#define X1600_PWM_IDL			0x28	/* the level while off */
+#define X1600_PWM_CCFG(n)		(0x40 + 4 * (n))
+#define X1600_PWM_WCFG(n)		(0x80 + 4 * (n))
+
+#define X1600_PWM_CCFG_PRESCALE		GENMASK(3, 0)	/* divide by 2^PRESCALE */
+#define X1600_PWM_WCFG_HIGH		GENMASK(31, 16)
+#define X1600_PWM_WCFG_LOW		GENMASK(15, 0)
+
+#define X1600_PWM_NUM			8
+/* The period's count, so that each of HIGH and LOW fits too. */
+#define X1600_PWM_MAX_COUNT		FIELD_MAX(X1600_PWM_WCFG_LOW)
+/* PRESCALE is four bits wide, but its values from 8 up are reserved. */
+#define X1600_PWM_MAX_PRESCALE		7
+
+struct x1600_pwm {
+	void __iomem *base;
+	unsigned long rate;
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
+/* Counts of the undivided clock, which runs at most at NSEC_PER_SEC. */
+static u64 x1600_pwm_counts(u64 ns, unsigned long rate)
+{
+	return mul_u64_u64_div_u64(ns, rate, NSEC_PER_SEC);
+}
+
+/*
+ * counts is HIGH + LOW, at most 2 * 0xffff (17 bits), and prescale at most 15
+ * (the field's width), so (counts * NSEC_PER_SEC) << prescale stays below 2^62.
+ */
+static u64 x1600_pwm_ns(u64 counts, unsigned long rate, unsigned int prescale)
+{
+	return DIV64_U64_ROUND_UP((counts * NSEC_PER_SEC) << prescale, rate);
+}
+
+static int x1600_pwm_round_waveform_tohw(struct pwm_chip *chip, struct pwm_device *pwm,
+					 const struct pwm_waveform *wf, void *_wfhw)
+{
+	struct x1600_pwm *x = pwmchip_get_drvdata(chip);
+	struct x1600_pwm_wfhw *wfhw = _wfhw;
+	u64 period, high, offset;
+	unsigned int prescale;
+	int ret = 0;
+
+	*wfhw = (struct x1600_pwm_wfhw){ };
+	if (!wf->period_length_ns)
+		return 0;
+
+	/* The smallest divider that brings the period within the counter. */
+	period = x1600_pwm_counts(wf->period_length_ns, x->rate);
+	prescale = min(fls64(period / (X1600_PWM_MAX_COUNT + 1)),
+		       X1600_PWM_MAX_PRESCALE);
+	period = min(period >> prescale, X1600_PWM_MAX_COUNT);
+	if (period < 2) {
+		period = 2;
+		ret = 1;
+	}
+	high = min(x1600_pwm_counts(wf->duty_length_ns, x->rate) >> prescale, period);
+	offset = x1600_pwm_counts(wf->duty_offset_ns, x->rate) >> prescale;
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
+	const struct x1600_pwm_wfhw *wfhw = _wfhw;
+	u32 high = FIELD_GET(X1600_PWM_WCFG_HIGH, wfhw->wcfg);
+	u32 low = FIELD_GET(X1600_PWM_WCFG_LOW, wfhw->wcfg);
+
+	*wf = (struct pwm_waveform){ };
+
+	/* Cleared counts: the channel was disabled, or never set up. */
+	if (!high && !low)
+		return 0;
+
+	wf->period_length_ns = x1600_pwm_ns(high + low, x->rate, wfhw->prescale);
+
+	/*
+	 * A channel that is off holds its idle level for as long as it is off:
+	 * a duty cycle of 0 or 100% over the period its counts give. INL plays
+	 * no part, it only sets the level a running period starts with.
+	 */
+	if (!wfhw->enabled) {
+		wf->duty_length_ns = wfhw->idl ? wf->period_length_ns : 0;
+		return 0;
+	}
+
+	wf->duty_length_ns = x1600_pwm_ns(high, x->rate, wfhw->prescale);
+	wf->duty_offset_ns = wfhw->inl ? 0 : x1600_pwm_ns(low, x->rate, wfhw->prescale);
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
+	unsigned int ch = pwm->hwpwm;
+	bool enabled = readl(x->base + X1600_PWM_EN) & BIT(ch);
+
+	/* The idle level only shows once the channel is off. */
+	x1600_pwm_set_bit(x, X1600_PWM_IDL, ch, wfhw->idl);
+
+	/*
+	 * Switched off, the channel finishes its period, then holds its idle
+	 * level. The rest is written all the same, to be read back.
+	 */
+	if (enabled && !wfhw->enabled)
+		writel(BIT(ch), x->base + X1600_PWM_ENC);
+
+	/* The divider takes effect at once, even in the middle of a period. */
+	writel(FIELD_PREP(X1600_PWM_CCFG_PRESCALE, wfhw->prescale),
+	       x->base + X1600_PWM_CCFG(ch));
+
+	/*
+	 * The initial level and the word are loaded together, at the end of
+	 * the period running or when the channel starts. A load requested
+	 * while one is pending replaces it, so there is nothing to wait for.
+	 */
+	x1600_pwm_set_bit(x, X1600_PWM_INL, ch, wfhw->inl);
+	writel(wfhw->wcfg, x->base + X1600_PWM_WCFG(ch));
+	if (!wfhw->enabled)
+		return 0;
+	writel(BIT(ch), x->base + X1600_PWM_UPT);
+
+	/*
+	 * A channel just switched off still runs until its period ends, and
+	 * reads as off: switched on again, it takes the word loaded above.
+	 */
+	if (!enabled) {
+		x1600_pwm_set_bit(x, X1600_PWM_MS, ch, false);
+		writel(BIT(ch), x->base + X1600_PWM_ENS);
+	}
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
+	struct clk *clk;
+	int ret;
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
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Unable to get clock\n");
+
+	ret = devm_clk_rate_exclusive_get(dev, clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to get exclusive rate\n");
+
+	x->rate = clk_get_rate(clk);
+	if (!x->rate || x->rate > NSEC_PER_SEC)
+		return dev_err_probe(dev, -EINVAL, "Invalid clock rate: %lu\n", x->rate);
+
+	chip->ops = &x1600_pwm_ops;
+	chip->atomic = true;
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
2.54.0


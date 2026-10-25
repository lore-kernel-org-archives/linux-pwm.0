Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792918008;
	b=UjkizQj2A/IZcDWCJA17gR4fK0TDDFYXxMfB5MWgLgrteEQkuiM1oOuGEtXFKcqQBnh7
	 17DLo8Y+ICUZ0+OytUNgKddw6SIg5GKv2U7LuBkJEh7pR7+VZizUqZbCr0sOA5DPvc8VE
	 cDhmckVciGSSK8SLuDSEqtA+vH1d3TpdHWRZgrTfJO8pCDN8aYLwaXlJX6rTPye1VT5an
	 VneyP42hm9aP/yz9JNnDvNWMNbr7nJ8OmP9HCFtGM71Uffw32pY8JiV5s8ZOrVS5S6kaV
	 GR4Ah3aLvlCBvj/c/WGCbv3KeTOlS6egmsY2nnKZ9sqcB4KKLt9++oHrLL7wytQH0tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792918008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LKxOIc+Os/5OwZrKosD6IK2IejYrwsOHb9VwGtXoqJM=;
	b=tew7wREC5xX5VcAxCREK87sO92afjAbApfbK4g0U0+N9JJsCgCuujQnXQcMWK3v/y0Cp
	 XoR/8FQifhTZ5QCL/0rQV2+sLAa5DpdVOhY0L4QNEk+/guuZFJnyd0Kk5OivYCcYVbWBq
	 5vX2DD07L5x4CJlCDm1s0xK5IcjM9EGYZ1NK8X7ofAKCHkVH6KPo+tjZy7V18SA2pLM4Q
	 FJNZGSapK7NuKRhg/gwIv0PyPGm3mWWAoz2lsRkj28KnaItJVsRvRnPGaFibi4uZx+3d2
	 NoRzgRMZ9JIcnnMoL912aBEmc6W+q773l054TmzflPZCd5PEVQl9I+/494kbRlPeI+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Dfbc78Su;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FBA606A330
	for <linux-pwm@vger.kernel.org>; Sun, 25 Oct 2026 08:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07FBA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Dfbc78Su
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so1248252f8f.0
        for <linux-pwm@vger.kernel.org>; Sun, 25 Oct 2026 01:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792918006; x=1793522806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LKxOIc+Os/5OwZrKosD6IK2IejYrwsOHb9VwGtXoqJM=;
        b=Dfbc78Su2mChKaGgA74zsFH18zKAwp+ElKEKGXUsL/hCluwwk2ZQQKTb9lKvD7+Rkj
         xhRZshHb8SXYQUDKnuguFk8FPKQMb1DyVexyBIhV1nx8VXlZSAstZuVYg68f/qxF+hpE
         PuwRqqzdNeIOVGQ4mjBAC+xbSUrcAZAWfKKSeKTk3vm/dC0YznGHmyjWoW3axWcKVboa
         QRjq+TDP+ceVcuf5BMsKVgHS8t7dl0NKjObWkWXGaVgH469552UXSkWxsQpat4TsmGKu
         Mgo2Jy105xhhKq4qG/psz9vIMjgOWR4yUtiJCSbiDjTE+2u8hEXQQ93jzsO93HSfiWwi
         /FoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792918006; x=1793522806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LKxOIc+Os/5OwZrKosD6IK2IejYrwsOHb9VwGtXoqJM=;
        b=k5ttGmvES4qBeejRMGWB1DPn89subhfotBjKhZpCwGluuyjs7czGbGVWISVLvKoy9J
         D9FUQvxP4mM4A0embCjS4/uASteXwtOiw1yPHZBjUwYL5gqwpf/3UQi1TlNtdbdFQNCo
         OT4gclOGxuw16RGqCOe2httIKUvTT1B8pHwukWKF9hTzjqQJUOfGalREOtn+x9E1jd/i
         uixvmAuVPc1ITnxc5DjFt9CzJJEzkP3wP96nmdRaKYJAFqM/6LV4+ezTkTimEEtCTSmc
         MTpPkxdNdbNwUB7Oc9WCCv+2s0d3eMBd4d/h9K2NwCX7d6W3ZsFZS1ZU7Z8N9KvdpET0
         mM3w==
X-Forwarded-Encrypted: i=1; AKwUvBzwwBEZvRyXsQYTKUKeMAsQiGMYXjUTTBbQlz3PUtUbE8P237GWNVJM7VZhzeY+eBmiuMtDymR1OlE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKz/WPzTOFyCtXmRfX3tKpjNfQ++hjudZYfYf9lxdWEdm8eQK6+
	J0l6GDwigsqxKqox1cp7WzDV6D5MChdMHIcMPJqE2YKc1JCT/dlt4av70xIHA30Bs1o=
X-Gm-Gg: AYBFou1FvK5AKkS3WHWCU3frea9WqBcNzBB/b0TeIrBzV07uTty0dF35BOoAXLgDdTm
	5cQJbUqT0zdPWjJOctjXEtT5yekQdQr653t3fZOMQt6MB9QF+zy2ajD17AOFfBqUTHFtnYIX0BP
	6MFbAmgi9iHRBrurNtt/GHnxgUowTO5eqM+5bUBM3obl+9dyrsa2d1/eRJ47v98x65K5Ju6Jo8/
	y5NeV1XnwA6GKvEBr+VYAKe2B+M671Q9KvJVVB0CTmf2rY5WHub4SW6UQm2huYGicdxSyMRF/rP
	f5NCz3Wkv1R3paYkaXjbpvwZy6ANT6jTd+xrBBVbbpshD9z7M59FpUyJfowsLTMdOqtXA4r5hlA
	b+nAF1rqmAQqfIo2LFKrIfUqbxubb+ilY+1eZnMVm3DlH4D+J4TSKa2LO2xogxcz7KVfntN+Ezm
	Sznjc1oUY0FWzjhV+qwCmx85szN+OFz9Z0SK0Qsi9UfRT162uMhf91N/kVtbBRHduT5nsIeoRNg
	VRHaUWBKoKHAk5k9vu5ujeGVfJnRHYdmuGV2ghyfQGCE7zSFRjzaPGj6xholkrITGiHblBRmzEQ
	/yeSDNqaJZGqVf3LSF1VdLDdp7MBoBcOqsN66RXQEEia0FTuPkmP9V/bLbDM30zYuP5bUcIflA=
	=
X-Received: by 2002:a05:6000:2511:b0:48e:850:c0b7 with SMTP id ffacd0b85a97d-48e3ebd0c47mr6904966f8f.1.1792918006361;
        Sun, 25 Oct 2026 01:46:46 -0700 (PDT)
Received: from localhost.localdomain (2a01cb060184ad00bcfbae5efa3e0f0b.ipv6.abo.wanadoo.fr. [2a01:cb06:184:ad00:bcfb:ae5e:fa3e:f0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb99esm8616707f8f.23.2026.10.25.01.46.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Oct 2026 01:46:45 -0700 (PDT)
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
Subject: [PATCH 2/2] pwm: Add a driver for the Ingenic X1600 PWM controller
Date: Sun, 25 Oct 2026 09:46:43 +0100
Message-ID: <20261025084643.93167-3-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261025084643.93167-1-olivier@mgcrea.io>
References: <20261025084643.93167-1-olivier@mgcrea.io>
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
 MAINTAINERS                     |   1 +
 drivers/pwm/Kconfig             |  11 ++
 drivers/pwm/Makefile            |   1 +
 drivers/pwm/pwm-ingenic-x1600.c | 260 ++++++++++++++++++++++++++++++++
 4 files changed, 273 insertions(+)
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
index 000000000000..83a8d5eec6bf
--- /dev/null
+++ b/drivers/pwm/pwm-ingenic-x1600.c
@@ -0,0 +1,260 @@
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
+	if (!rate)
+		return -EINVAL;
+
+	wf->period_length_ns = x1600_pwm_ns(high + low, rate, wfhw->prescale);
+	wf->duty_length_ns = x1600_pwm_ns(high, rate, wfhw->prescale);
+	wf->duty_offset_ns = wfhw->enabled && !wfhw->inl ?
+			     x1600_pwm_ns(low, rate, wfhw->prescale) : 0;
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
2.54.0


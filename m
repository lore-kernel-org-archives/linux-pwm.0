Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820309;
	b=SlMcoG4Cs630f6wc0CAV++cGGe0LJBRMwi+FJBxCTclwtb5izOe6mgpKOG2Yx+LhX66y
	 8PKRSHkOov8s928iVhFvX7jeTiLp4bw7LeopNdKYo1+1gJcl1T4UqeWEClE58oFDt+I2h
	 C2bGewKOQbzsfa8ocjYGeLgEHr3P4K+O/oHlqxHb3v0ygmzW6Z+Z8QpIyDOzuIvc/pOF8
	 rtcBRJPck/jmtGaL+AndHm43gzNcEZAB7wcXFAFtmTHJyrzs2gG/SQAwW5PjwQp38Ra6k
	 x1VLMYsu++MnHw3he7b02vFkLYY2JhYBh7YYhRpINE2S7AAp2N25Ar+0ozFKP16jMzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=W9WQdjXi6TY9dJIm31sodN+zbfnNOMbsy6mb4cShhQ4=;
	b=wtBdfi8u4yYu6zI/RPFKQcLN7phALFkRoCVB/YDVs1XIqlU8nP1+pJ8xpWx8wx0wpSib
	 HVNhbloxPtEPjbvLrk9lqQFE6SP8qqMuXxd3Ouz3aOH9COWpxu3Vt2Ry76FUuSdW583kX
	 GTI8SX09ULZgeJVOlwlbm+5jtIQiMfg5H1YuQ/svHyHd100YPPjpCExp0hONTZeDGlIIK
	 u0e+2e4aTZBV4g3yjS7TrRoP4k/Auk4d4PCHjCq40npJaP4U/pbe5TAQYMMMmlu+Hz7Dd
	 r9yJnrVBiEW2HQAHYiq4qdApveCEI3j2cq266OjIyunX/kJkPT4hBw12FByjA7Sg2IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bKr737Tm;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FEB607F2A2
	for <linux-pwm@vger.kernel.org>; Wed,  4 Nov 2026 19:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9FEB607F2A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bKr737Tm
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-85c1135c286so674514a34.1
        for <linux-pwm@vger.kernel.org>; Wed, 04 Nov 2026 11:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793820308; x=1794425108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W9WQdjXi6TY9dJIm31sodN+zbfnNOMbsy6mb4cShhQ4=;
        b=bKr737TmCqxrzhuIbyYM5k+M6Y6cBTNhWNMxZRVGJlCl4IU0bd5uk4Z7o0TwElQOHM
         hn2OR+0MUL3qIfBnoi480ImqpYWSgltFfwJ8qHj1xWirRj2BTKLtSSXJjAGF4POhihX7
         wDdsDIM2Zx813QmA7fUTW4f4Jf5HwUruYXVloDcoYqTQd175dVTqaCJFFnN+8JcFJfis
         tNnT3CoHlzZ8cn7rBsZ7RKSPVhijC82lpwh+503zP81eccI/3+TG9SYa5Lw2K8zbYhP9
         xV2S8LMaxYUAtsqY/kJgMDzT30K6tEFJEKeSI9RcvS93ZvjnMRzSr/psJ51BZxC8iaZf
         KcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793820308; x=1794425108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W9WQdjXi6TY9dJIm31sodN+zbfnNOMbsy6mb4cShhQ4=;
        b=HOz1Y9vAMgmvWYTjryMmq9W7wjCkQhnuqf6z85hzjdpff4SzHPyS9A9mk9W3fTMi88
         YdjvRAG5+X7iWM6uUDDh3QwbgERUs7X9jvz/jcRX6SmuhdCmbdEC/vJsrdau1tUnC4bs
         hISgAgwmNJQ/AWqkAzKg+BLJxGmJmsFxhIZdy1fWcDCGdWDbW0wWx2bPs3b3bM4ZufU8
         7ntetKSNRoYadw6o907I6+JcBMJNtqDLQBKCjw1Q481xVEgU2RH+hep9FIbmbjPcD84J
         5tB3phv5r/9Mnr9WkmGlbILsmNt2tzlivZTmdpTLQHL9a9EkY4K1ZQhZ7VqEriLuPqHp
         tVoA==
X-Forwarded-Encrypted: i=1; AKwUvBzH18xlvAHyhoA0VbychtyAOKcHz3nvuuDuDYg0AE9WZ0zA+lGIMbQGqNK4L2vUnD5iXfIkgH9Ggm0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lEYD+4hAunWDWdKiegm7RH3XSV4+Lu4y3055Tgor8Fq0F+Ccc
	m7GULwgzgBKAB134mIBPktn1czX4S7NH6HtyHdwXApSsHydGp+zj0vg0
X-Gm-Gg: AYBFou0AbpVc4fxBHqJzVuH/ovjzF/T9zN/O3is/kZD+9zaVbHS8dV1uMpBMLijIE4h
	UelbaUXDS1NYczDk4nGRrkJyXX1WKKkZY4sAdjcNsSjZQOOIum29hGXPVjHl0Aa+/hwvjXkxqKe
	s5BwYNUoqs+bOp7qsIlvstwpTEyyVqgoFcvAsfS2Uy+Asb67yuq0iWhpAOfIG3bVywEuZRGhq10
	HK/1I5abJS93jjL9jsdh5rTgnAPEnyDDKkaZswqLk+7UK0OBGnDrZqcDdHL+vEozvC9U/GF3VJz
	TmsdVvpm0e9+6HljyMQJ4GNNrAnm9lT1ebTC7gXq23JcxsZNnqQU3L2MhnScQUxMlfd8fMtzrmS
	OPAnIJDJlQkNMwJN7TqDrz5esorKsNmATKHSgcrZu+n0K+PvD6ds93wSJzXYcQ750Jb7zNRnasr
	reYrbwt40VKPqEI4vrD7MZHMjhOMlDbl8Gm+PGaltppXJGMMH2e41j+Ei1+YqiIIjgjs12Q5JmR
	N0SoIWGXrjsSYhePjjfbxMOkvM4p0MkSVp3pxkGhCVTOZWF+npJUtUAOwAN3PjAi/ynf/AB0Bgv
	dbN5z7yYqNF4SV02wtDUt7AL+TMDcWi3LUrWHU58Y2/6IEjNAJ7eX1ZE56nE8LqO+WNZ1a/Urzv
	ZqaDPTbSMm9R+6r9thZtseFGm2kcECsySLmM60WL2H+K8L6NKohTC/LDrojeADbppU+WkiyUXQc
	19AyPBdCpUvli5BR5ch0DIDHFc86an/GGb3MxI8lx9l7wycua7wx9I
X-Received: by 2002:a05:6808:14ca:b0:4e8:18ee:eb4d with SMTP id 5614622812f47-5640dce42ddmr14479773b6e.20.1793820307724;
        Wed, 04 Nov 2026 11:25:07 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9c7bbcesm2328723b6e.1.2026.11.04.11.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:25:07 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 04 Nov 2026 12:24:53 -0700
Subject: [PATCH v12 3/5] pwm: sun8i: export the bypass outputs as clocks
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
Message-Id: <20261104-h616-pwm-v8-v12-3-8ed39b0dba69@gmail.com>
References: <20261104-h616-pwm-v8-v12-0-8ed39b0dba69@gmail.com>
In-Reply-To: <20261104-h616-pwm-v8-v12-0-8ed39b0dba69@gmail.com>
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

Expose each H616 PWM channel's hardware bypass as a CCF clock. Consumers
such as the co-packaged AC200/AC300 PHY need a clock rather than PWM duty
or polarity control. Keep the pair source protected for the complete
prepared lifetime, and arbitrate ownership between PWM requests and clock
prepare so both interfaces cannot drive the same output.

drivers/clk/clk-pwm.c advertises a fixed frequency without reading back the
rounded PWM rate. A 42 ns, 21 ns request does select 24 MHz bypass when it
is available. However, with the pair constrained to 100 MHz by its sibling,
the PWM rounding rules select a 40 ns, 20 ns waveform (25 MHz), while a
pwm-clock configured for 24 MHz still reports 24 MHz. The direct provider
instead reports the actual pair rate and makes its shared-rate protection
visible to CCF. Consumers must still check the rate they receive.

Use CLK_IGNORE_UNUSED to preserve unclaimed firmware bypass outputs, just
as the PWM path preserves inherited waveforms. Normal consumer disable
still turns the output off and releases its shared gate reference.

Readback also runs on unrequested channels exposed through PWM debugfs.
An exported-clock consumer can retune and enable a disabled output between
the rate query and register snapshot. Retry when the pair's notification
generation changes so the returned waveform uses a consistent rate and
register state. The CCF rate read waits for changes already in progress;
the locked generation check detects changes that start afterward.

A temporary exclusive rate hold would instead clamp concurrent clock
requests to the old rate, potentially returning success at the wrong
frequency. Keep readback non-intrusive and leave sleeping CCF calls outside
the register spinlock. PRE notifications invalidate snapshots even if a
provider failure does not produce POST_RATE_CHANGE.

Rate exclusivity protects frequency, whereas prepare/request arbitration
owns an output. An unprepared clock's rate hold therefore constrains PWM
rounding without reserving the channel. A consumer taking over an inherited
output can prepare and enable it at its current rate, then disable and
unprepare it before selecting a different rate.

Link: https://lore.kernel.org/all/sashiko-outbox-194955@kernel.org/
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
Co-developed-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/pwm/Kconfig     |   3 +-
 drivers/pwm/pwm-sun8i.c | 206 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 202 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index c7c964406da4..48dfb8a8d1e9 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -744,7 +744,8 @@ config PWM_SUN8I
 	depends on HAS_IOMEM && COMMON_CLK
 	help
 	  PWM framework driver for Allwinner controllers whose channels share
-	  paired source clocks.
+	  paired source clocks. In addition to PWM operation, each channel's
+	  hardware bypass path can be exported as a clock output.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sun8i.
diff --git a/drivers/pwm/pwm-sun8i.c b/drivers/pwm/pwm-sun8i.c
index 08d92d0da291..fa81330162bc 100644
--- a/drivers/pwm/pwm-sun8i.c
+++ b/drivers/pwm/pwm-sun8i.c
@@ -114,6 +114,9 @@
  * The bypass in PWM mode is used to achieve a 1/2 relative duty cycle with the
  * fastest clock.
  *
+ * SUN8I_PWM_clock_x/y serve for the PWM purpose.
+ * SUN8I_PWM_bypass_clock_x/y serve for the clock-provider purpose.
+ *
  */
 
 /* /div_m is a power-of-two divider limited to /256. */
@@ -130,6 +133,12 @@ static const struct clk_div_table sun8i_pwm_div_m_table[] = {
 	{ /* sentinel */ }
 };
 
+enum sun8i_pwm_mode {
+	SUN8I_PWM_MODE_NONE,
+	SUN8I_PWM_MODE_PWM,
+	SUN8I_PWM_MODE_CLK,
+};
+
 struct sun8i_pwm_chip;
 
 struct sun8i_pwm_pair {
@@ -144,8 +153,12 @@ struct sun8i_pwm_pair {
 };
 
 struct sun8i_pwm_channel {
+	struct clk_hw bypass_hw;
+	struct sun8i_pwm_chip *chip;
+	unsigned int index;
 	/* Separate CCF consumer, held only from PWM request to free. */
 	struct clk *pair_clk;
+	enum sun8i_pwm_mode mode;
 	u64 pending_period_ns;
 	bool rate_exclusive;
 };
@@ -155,7 +168,7 @@ struct sun8i_pwm_chip {
 	struct sun8i_pwm_channel channels[SUN8I_PWM_NPWM];
 	struct clk *bus_clk;
 	void __iomem *base;
-	/* Protects shared registers and rate_exclusive. */
+	/* Protects shared registers, channel ownership and rate_exclusive. */
 	spinlock_t lock;
 };
 
@@ -329,6 +342,101 @@ static int sun8i_pwm_pair_rate_notifier(struct notifier_block *nb,
 	return active ? NOTIFY_BAD : NOTIFY_OK;
 }
 
+static inline struct sun8i_pwm_channel *
+sun8i_pwm_channel_from_hw(struct clk_hw *hw)
+{
+	return container_of(hw, struct sun8i_pwm_channel, bypass_hw);
+}
+
+static int sun8i_pwm_bypass_prepare(struct clk_hw *hw)
+{
+	struct sun8i_pwm_channel *chan = sun8i_pwm_channel_from_hw(hw);
+	struct sun8i_pwm_chip *sun8i_chip = chan->chip;
+
+	guard(spinlock_irqsave)(&sun8i_chip->lock);
+	if (chan->mode != SUN8I_PWM_MODE_NONE)
+		return -EBUSY;
+
+	chan->mode = SUN8I_PWM_MODE_CLK;
+	return 0;
+}
+
+static void sun8i_pwm_bypass_unprepare(struct clk_hw *hw)
+{
+	struct sun8i_pwm_channel *chan = sun8i_pwm_channel_from_hw(hw);
+	struct sun8i_pwm_chip *sun8i_chip = chan->chip;
+
+	guard(spinlock_irqsave)(&sun8i_chip->lock);
+	if (chan->mode != SUN8I_PWM_MODE_CLK)
+		return;
+
+	chan->mode = SUN8I_PWM_MODE_NONE;
+}
+
+static int sun8i_pwm_bypass_enable(struct clk_hw *hw)
+{
+	struct sun8i_pwm_channel *chan = sun8i_pwm_channel_from_hw(hw);
+	struct sun8i_pwm_chip *sun8i_chip = chan->chip;
+	unsigned int pair = SUN8I_PWM_PAIR_IDX(chan->index);
+	u32 pccr, per;
+
+	guard(spinlock_irqsave)(&sun8i_chip->lock);
+	if (chan->mode != SUN8I_PWM_MODE_CLK)
+		return -EBUSY;
+
+	pccr = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair));
+	per = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
+	if (!(pccr & BIT(SUN8I_PWM_PCCR_BYPASS_BIT(chan->index))) ||
+	    !(per & SUN8I_PWM_ENABLE(chan->index))) {
+		sun8i_pwm_set_enabled_locked(sun8i_chip, chan->index, false);
+		sun8i_pwm_set_bypass_locked(sun8i_chip, chan->index, true);
+		sun8i_pwm_set_enabled_locked(sun8i_chip, chan->index, true);
+	}
+
+	return 0;
+}
+
+static void sun8i_pwm_bypass_disable(struct clk_hw *hw)
+{
+	struct sun8i_pwm_channel *chan = sun8i_pwm_channel_from_hw(hw);
+	struct sun8i_pwm_chip *sun8i_chip = chan->chip;
+
+	guard(spinlock_irqsave)(&sun8i_chip->lock);
+	if (chan->mode != SUN8I_PWM_MODE_CLK)
+		return;
+
+	sun8i_pwm_set_enabled_locked(sun8i_chip, chan->index, false);
+	sun8i_pwm_set_bypass_locked(sun8i_chip, chan->index, false);
+}
+
+static int sun8i_pwm_bypass_is_enabled(struct clk_hw *hw)
+{
+	struct sun8i_pwm_channel *chan = sun8i_pwm_channel_from_hw(hw);
+	struct sun8i_pwm_chip *sun8i_chip = chan->chip;
+	unsigned int pair = SUN8I_PWM_PAIR_IDX(chan->index);
+	bool enabled;
+	u32 val;
+
+	guard(spinlock_irqsave)(&sun8i_chip->lock);
+
+	val = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair));
+	enabled = (val & SUN8I_PWM_PCCR_GATE) &&
+		  (val & BIT(SUN8I_PWM_PCCR_BYPASS_BIT(chan->index)));
+
+	val = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
+	enabled = enabled && (val & SUN8I_PWM_ENABLE(chan->index));
+
+	return enabled;
+}
+
+static const struct clk_ops sun8i_pwm_bypass_ops = {
+	.prepare = sun8i_pwm_bypass_prepare,
+	.unprepare = sun8i_pwm_bypass_unprepare,
+	.enable = sun8i_pwm_bypass_enable,
+	.disable = sun8i_pwm_bypass_disable,
+	.is_enabled = sun8i_pwm_bypass_is_enabled,
+};
+
 static void sun8i_pwm_put_rate(struct sun8i_pwm_chip *sun8i_chip,
 			       unsigned int idx)
 {
@@ -355,8 +463,12 @@ static int sun8i_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	int ret;
 
 	scoped_guard(spinlock_irqsave, &sun8i_chip->lock) {
+		if (chan->mode != SUN8I_PWM_MODE_NONE)
+			return -EBUSY;
+
 		was_enabled =
 			sun8i_pwm_channel_is_enabled_locked(sun8i_chip, idx);
+		chan->mode = SUN8I_PWM_MODE_PWM;
 	}
 
 	chan->pair_clk = clk_hw_get_clk(parent, NULL);
@@ -385,6 +497,8 @@ static int sun8i_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_put(chan->pair_clk);
 err_clear_clock:
 	chan->pair_clk = NULL;
+	scoped_guard(spinlock_irqsave, &sun8i_chip->lock)
+		chan->mode = SUN8I_PWM_MODE_NONE;
 
 	return ret;
 }
@@ -395,6 +509,9 @@ static void sun8i_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct sun8i_pwm_channel *chan = &sun8i_chip->channels[pwm->hwpwm];
 
 	scoped_guard(spinlock_irqsave, &sun8i_chip->lock) {
+		if (chan->mode != SUN8I_PWM_MODE_PWM)
+			return;
+
 		sun8i_pwm_set_enabled_locked(sun8i_chip, pwm->hwpwm, false);
 		sun8i_pwm_set_bypass_locked(sun8i_chip, pwm->hwpwm, false);
 	}
@@ -403,6 +520,9 @@ static void sun8i_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable_unprepare(chan->pair_clk);
 	clk_put(chan->pair_clk);
 	chan->pair_clk = NULL;
+
+	scoped_guard(spinlock_irqsave, &sun8i_chip->lock)
+		chan->mode = SUN8I_PWM_MODE_NONE;
 }
 
 static int sun8i_pwm_read_waveform(struct pwm_chip *chip,
@@ -412,21 +532,39 @@ static int sun8i_pwm_read_waveform(struct pwm_chip *chip,
 	struct sun8i_pwm_waveform *wfhw = _wfhw;
 	struct sun8i_pwm_chip *sun8i_chip = sun8i_pwm_from_chip(chip);
 	unsigned int pair = SUN8I_PWM_PAIR_IDX(pwm->hwpwm);
+	struct clk *pair_clk = sun8i_chip->pairs[pair].hw->clk;
 	unsigned long pair_rate;
 	u32 pccr, pcr, pdzcr, per, ppr;
 
-	pair_rate = sun8i_pwm_get_pair_rate(sun8i_chip, pwm->hwpwm);
-	if (pair_rate > U32_MAX)
-		return -ERANGE;
+	/*
+	 * An unrequested channel can be retuned and enabled by a clock
+	 * consumer. Retry if its rate changed between the CCF read and the
+	 * register snapshot. A temporary exclusive hold would instead clamp
+	 * concurrent bypass-clock rate requests to the old pair rate.
+	 */
+	for (;;) {
+		unsigned int generation;
+
+		cond_resched();
+		generation = sun8i_pwm_get_rate_generation(sun8i_chip, pwm->hwpwm);
+		/* This waits for any rate change already in progress to finish. */
+		pair_rate = clk_get_rate(pair_clk);
+
+		guard(spinlock_irqsave)(&sun8i_chip->lock);
+		if (generation != sun8i_chip->pairs[pair].rate_generation)
+			continue;
 
-	scoped_guard(spinlock_irqsave, &sun8i_chip->lock) {
 		pccr = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair));
 		per = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
 		pcr = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCR(pwm->hwpwm));
 		ppr = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PPR(pwm->hwpwm));
 		pdzcr = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PDZCR(pair));
+		break;
 	}
 
+	if (pair_rate > U32_MAX)
+		return -ERANGE;
+
 	*wfhw = (struct sun8i_pwm_waveform) {
 		.enabled = !!(pccr & SUN8I_PWM_PCCR_GATE) &&
 			   !!(per & SUN8I_PWM_ENABLE(pwm->hwpwm)),
@@ -523,7 +661,8 @@ sun8i_pwm_pair_rate_constrained(struct sun8i_pwm_chip *sun8i_chip,
 	unsigned int sibling = idx ^ 1;
 
 	guard(spinlock_irqsave)(&sun8i_chip->lock);
-	return sun8i_chip->channels[sibling].rate_exclusive ||
+	return sun8i_chip->channels[sibling].mode == SUN8I_PWM_MODE_CLK ||
+	       sun8i_chip->channels[sibling].rate_exclusive ||
 	       sun8i_pwm_channel_is_enabled_locked(sun8i_chip, sibling);
 }
 
@@ -1075,6 +1214,42 @@ static int sun8i_pwm_register_pair_clocks(struct device *dev,
 	return 0;
 }
 
+/* Register the bypass clock for each channel. */
+static int sun8i_pwm_register_bypass_clocks(struct device *dev,
+					    struct sun8i_pwm_chip *sun8i_chip)
+{
+	for (unsigned int i = 0; i < SUN8I_PWM_NPWM; i++) {
+		struct sun8i_pwm_channel *chan = &sun8i_chip->channels[i];
+		struct clk_hw *parent = sun8i_chip->pairs[SUN8I_PWM_PAIR_IDX(i)].hw;
+		const char *name;
+		int ret;
+
+		name = devm_kasprintf(dev, GFP_KERNEL, "%s#pwm-bypass%u",
+				      dev_name(dev), i);
+		if (!name)
+			return -ENOMEM;
+
+		chan->chip = sun8i_chip;
+		chan->index = i;
+		/*
+		 * Protect the shared rate while prepared. Preserve unclaimed
+		 * firmware outputs through CCF's unused-clock cleanup, as for
+		 * PWM waveforms; only a consumer may turn them off.
+		 */
+		chan->bypass_hw.init =
+			CLK_HW_INIT_HW(name, parent, &sun8i_pwm_bypass_ops,
+				       CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE |
+				       CLK_IGNORE_UNUSED);
+
+		ret = devm_clk_hw_register(dev, &chan->bypass_hw);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to register bypass clock %u\n", i);
+	}
+
+	return 0;
+}
+
 /*
  * A disabled pair gate makes any set PER bits ineffective. Clear those stale
  * enables before a clock consumer can turn the shared gate on and expose an
@@ -1103,6 +1278,17 @@ sun8i_pwm_sanitize_disabled_pairs(struct sun8i_pwm_chip *sun8i_chip)
 	sun8i_pwm_writel(sun8i_chip, per, SUN8I_PWM_PER);
 }
 
+static struct clk_hw *sun8i_pwm_get_clk_hw(struct of_phandle_args *clkspec,
+					   void *data)
+{
+	struct sun8i_pwm_chip *sun8i_chip = data;
+
+	if (clkspec->args_count != 1 || clkspec->args[0] >= SUN8I_PWM_NPWM)
+		return ERR_PTR(-EINVAL);
+
+	return &sun8i_chip->channels[clkspec->args[0]].bypass_hw;
+}
+
 static int sun8i_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1141,6 +1327,14 @@ static int sun8i_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = sun8i_pwm_register_bypass_clocks(dev, sun8i_chip);
+	if (ret)
+		return ret;
+
+	ret = devm_of_clk_add_hw_provider(dev, sun8i_pwm_get_clk_hw, sun8i_chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add HW clock provider\n");
+
 	ret = devm_pwmchip_add(dev, chip);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");

-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695240;
	b=Z/vWjKRDvVi+hlGvwXavpl++iRBYwpFRKBw6+r0Ir+rXVn8xaAGqAKpXmY170COopJdb
	 7Jj+9xzWraHtzyY23IVttlsDVrVqbt5BTKML9V8Vk2hbH0+pDuWQ/9GgmKI8KFhbRv6aq
	 7i6M3yyWJIkw5wZEndCQ5HQOkAkaL4aAWjAbgBeZaNWsNiMRkonSuHiOpNcdyXfpliQC4
	 nWROhjRWrHulSetDgr5j5qFxTDUHonXnSGdmTfoucSR2ubbCp+LKzNEr6dUDLdf8+3QXK
	 4/dtbQw1NXw+W3MNd/QQlds70wMbBTTja4ZWUW6jlZcJ7KoV1S2kRdhOewFTHBHtOLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=WEFo+IxVAs/pTlWHu2sW56+ha4/QPfN3XGM3j/8cBZM=;
	b=WOu6M4YRLN3xC/pkkvDKvBFreU2Y33o58Iu41n7Sxqy+u8lkEK7PGqKkjsTAAM5C1roV
	 id/WpOHPsCgGfbwsdefgWJJrIt/jqhAdZfEMvbVur9wlWSerKMEfRNtTUxo6fYqVSkV/R
	 CK81yPMlqaYWRFfnVwaQVECWiPC/74feAj56xwGjYsJLdI1n7Z+AQDdaaU6yxB+xYNl5T
	 4bcYIF/Ih/L1mJQpA65AiZ0qJhr3VUs3hwqPb2pSDZpdwOqlk8z+R1TDC0YolwERl8OLz
	 ZHOOeWUrlcdfCe7eTyHwIldWFOp/Udul7hK34U3Z4gxn1Hl7D36yB676npf6Kv+3QvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YiqQnPpq;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C351606B6FF
	for <linux-pwm@vger.kernel.org>; Tue,  3 Nov 2026 08:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C351606B6FF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YiqQnPpq
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6de2f213b7aso1673203eaf.0
        for <linux-pwm@vger.kernel.org>; Tue, 03 Nov 2026 00:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793695239; x=1794300039; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WEFo+IxVAs/pTlWHu2sW56+ha4/QPfN3XGM3j/8cBZM=;
        b=YiqQnPpqSFy4Nm+haOc8aNLOCRmSRWC/mMFWJOdlgxkBlnskuMVwcvKShR9AE+qC3e
         u/VYBqCLyWAxs+SGOO585hAYMPfB7OLWZ7Uc8yKQUqpDJ+BAtiHytlHZRFBODzYHjj/N
         6Mgj2COQscPHM1wVtW4vfbPKp8YywrJIGs+PrNet22xGJx3/LqyjofIlFTh77uleEapG
         s4lKMuQKRW4JNNrDQtB9p8j1F3vZjuPRIcByMPeaFRhWle2O+QScEeyrB5E/mKa2l5tg
         3J9gyAEA8iTQUQ49kHwNAFqPBW7cHAWuhw1WH39Z6Q6lNaT23Ybuf0QjQifbYtSlAxH7
         +UhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695239; x=1794300039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WEFo+IxVAs/pTlWHu2sW56+ha4/QPfN3XGM3j/8cBZM=;
        b=p2TOcbiWKBs1qKdvgYTbWWdN4RqArpakpsZS2V+vkR0cawOKiR761/z6hfdU6J0atp
         sofXqdBNI9CP1FdtL5bjbT6iyUEsQtbL2wBBvPgVlTpEWd645Uzf6JCljS5qQH5oX7Xg
         K48YtmvEdSbI7lJDSQPH8OS1s1neGPUv8BQamFsBMfToWKzEvjwSJszlYK+AdhcAdTOL
         TMJT0/FnnE4vLBzjCvGE2OKTaU61xgwCAoUHwvtPyMmJgHJXQgNT/FAUza313hxsLy77
         lPWIzsKgtNr2i7B9AaQvKGC4yZP6Xf6DemifjK6wf3kFFmllpThlBYwWcdEl1nKJNeNC
         kvYw==
X-Forwarded-Encrypted: i=1; AKwUvBwFZMeNQSCp7Y3jL2CbU27kZbtjpgv/Z8m1wReoMG/XwhsXJbDnC8z0nS+mn0C7+L8p9REa8FPP1jg=@vger.kernel.org
X-Gm-Message-State: APuU4Z911pky4GJMMfZSPjdZjjvunLLhnWRylmgnIha02kmaKqUxpGSr
	CJaTIVMEgFRaCfCTeJmt4GyRSOWcbqK/TR1pN8rOm3nIMQQpVqF0aorV
X-Gm-Gg: AYBFou0xhS3k2plSpOlwx786sy0CySBDqlKafBF3pbYOLcNET1F5mOHZ5fswUP4EOJm
	KUOQMV30oi3NZ9vCj/vSs+cAnaDeGB/cT3SsRmrArOXJhGHEmmUKLP6VybnrsUAWHUZ/fJ2/8FK
	0qJNJlMRXgGbnKr9LagvZh9WAGpn2Rus8YLNS+/xIzJiWTLjOOOMbOQOiRjlxH5Y00sQbXSnJ57
	tdimF6fkYLE0OxS7jI+80JCxu7pcuf06sJffDslbe1j0hWSliLkgiorJIRWIGcN4K8eVElmm6Pm
	r65MiJbOKTlzaF6Gzq5Q8veYI0g8ebA59+NQXvKdxY1mS2YRGbDcPUSNQOC/fnUSyLD+rakeIbP
	Zc3L7XR0tSLNoeYcz2+TSt8VcaETG3SUIMb60fzCDXPrcbINHBG0qdRxrcDtHUss0/aVy+pc+0W
	dGS0t/Yh9wyz6TpBtXNrWwutPLYhxuVLNo/ytPreTLmUKtHN03gAAVAFYC5qb4iL5aXsf7KXUEo
	Cs5mLL1SFwYUSyorf4xr+l7/FXF21LpxO61rI3qqpg86A9tBbAqcs3kcHzddlSj8+KfFzw62lhi
	bg0CVgVNJ7S1SXbWrKXtBfHojt2hlk1cESbeC6lwpAJy59A1zDw4BBkEzrvngPdSL4EywG2UNUD
	5iJ8G8N2NvKMf1HXoQESpdGRthcpG2841QZj0dPogTcLlRBTTPphA8xhNFnsUu/s6pYmN7woA6W
	gm6ZDsrjlzVzEYb1m5xWyCNhpfHGR8asdYtxj4zumnVvqQS2SOoT8=
X-Received: by 2002:a05:6820:151b:b0:6e0:3cef:6883 with SMTP id 006d021491bc7-714f2a9d542mr6176467eaf.77.1793695238968;
        Tue, 03 Nov 2026 00:40:38 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f3081097sm10520397eaf.13.2026.11.03.00.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:40:38 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 01:40:28 -0700
Subject: [PATCH v11 3/5] pwm: sun8i: export the bypass outputs as clocks
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
Message-Id: <20261103-h616-pwm-v8-v11-3-07abb59575c3@gmail.com>
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

Protect the pair rate temporarily while reading a waveform, including
unrequested channels exposed through PWM debugfs. Otherwise an exported
clock consumer can retune and enable a previously disabled output between
the rate query and register snapshot, combining the old rate with the new
configuration. Use the provider-owned handle for this hold so a rate-setting
consumer cannot drop it, and release it after the locked register snapshot.
Keep the sleeping CCF calls outside the register spinlock.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
Co-developed-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/pwm/Kconfig     |   3 +-
 drivers/pwm/pwm-sun8i.c | 198 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 195 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index d87d166e7836..d3c35a11859f 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -754,7 +754,8 @@ config PWM_SUN8I
 	depends on HAS_IOMEM && COMMON_CLK
 	help
 	  PWM framework driver for Allwinner controllers whose channels share
-	  paired source clocks.
+	  paired source clocks. In addition to PWM operation, each channel's
+	  hardware bypass path can be exported as a clock output.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sun8i.
diff --git a/drivers/pwm/pwm-sun8i.c b/drivers/pwm/pwm-sun8i.c
index bcc2c5744378..56854e6218c9 100644
--- a/drivers/pwm/pwm-sun8i.c
+++ b/drivers/pwm/pwm-sun8i.c
@@ -113,6 +113,9 @@
  * The bypass in PWM mode is used to achieve a 1/2 relative duty cycle with the
  * fastest clock.
  *
+ * SUN8I_PWM_clock_x/y serve for the PWM purpose.
+ * SUN8I_PWM_bypass_clock_x/y serve for the clock-provider purpose.
+ *
  */
 
 /* /div_m is a power-of-two divider limited to /256. */
@@ -129,6 +132,12 @@ static const struct clk_div_table sun8i_pwm_div_m_table[] = {
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
@@ -142,8 +151,12 @@ struct sun8i_pwm_pair {
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
@@ -153,7 +166,7 @@ struct sun8i_pwm_chip {
 	struct sun8i_pwm_channel channels[SUN8I_PWM_NPWM];
 	struct clk *bus_clk;
 	void __iomem *base;
-	/* Protects shared registers and rate_exclusive. */
+	/* Protects shared registers, channel ownership and rate_exclusive. */
 	spinlock_t lock;
 };
 
@@ -317,6 +330,101 @@ static int sun8i_pwm_pair_rate_notifier(struct notifier_block *nb,
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
@@ -342,8 +450,12 @@ static int sun8i_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
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
@@ -372,6 +484,8 @@ static int sun8i_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_put(chan->pair_clk);
 err_clear_clock:
 	chan->pair_clk = NULL;
+	scoped_guard(spinlock_irqsave, &sun8i_chip->lock)
+		chan->mode = SUN8I_PWM_MODE_NONE;
 
 	return ret;
 }
@@ -382,6 +496,9 @@ static void sun8i_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct sun8i_pwm_channel *chan = &sun8i_chip->channels[pwm->hwpwm];
 
 	scoped_guard(spinlock_irqsave, &sun8i_chip->lock) {
+		if (chan->mode != SUN8I_PWM_MODE_PWM)
+			return;
+
 		sun8i_pwm_set_enabled_locked(sun8i_chip, pwm->hwpwm, false);
 		sun8i_pwm_set_bypass_locked(sun8i_chip, pwm->hwpwm, false);
 	}
@@ -390,6 +507,9 @@ static void sun8i_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable_unprepare(chan->pair_clk);
 	clk_put(chan->pair_clk);
 	chan->pair_clk = NULL;
+
+	scoped_guard(spinlock_irqsave, &sun8i_chip->lock)
+		chan->mode = SUN8I_PWM_MODE_NONE;
 }
 
 static int sun8i_pwm_read_waveform(struct pwm_chip *chip,
@@ -399,12 +519,20 @@ static int sun8i_pwm_read_waveform(struct pwm_chip *chip,
 	struct sun8i_pwm_waveform *wfhw = _wfhw;
 	struct sun8i_pwm_chip *sun8i_chip = sun8i_pwm_from_chip(chip);
 	unsigned int pair = SUN8I_PWM_PAIR_IDX(pwm->hwpwm);
+	struct clk *pair_clk = sun8i_chip->pairs[pair].hw->clk;
 	unsigned long pair_rate;
 	u32 pccr, pcr, pdzcr, per, ppr;
+	int ret;
 
-	pair_rate = sun8i_pwm_get_pair_rate(sun8i_chip, pwm->hwpwm);
-	if (pair_rate > U32_MAX)
-		return -ERANGE;
+	/*
+	 * An unrequested channel can be retuned and enabled by a clock
+	 * consumer. Keep its rate stable until the register snapshot is taken.
+	 * Use the provider handle, separate from the PWM rate-setting handles.
+	 */
+	ret = clk_rate_exclusive_get(pair_clk);
+	if (ret)
+		return ret;
+	pair_rate = clk_get_rate(pair_clk);
 
 	scoped_guard(spinlock_irqsave, &sun8i_chip->lock) {
 		pccr = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(pair));
@@ -413,6 +541,10 @@ static int sun8i_pwm_read_waveform(struct pwm_chip *chip,
 		ppr = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PPR(pwm->hwpwm));
 		pdzcr = sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PDZCR(pair));
 	}
+	clk_rate_exclusive_put(pair_clk);
+
+	if (pair_rate > U32_MAX)
+		return -ERANGE;
 
 	*wfhw = (struct sun8i_pwm_waveform) {
 		.enabled = !!(pccr & SUN8I_PWM_PCCR_GATE) &&
@@ -510,7 +642,8 @@ sun8i_pwm_pair_rate_constrained(struct sun8i_pwm_chip *sun8i_chip,
 	unsigned int sibling = idx ^ 1;
 
 	guard(spinlock_irqsave)(&sun8i_chip->lock);
-	return sun8i_chip->channels[sibling].rate_exclusive ||
+	return sun8i_chip->channels[sibling].mode == SUN8I_PWM_MODE_CLK ||
+	       sun8i_chip->channels[sibling].rate_exclusive ||
 	       sun8i_pwm_channel_is_enabled_locked(sun8i_chip, sibling);
 }
 
@@ -1033,6 +1166,42 @@ static int sun8i_pwm_register_pair_clocks(struct device *dev,
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
@@ -1061,6 +1230,17 @@ sun8i_pwm_sanitize_disabled_pairs(struct sun8i_pwm_chip *sun8i_chip)
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
@@ -1099,6 +1279,14 @@ static int sun8i_pwm_probe(struct platform_device *pdev)
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795801216;
	b=KqNBzAeqWk0tCB8q238eKdiyzKE8MSNxk8mgX6e56+io3YVI89+JfAN44ZelIV7zVYH5
	 4pz3dJ51huXL8byAiwUoUh+DEsRTpBuSgK6ppM5u3wDiEZFQ6GCE4s1U4eZiahmc8M6zr
	 hUcYVSgve/nH1D8XJrScKSjAqraulf4BylX42dm93RE+j4ADcyC1l/fZPdSpCRbKUxi3D
	 4BjG/UsFhKfg5nzym5s3qJIQpGH/iet5mS15IQEGsT+8TyPpAcukS0nImEoIEc4AK4XfP
	 pxKCfR/3oG4rQxUoNqddrsyDKwIp+Mn8gnIo5IrTjqKUtizFcFiZ00rmI3Jfybrv8FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795801216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=bGqCohR5dtNzmiXlJRd2AHgHw1VyKnQU8NNwe2lurSA=;
	b=FK/yJBi9t4kk5rFKpEzeejTF0Lm6MVE5szcaP+bA6zsF9GbSkfbquYHZwxnkwjG/xadn
	 3/Zp0I2Rll5Y6q3gLlZNFpSfKNpudbkhN7ica6+RBOuF8pJv7kfRCosvS3VQQHSS0Rwc4
	 bSozuV+U/DRGPP0ebtbxOo8/MlD4jagdLPDxAJ7Xh582FVsU3aJqp2udVnnj7S/CtC2a2
	 2eaLCh1R53YrEsG9mfLCM0M5HeJ64PN2l3FG0DT6JkeIFcczFi//8vom3gsvkicgpGIsZ
	 sn5ZcRbQFok0YCN8LWVsS058+dCeH416KaHPkfkqsEkEVVVs1tYaan4wQ5wO+ZXwPfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="oOvI/len";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025AB606A687
	for <linux-pwm@vger.kernel.org>; Fri, 27 Nov 2026 17:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 025AB606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=oOvI/len
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49d05d51553so58894185e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 27 Nov 2026 09:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795801214; x=1796406014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bGqCohR5dtNzmiXlJRd2AHgHw1VyKnQU8NNwe2lurSA=;
        b=oOvI/lenxXfGHVTgSCi+ye20+5i95+K1Uln9vnZtLqQy66mz/qwBuXFCtv6F/NGsC1
         y7lyaaXYMATd/7rL+UNLuzZFqOT8e1YmGlngjf321x2+KClnnG9oLoO4kYoCoo0EiXxE
         Cj5MoBgAMwk7hdeV2uqPvT4rXcqw7Nt7e4H/RZ7J05kwHslGLABD+j6qwUMc0ybiIYWw
         UD2NBtX8gf9AUkW9A/QAlZwHjBDgR0xJswXyfbkqAUty1dEfng1MVumsqZpr+CMLajbS
         Icfg8Y9wLdfPNENvAZe/y/2if8H6Z8I+m355mabLiPZ9F3prkuKeViKvpEGJ6fJkWpAc
         Oz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795801214; x=1796406014;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bGqCohR5dtNzmiXlJRd2AHgHw1VyKnQU8NNwe2lurSA=;
        b=xzIeXU/ivpk5zw6PW4D6GWiGxTtJ+bQnJckzwZ7Vim1E2zphQi/2T9GJQGWcvbUG75
         btZZ3WckrsNUobXvQMArfgQ5x8LQdcId3RJE2NMKIkRXtE4c3uxYN1o2t8/tBKy61dT2
         Knq5i+sMYmrtd6kBQ+3caHV+vzTkQnpKTzej4ZIc5vVeQNFmkmS1GjMF3g5cT5y6TUZy
         yXRTs+fsqVlVexmIEANPilmjo66rtY4qADVMfDFLdUUNoeGuCgeAhX4BvZ1/FRb1udAK
         dTK1PCP7u1lYS53N6TMy0Vs+YJp7G902DdQkW0cl7Am4ZgWdQtIJ9+hyoIQeO1JB5KxF
         e+1Q==
X-Gm-Message-State: APuU4Z8U6092Zmf8RlhpCy09i9RmqD0iE9jdLf/QQdQhZhBR7dsw+IMI
	SjM49bFAoibsRDse8zmOOER20RuAS+FhhB0YKvHyRITsBiaKjLVbgU8+8rOWz9a1MiDYWxW2w6d
	Lar0sXPk=
X-Gm-Gg: AZFdTZcMUKaT85aEdVjIgS4/2tlflHsxvTW0O7x8O3qpLaqVS6RyTVjWbQeMjXa6Ub4
	kLIjTkJA6YYAJidIM2iM4yWXIRt7wGlqWquidoFsrcKARpDmT1Tm5AVaNOQ7sg+8fAmN7YBUK4x
	qYmAFkAnzWLepooArXZLqJcRLGylKIoAUHpmF3sAapSE5rPLjV5HumK03K7XmHVa0sxuTIH2o6/
	k9VnEpDQZ0z1k1pTPCXfDDsZEsYrwYYJS1GJ8NKbawZHvNEPqGqmGXfW+5ed1y8poNcxvJePEeI
	WBlFnivCPOcUKr/j17jJRtI0VuYpzq88H0ddIM2J/UrL9/AAsBU2SLlktZV2e6G/tdFftqXT9eZ
	QsmZP5xxxBbfuF4fgzSJFyZx3fpbTjJ7ZWT/F/fgANYnhRQzVd6RbDv8QoroJg6PGR+UfosbYZG
	FAsaVGbOJEP+4aHtW1bf7jKIEtxHQsW07u49nA3MhiCBcNm9Ad/oAQh66xI1GzP6kcm9irGOhBJ
	zO2j4/vn4ZCII+ftSBpQ7RuRlv8KU4i46ImSQOQ2EPXcYclfOPGuM8qne6lwP8JKcY8bxjbY8Dq
	IDjsjqCE1eitESNSkgkT2zZifjzF/yC0c+Rt4hcZqj3SxbByrLqQBLB88YNWi5njtpeXOj0CVaV
	/KDVzbbMw7ZSSamSa
X-Received: by 2002:a05:600c:a085:b0:4a2:526b:d410 with SMTP id 5b1f17b1804b1-4bb8881092bmr517665425e9.13.1795801214419;
        Fri, 27 Nov 2026 09:40:14 -0800 (PST)
Received: from localhost (p200300f65f044d0890ab5f15b7da13fe.dip0.t-ipconnect.de. [2003:f6:5f04:4d08:90ab:5f15:b7da:13fe])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb88442995sm745304055e9.2.2026.11.27.09.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 09:40:14 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: =?utf-8?q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] pwm: tiecap: Improve period calculation around overflow handling
Date: Fri, 27 Nov 2026 18:39:44 +0100
Message-ID:  <cdbbffdf38738f589330fbfbf31ad5dc9b6efed1.1795800756.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795800756.git.u.kleine-koenig@baylibre.com>
References: <cover.1795800756.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2918; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=SmM6TJdWDVC8UdQKE0BR6A5vTz09aHry+emBOgR21dc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrCcBpaLf5aAnHM+y1L7B22PHw1FRVgW1s1HYwC HNw3xuvTFOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawnAaQAKCRCPgPtYfRL+ TkBmB/0cgqcAdE8ONBj71ndky/lbdjgggbeGJ53SKJEj+Awgc4q77pK7r5/ujkK5jLVWedxu2hQ 5fcd25V+2iqzKpjQjXsZMDLR/5CC35GLxNFLKlk0ZixjuVJwLaAuBhM2Rz2Kjv4iIM0ssnDezCh 7Kz713LNrW3YOpQRv5uActRr4yEHRxzzlaq72/AZmosF/nXd5b3auW6Rg5AGED8IwRV/2UTfQ19 iW4G4SjofReg4TJvVL5pCAws/cWhJnqdo5xEUMce9NQvt5A532RRrtyhjm3zoNUmoPmrwtbtVN9 YpWmjNmcc0s5ndY5WB7mVbJJF7CZ/+Is93YdPHOXDzakm7nR
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Up to now the driver refused to configure for periods longer than 1
second returning -ERANGE. That is wrong for two reasons: a) Too big
requests should be clamped to the biggest possible value; and b)
depending on the input clock rate longer periods are actually possible.

To address this use mul_u64_u64_div_u64() to convert from nanoseconds to
clock ticks which doesn't overflow if the result doesn't overflow. To
ensure the latter make sure that the clock rate isn't faster than 1 GHz.

But in return refuse requests of too small periods.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-tiecap.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 05c38967504a..fe803630d753 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -52,27 +52,25 @@ static inline struct ecap_pwm_chip *to_ecap_pwm_chip(struct pwm_chip *chip)
  * duty_ns   = 10^9 * duty_cycles / PWM_CLK_RATE
  */
 static int ecap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			   int duty_ns, int period_ns, int enabled)
+			   u64 duty_ns, u64 period_ns, int enabled)
 {
 	struct ecap_pwm_chip *pc = to_ecap_pwm_chip(chip);
 	u32 period_cycles, duty_cycles;
-	unsigned long long c;
 	u16 value;
 
-	c = pc->clk_rate;
-	c = c * period_ns;
-	do_div(c, NSEC_PER_SEC);
-	period_cycles = (u32)c;
+	/*
+	 * With pc->clk_rate ≤ NSEC_PER_SEC the multiplication+division
+	 * doesn't overflow.
+	 */
+	period_cycles = min(U32_MAX,
+			    mul_u64_u64_div_u64(period_ns, pc->clk_rate,
+						NSEC_PER_SEC));
+	if (period_cycles < 1)
+		return -EINVAL;
 
-	if (period_cycles < 1) {
-		period_cycles = 1;
-		duty_cycles = 1;
-	} else {
-		c = pc->clk_rate;
-		c = c * duty_ns;
-		do_div(c, NSEC_PER_SEC);
-		duty_cycles = (u32)c;
-	}
+	duty_cycles = min(U32_MAX,
+			  mul_u64_u64_div_u64(duty_ns, pc->clk_rate,
+					      NSEC_PER_SEC));
 
 	pm_runtime_get_sync(pwmchip_parent(chip));
 
@@ -193,9 +191,6 @@ static int ecap_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	if (state->period > NSEC_PER_SEC)
-		return -ERANGE;
-
 	err = ecap_pwm_config(chip, pwm, state->duty_cycle,
 			      state->period, enabled);
 	if (err)
@@ -291,6 +286,13 @@ static int ecap_pwm_probe(struct platform_device *pdev)
 	pc->clk_rate = clk_get_rate(clk);
 	if (!pc->clk_rate)
 		return dev_err_probe(dev, -EINVAL, "Failed to get clock rate\n");
+	/*
+	 * By ensuring that clk_rate is at most 1 GHz we can be sure that the
+	 * conversion from 64-bit ns to 64-bit clk ticks doesn't overflow.
+	 */
+	if (pc->clk_rate > NSEC_PER_SEC)
+		return dev_err_probe(dev, -EINVAL, "Invalid clk rate (%lu Hz)\n",
+				     pc->clk_rate);
 
 	chip->ops = &ecap_pwm_ops;
 
-- 
2.47.3


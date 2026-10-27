Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108557;
	b=QX0y6eC+VBGT37iIGAhAM6Ndnq0pKdgAeGWadxSrvx6jARN13Wrr0W9xNA//GimDbyze
	 OawzZdSemefGueviHZ3duUmJryUmY9PulF1eUXJmwMIn0uv2T6ATuCoWGRHGW32vA/+as
	 iosefpMC5nnI8rD3MC2SPyKCCCz8L1HbkzKR1dWwFxfx1wei9wJn2UQvyRyCT9w+4YbGM
	 Blm311ZIFz7XF7KW1t7W9FcX5ScBBsE/sKd0gP8gITDBTie5of/y2D38LO0/9u2V5mxTl
	 i7X7APjlNP5VakWAMRwdqredRNykJ0pQ5+RroKmteMu0ipymk4COCIriv4jMmSNyiYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108557;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VOv2hj4TqzHbEep3nPGzgUbHv1sJOMyDv++GUr8JGyk=;
	b=3igDZh9SJ3mWoKqMAk+NJpb6hF6RC6qW6RO9U1BDzuWKAgKbNWPMoCMr+L4fgO/KsknI
	 yQXjKoDCrcPHaE8J3lq1C6gSVuPSqnBK8ugWIbuoPKH/BidqK116ili1oP0vtY9XJFnaW
	 NZe+uwgwYLzvWEcHsxiVNA7U0VX46fiGZCBef53Y3KZcQRmn1U0c2wIbHuHSpoPiUJiZ5
	 a9dhHUsVKAornbHLeDvWl7RP6CWWbGtxUJgpEkEyx7YDlbtf0ebDeeqxBpSsNH/LXn/45
	 T+Rir6b9AZk3TlfcS98+jtwuwCQfpPYoAUyVZoKWmbz9iwPiQ30uYeay5eV+Lap2/ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J0BqDMIu;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9F2606A31A
	for <linux-pwm@vger.kernel.org>; Tue, 27 Oct 2026 13:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C9F2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J0BqDMIu
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so6028765e9.0
        for <linux-pwm@vger.kernel.org>; Tue, 27 Oct 2026 06:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793108554; x=1793713354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VOv2hj4TqzHbEep3nPGzgUbHv1sJOMyDv++GUr8JGyk=;
        b=J0BqDMIuKcGFkQ15hjMJuYOaQ6ujmXm/YHH4R7te1jWudJwMM+XoDkHU4ivM6hUrAj
         59XjzhHlXReepZQW0FuHb4x6Qx7EZWq9vqz46S65NOR1Jt6yfiUiTmdBPD8VoREJv34s
         aSz/A+RnG2yhgVSWN/2+8BbethaO5y7B9KsYLXL6Wz7HIntCc9GGts/y9XP2wXgVr5cv
         J0//Qsa5+OByrVqqN87/F3uGlxfdtT1QAWlisIIxhXgLQsFpGp86fUk6GwFURKMJSToo
         hLIRXsRm/t3eeapb3MP/P+FjNCkGEIony60OEhwsSHDIklqM3ew5Bjn4Ybe0AQ9uBCSH
         Y9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108554; x=1793713354;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VOv2hj4TqzHbEep3nPGzgUbHv1sJOMyDv++GUr8JGyk=;
        b=KGClOK1It/EcKCroTkKTkmChvRQSfU+iaK/+bB7nE+FBGzRnfTIhGeacIG8gkyigg7
         FQnX3VOlHH6M9Bu3405olnD3QLciJWeFco1AegcFbCdiNZly/nJJdlk6qdPlMZiY4IPz
         QbjvBtZ5o02CCCf3/JdE4DErl4IvaTAe/sr3UrJ1XDw1GVIXxgm/tGvji3XMkWRhP6hG
         xRg4I8ZEJUxiK37wxCn0YtSOyUZ8j126T0Jaxtu+w692ld3kayInSPytm0EqhwFuO1BN
         bJHIPAbWd5/x5HMeZ+pIEQM9/5/ou0b0lx2woINjmo2VAQgiIwxKiCnexI+HTHcWq23f
         L78w==
X-Forwarded-Encrypted: i=1; AKwUvBwnig3wJDDYxgsP1fEc9slalz0hKmtt27y1ATBW97dcUJrMFOvw09fuj51P9WsrS/9cV/DnP2K+6tM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7petdEvnGnGzPjY+Lj4lAud1zoz6cj0mnXImHRcGLu7NvcAZ+
	SVG3+LjoAaUPo41/06lIFOKUqVNAAI63jTpN+cZ/ZXXL/MXXTg0mDzN/6n0iYyAw
X-Gm-Gg: AYBFou05K1dbETBmbj0cCTInX7BiRpuayLdVbzU+1/KSwLp7c69OaBHiJwVhDfikq9w
	//+uSNMnVjpsLK9NtsNnnhi2QLqfsefVJSCsIXY7dNKaCx7a1jd/sBWraNT7kjK7a6r2SbQZ7Va
	YF9iTzBVGMm+KfwOPlBY/h7hfEYzuqadOH5giMRSTi1i0cpumHgxGrBWykTooAs9Sxb/G2fJ5SX
	QMVEFTHDQKUhYF5NSye4VK9MyhQwn7LnHdkca9JkZZfzCMZcDGZ+Es66mJIe8WBpaNR7TmNK8Bm
	Cnz+21aaIrwerH1rdz7kb+hj4zjjXSpFaF1XlYcnn1qzgTRquSgE6j1kGObWnPHGsp7A2/kTzBf
	l7J3Rb4uqZIhUZiA8mMCxbYRM1WQHhK1u82wSx2AkmbYswoGp/t45gOL0G3PqorCXI33IhMZ8ke
	jDQ/crIW2P5dFWiqcAIk1BquvdFXqlflf96T2YfLCPvZBoK31QFFaD4cJMUonHa6IdDP4VXt2Mh
	pegWM94Z9IGH/KNQ/n0EddGMRVF0se5J9RQpWozyMKy2HDPGSNWZGCMB4Cg4BCNf8ZU8+/aD6dN
	m/FrkPeVSAx30zax
X-Received: by 2002:a05:600c:3c98:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4a7c1c845a2mr60104605e9.16.1793108554418;
        Tue, 27 Oct 2026 06:42:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ad39sm696126435e9.1.2026.10.27.06.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:42:34 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:42:33 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Claudiu
 Beznea <claudiu.beznea@tuxon.dev>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-pwm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pwm: atmel: Fix arithmetic overflows for long
 periods
Message-ID: <20261027134233.3f1e030a@pumpkin>
In-Reply-To: <20261027022755.52912-1-kmehltretter@gmail.com>
References: <20261016161221.16553-1-kmehltretter@gmail.com>
	<20261027022755.52912-1-kmehltretter@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2026 03:27:55 +0100
Karl Mehltretter <kmehltretter@gmail.com> wrote:

> atmel_pwm_calculate_cprd_and_pres() first multiplies the requested
> period by the clock rate in a u64 and only then divides by
> NSEC_PER_SEC. The product can overflow even when the quotient and the
> resulting hardware configuration are representable.
>=20
> For example, at 12 MHz a 1600 s period has 19.2 billion clock cycles
> and fits with prescaler 3, but the intermediate product exceeds U64_MAX.
> It wraps and the driver programs a period of about 62.8 s instead. This
> remains broken after changing fls() to fls64(). The duty-cycle
> calculation has the same overflow.
>=20
> Use mul_u64_u64_div_u64() for both conversions and use fls64() when
> deriving the prescaler. The multiply/divide result cannot overflow if
> the clock rate is at most NSEC_PER_SEC, so hold the clock rate exclusive
> and validate it at probe time.
>=20
> The reverse conversion in atmel_pwm_get_state() can overflow too: it
> multiplies CPRD or CDTY by NSEC_PER_SEC and then shifts the u64 by the
> prescaler. Convert the scaled clock ticks with the overflow-safe,
> round-up helper instead. Explicitly saturate values that cannot be
> represented by the u64 nanosecond API, rather than relying on the
> architecture-specific helper's quotient-overflow behaviour.

Personally I think mul_u64_u64_div_u64() should return ~0ull on both
overflow and divide by zero.
While a valid result, any code that expects it can pretty certainly
also get 'a bit more' so including ~0ull in the 'overflow' values
doesn't really do any harm.
But someone insisted on in faulting - even though there has been
a patch to x86-64 to recover from the fault.

>=20
> Fixes: a9d887dc1c60 ("pwm: Convert period and duty cycle to u64")
> Cc: stable@vger.kernel.org
> Reported-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> Link: https://lore.kernel.org/r/atnHHaOwTkI78_tc@monoceros
> Suggested-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Changes in v3:
> - Use mul_u64_u64_div_u64() for the period conversion as suggested by
>   Uwe, and for the analogous duty-cycle conversion.
> - Fix the corresponding overflow in the get_state() conversion and
>   explicitly saturate results that cannot be represented in nanoseconds.
> - Hold the clock rate exclusive and validate the rate bound required by
>   the arithmetic.
> - Rebase onto v7.3-rc7.
>=20
> Testing:
> - Built an ARM zImage with clang 22.1.8 and W=3D1.
> - Passed 14 host boundary tests, 53 oracle-checked SAM9X75 QEMU boots,
>   and all 20 PWM device-model qtests.
> - Passed 89/89 checks on a physical SAM9X75, including overflow cases.
>   A 69.175-second period measured 69.210 seconds between interrupts; no
>   kernel errors were found.
>=20
>  drivers/pwm/pwm-atmel.c | 46 +++++++++++++++++++++++++++++------------
>  1 file changed, 33 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index 86918523d8..db7a14c66a 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -23,6 +23,7 @@
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -183,19 +184,18 @@ static int atmel_pwm_calculate_cprd_and_pres(struct=
 pwm_chip *chip,
>  					     unsigned long *cprd, u32 *pres)
>  {
>  	struct atmel_pwm_chip *atmel_pwm =3D to_atmel_pwm_chip(chip);
> -	unsigned long long cycles =3D state->period;
> +	unsigned long long cycles;
>  	int shift;
> =20
>  	/* Calculate the period cycles and prescale value */
> -	cycles *=3D clkrate;
> -	do_div(cycles, NSEC_PER_SEC);
> +	cycles =3D mul_u64_u64_div_u64(state->period, clkrate, NSEC_PER_SEC);
> =20
>  	/*
>  	 * The register for the period length is cfg.period_bits bits wide.
>  	 * So for each bit the number of clock cycles is wider divide the input
>  	 * clock frequency by two using pres and shift cprd accordingly.
>  	 */
> -	shift =3D fls(cycles) - atmel_pwm->data->cfg.period_bits;
> +	shift =3D fls64(cycles) - atmel_pwm->data->cfg.period_bits;
> =20
>  	if (shift > PWM_MAX_PRES) {
>  		dev_err(pwmchip_parent(chip), "pres exceeds the maximum value\n");
> @@ -218,12 +218,23 @@ static void atmel_pwm_calculate_cdty(const struct p=
wm_state *state,
>  {
>  	unsigned long long cycles =3D state->duty_cycle;
> =20
> -	cycles *=3D clkrate;
> -	do_div(cycles, NSEC_PER_SEC);
> +	cycles =3D mul_u64_u64_div_u64(cycles, clkrate, NSEC_PER_SEC);
>  	cycles >>=3D pres;
> +
>  	*cdty =3D cprd - cycles;
>  }
> =20
> +static u64 atmel_pwm_ticks_to_ns(u64 ticks, unsigned long rate)
> +{
> +	u64 max_ticks;
> +
> +	max_ticks =3D mul_u64_u64_div_u64(U64_MAX, rate, NSEC_PER_SEC);
> +	if (ticks > max_ticks)
> +		return U64_MAX;

I'm not sure how often this is called, but it might be worth caching
max_ticks during the probe.
(and maybe even the clock rate itself - I doubt it can change.)

David

> +
> +	return mul_u64_u64_div_u64_roundup(ticks, NSEC_PER_SEC, rate);
> +}
> +
>  static void atmel_pwm_update_cdty(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
>  				  unsigned long cdty)
>  {
> @@ -352,24 +363,22 @@ static int atmel_pwm_get_state(struct pwm_chip *chi=
p, struct pwm_device *pwm,
>  	if (sr & (1 << pwm->hwpwm)) {
>  		unsigned long rate =3D clk_get_rate(atmel_pwm->clk);
>  		u32 cdty, cprd, pres;
> -		u64 tmp;
> +		u64 ticks;
> =20
>  		pres =3D cmr & PWM_CMR_CPRE_MSK;
> =20
>  		cprd =3D atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
>  					  atmel_pwm->data->regs.period);
> -		tmp =3D (u64)cprd * NSEC_PER_SEC;
> -		tmp <<=3D pres;
> -		state->period =3D DIV64_U64_ROUND_UP(tmp, rate);
> +		ticks =3D (u64)cprd << pres;
> +		state->period =3D atmel_pwm_ticks_to_ns(ticks, rate);
> =20
>  		/* Wait for an updated duty_cycle queued in hardware */
>  		atmel_pwm_wait_nonpending(atmel_pwm, pwm->hwpwm);
> =20
>  		cdty =3D atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
>  					  atmel_pwm->data->regs.duty);
> -		tmp =3D (u64)(cprd - cdty) * NSEC_PER_SEC;
> -		tmp <<=3D pres;
> -		state->duty_cycle =3D DIV64_U64_ROUND_UP(tmp, rate);
> +		ticks =3D (u64)(cprd - cdty) << pres;
> +		state->duty_cycle =3D atmel_pwm_ticks_to_ns(ticks, rate);
> =20
>  		state->enabled =3D true;
>  	} else {
> @@ -487,6 +496,7 @@ static int atmel_pwm_probe(struct platform_device *pd=
ev)
>  {
>  	struct atmel_pwm_chip *atmel_pwm;
>  	struct pwm_chip *chip;
> +	unsigned long rate;
>  	int ret;
> =20
>  	chip =3D devm_pwmchip_alloc(&pdev->dev, 4, sizeof(*atmel_pwm));
> @@ -507,6 +517,16 @@ static int atmel_pwm_probe(struct platform_device *p=
dev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->clk),
>  				     "failed to get prepared PWM clock\n");
> =20
> +	ret =3D devm_clk_rate_exclusive_get(&pdev->dev, atmel_pwm->clk);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to get exclusive PWM clock rate\n");
> +
> +	rate =3D clk_get_rate(atmel_pwm->clk);
> +	if (!rate || rate > NSEC_PER_SEC)
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				     "invalid PWM clock rate %lu Hz\n", rate);
> +
>  	chip->ops =3D &atmel_pwm_ops;
> =20
>  	ret =3D atmel_pwm_enable_clk_if_on(chip, true);
>=20
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907


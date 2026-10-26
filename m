Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793001890;
	b=rIxEg1/ms4/c4RpxjD2hcw/zsnJYvrVlwGqZN+0Mv4WByIh2/kECPyb9I5Kf+9ad4uQo
	 jWE8GQTcXilRBloC5CyJkjdK9wgX8GB/icvXMb5Xy8+nJ4EgFp2lrOP4Q5/cHBGU6e2NB
	 DltxVEyqOaF3hcy6kqscARCvB+SODeDqoxiLK0KI0KtkNcr26AFKDUTZFQuorWX3scrBu
	 rAjj3W8HXGV9LO2CYaVwc/x5o7LOypJ4uD9XV+l42046f7tTGfsjlRNA6IWidJMHC+On7
	 TB5TlhGZcGiVfu+zMPftYJZCXHgzDRSwZ5+IXIy95G/xexi5pryIjjJCNNTgENGkz/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793001890;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qMXorstH88NzCoqjhGn94czvAmwVFQSOFUerq46d0UU=;
	b=h1RR9VtiAbJiNKcgkmD2slGxedfiHTqbhRlbDdWbZGtvaeBTm4K1z7J/+a+XMl35hYgA
	 e5pZOsAh/WDDDnmrriV4+LBwetF09uwAGDVo54ewiZJOZhv7aKBI7p9HkOLPfHGrcR+5R
	 a9Uyn1WcN/m3Iy4C6c4TPEjnbx47s0lwAJ0GMhGAOsgwpHAnb9CAfGyTiJ5a4v8kKn1cB
	 q8Ezz0419CEUFIPu8EtsHeTjD16pUpCFz+XJQAGkpPKv4BEEjqzP67W0FY517mbqAio1b
	 GgYiMTfIxcE2OCz2DEn9RrxMg0K9dOplTjXysVrFfM8WD3Ytd0UJc2eVN3u307GihFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1ORCFoI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6288B606A31B;
	Mon, 26 Oct 2026 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1ORCFoI
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 698791F01828;
	Mon, 26 Oct 2026 08:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793001890;
	bh=qMXorstH88NzCoqjhGn94czvAmwVFQSOFUerq46d0UU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H1ORCFoIc3gGnXRd10aLcQTBIUK4BT+KWLhGynt7HP9NgWC0xaOaJi0AS5PND9xUy
	 7zyCQQ3MG9fiydxYR7DjMTkiB4C5F67tHc/GlnNPVs48T7cxpTd0eYOSdjqU9SE76t
	 8qhTtZc3n0qeFNBeQB8+foTvfXqf3cpGhZj3lnteYMHVP+1oz/ADM/uw0xUOEv3yXq
	 vdtHdRSPt7fN96QSTtWU7TCUMsq9AXtCJtfqMFVBsU3p167Kk59m8bsWPFFmkEAl39
	 ovsFTIfg5xdBA7MiIVa5tbYLRCvPi4cyW+i/By6q0W5ALZy5q8ZDbrNDDF3tBTczU8
	 YDzY4LvSbmKSw==
Date: Mon, 26 Oct 2026 09:04:47 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, "H . Nikolaus Schaller" <hns@goldelico.com>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pwm: Add a driver for the Ingenic X1600 PWM
 controller
Message-ID: <at7-o4S_3DQE-sqs@monoceros>
References: <20261025191624.9219-1-olivier@mgcrea.io>
 <20261025191624.9219-3-olivier@mgcrea.io>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gwycectjexu4oivb"
Content-Disposition: inline
In-Reply-To: <20261025191624.9219-3-olivier@mgcrea.io>


--gwycectjexu4oivb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] pwm: Add a driver for the Ingenic X1600 PWM
 controller
MIME-Version: 1.0

Hello,

On Sun, Oct 25, 2026 at 08:16:24PM +0100, Olivier Louvignes wrote:
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 729776086879..244c8f4f140e 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -381,6 +381,17 @@ config PWM_JZ4740
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-jz4740.
> =20
> +config PWM_INGENIC_X1600

Alphabetic ordering please.

> +	tristate "Ingenic X1600 PWM support"
> +	depends on MACH_INGENIC || COMPILE_TEST
> +	depends on COMMON_CLK && OF && HAS_IOMEM
> +	help
> +	  Generic PWM framework driver for the PWM controller of the
> +	  Ingenic X1600.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-ingenic-x1600.
> +
>  config PWM_KEEMBAY
>  	tristate "Intel Keem Bay PWM driver"
>  	depends on ARCH_KEEMBAY || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 5630a521a7cf..5c59b54e0029 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
>  obj-$(CONFIG_PWM_INTEL_LGM)	+=3D pwm-intel-lgm.o
>  obj-$(CONFIG_PWM_IPQ)		+=3D pwm-ipq.o
>  obj-$(CONFIG_PWM_IQS620A)	+=3D pwm-iqs620a.o
> +obj-$(CONFIG_PWM_INGENIC_X1600)	+=3D pwm-ingenic-x1600.o

Alphabetic ordering please.

>  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
>  obj-$(CONFIG_PWM_KEEMBAY)	+=3D pwm-keembay.o
>  obj-$(CONFIG_PWM_LOONGSON)	+=3D pwm-loongson.o
> diff --git a/drivers/pwm/pwm-ingenic-x1600.c b/drivers/pwm/pwm-ingenic-x1=
600.c
> new file mode 100644
> index 000000000000..5865ff0cf298
> --- /dev/null
> +++ b/drivers/pwm/pwm-ingenic-x1600.c
> @@ -0,0 +1,280 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PWM controller of the Ingenic X1600
> + *
> + * Copyright (c) 2026 Olivier Louvignes <olivier@mgcrea.io>
> + *
> + * Eight channels, each with a power-of-two clock divider and a waveform=
 word
> + * holding the counts at the high and at the low level; the channel's in=
itial
> + * level picks which comes first (X1600 programming manual, chapter 13).=
 Unlike
> + * the JZ47xx and X1000, whose PWMs are TCU timer channels (pwm-jz4740),=
 the
> + * X1600 has this separate controller.

A link to a reference manual would be awesome (if available).

> + * Limitations:
> + * - The duty offset is 0 or period - duty (the high level last).
> + * - Neither count may be zero, so a duty cycle of 0 or 100% switches the
> + *   channel off and holds its output at the idle level instead.

That reads like 100% wasn't possible, but looking at the code it is?!

> + * - A disabled channel drives its idle level, low.
> + * - Changing the divider or the initial level stops the channel first, =
which
> + *   cuts the current period short.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/math64.h>
> +#include <linux/minmax.h>
> +#include <linux/mod_devicetable.h>

That is wrong, of_device_id is already provided by
<linux/platform_device.h> and <linux/mod_devicetable.h> pulls in many
unneeded dependencies. So just drop the latter.

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +
> +#define X1600_PWM_ENS			0x00	/* write 1: switch a channel on */
> +#define X1600_PWM_ENC			0x04	/* write 1: switch a channel off */
> +#define X1600_PWM_EN			0x08	/* the channels switched on */
> +#define X1600_PWM_UPT			0x10	/* write 1: load the waveform word */
> +#define X1600_PWM_BUSY			0x14	/* a load is pending */
> +#define X1600_PWM_MS			0x20	/* 0: waveform word, 1: DMA */
> +#define X1600_PWM_INL			0x24	/* the level a period starts with */
> +#define X1600_PWM_IDL			0x28	/* the level while off */
> +#define X1600_PWM_CCFG(n)		(0x40 + 4 * (n))
> +#define X1600_PWM_WCFG(n)		(0x80 + 4 * (n))
> +
> +#define X1600_PWM_CCFG_PRESCALE		GENMASK(3, 0)	/* divide by 2^PRESCALE */
> +#define X1600_PWM_WCFG_HIGH		GENMASK(31, 16)
> +#define X1600_PWM_WCFG_LOW		GENMASK(15, 0)
> +
> +#define X1600_PWM_NUM			8
> +#define X1600_PWM_MAX_COUNT		0xffff

This can be determined from X1600_PWM_WCFG_HIGH and/or
X1600_PWM_WCFG_LOW using FIELD_MAX().

> +#define X1600_PWM_MAX_PRESCALE		7

Why are there 4 register bits to store a value in the range [0 .. 7]?

> +struct x1600_pwm {
> +	void __iomem *base;
> +	struct clk *clk;
> +};
> +
> +struct x1600_pwm_wfhw {
> +	u32 wcfg;
> +	u8 prescale;
> +	bool enabled;
> +	bool inl;
> +	bool idl;
> +};
> +
> +static u64 x1600_pwm_counts(u64 ns, unsigned long rate, unsigned int pre=
scale)
> +{
> +	return mul_u64_u64_div_u64(ns, rate, (u64)NSEC_PER_SEC << prescale);
> +}
> +
> +static u64 x1600_pwm_ns(u64 counts, unsigned long rate, unsigned int pre=
scale)
> +{

Please add a comment about the ranges of `counts` and `prescale` here to
make it clear that there are no problems with overflows.

> +	return DIV64_U64_ROUND_UP((counts * NSEC_PER_SEC) << prescale, rate);
> +}
> +
> +static int x1600_pwm_round_waveform_tohw(struct pwm_chip *chip, struct p=
wm_device *pwm,
> +					 const struct pwm_waveform *wf, void *_wfhw)
> +{
> +	struct x1600_pwm *x =3D pwmchip_get_drvdata(chip);
> +	unsigned long rate =3D clk_get_rate(x->clk);
> +	struct x1600_pwm_wfhw *wfhw =3D _wfhw;
> +	u64 period, high, offset;
> +	unsigned int prescale;
> +	int ret =3D 0;
> +
> +	*wfhw =3D (struct x1600_pwm_wfhw){ };
> +	if (!wf->period_length_ns)
> +		return 0;
> +
> +	if (!rate)
> +		return -EINVAL;
> +
> +	for (prescale =3D 0; prescale < X1600_PWM_MAX_PRESCALE; prescale++)
> +		if (x1600_pwm_counts(wf->period_length_ns, rate, prescale) <=3D
> +		    X1600_PWM_MAX_COUNT)
> +			break;

I'm sure prescale can be calculated without a loop.

> +	period =3D min(x1600_pwm_counts(wf->period_length_ns, rate, prescale),
> +		     X1600_PWM_MAX_COUNT);

After determining prescale, you might already have calculated period.

> +	if (period < 2) {
> +		period =3D 2;
> +		ret =3D 1;
> +	}
> +	high =3D min(x1600_pwm_counts(wf->duty_length_ns, rate, prescale), peri=
od);
> +	offset =3D x1600_pwm_counts(wf->duty_offset_ns, rate, prescale);
> +
> +	wfhw->prescale =3D prescale;
> +	wfhw->wcfg =3D FIELD_PREP(X1600_PWM_WCFG_HIGH, high) |
> +		     FIELD_PREP(X1600_PWM_WCFG_LOW, period - high);
> +	wfhw->enabled =3D high && high < period;
> +	/* Low first only if the requested offset reaches period - duty. */
> +	wfhw->inl =3D !wfhw->enabled || offset < period - high;
> +	wfhw->idl =3D high =3D=3D period;

inl and idl are the levels before and after the (potential) mid-period
edge, right? Doesn't idl need to depend on offset, too?

> +	return ret;
> +}
> +
> +static int x1600_pwm_round_waveform_fromhw(struct pwm_chip *chip, struct=
 pwm_device *pwm,
> +					   const void *_wfhw, struct pwm_waveform *wf)
> +{
> +	struct x1600_pwm *x =3D pwmchip_get_drvdata(chip);
> +	unsigned long rate =3D clk_get_rate(x->clk);
> +	const struct x1600_pwm_wfhw *wfhw =3D _wfhw;
> +	u32 high =3D FIELD_GET(X1600_PWM_WCFG_HIGH, wfhw->wcfg);
> +	u32 low =3D FIELD_GET(X1600_PWM_WCFG_LOW, wfhw->wcfg);
> +
> +	*wf =3D (struct pwm_waveform){ };
> +
> +	/*
> +	 * A channel that is off drives its idle level. Both counts set means
> +	 * it was stopped with a waveform still loaded: it is off. One count
> +	 * zero is how 0 and 100% are written, and the idle level says which.
> +	 */
> +	if (!wfhw->enabled && high && low)
> +		return 0;

The comment doesn't really match the code, does it? The return value
only ever says 0% relative duty, but the comment also talks about 100%.

> +	if (!rate)
> +		return -EINVAL;
> +
> +	wf->period_length_ns =3D x1600_pwm_ns(high + low, rate, wfhw->prescale);
> +	if (!wfhw->enabled) {
> +		wf->duty_length_ns =3D wfhw->idl ? wf->period_length_ns : 0;

That is wrong if idl =3D inl?

> +		return 0;
> +	}
> +
> +	wf->duty_length_ns =3D x1600_pwm_ns(high, rate, wfhw->prescale);
> +	wf->duty_offset_ns =3D wfhw->inl ? 0 : x1600_pwm_ns(low, rate, wfhw->pr=
escale);
> +
> +	return 0;
> +}
> +
> [...]
> +static int x1600_pwm_write_waveform(struct pwm_chip *chip, struct pwm_de=
vice *pwm,
> +				    const void *_wfhw)
> +{
> +	struct x1600_pwm *x =3D pwmchip_get_drvdata(chip);
> +	const struct x1600_pwm_wfhw *wfhw =3D _wfhw;
> +	unsigned long rate =3D clk_get_rate(x->clk);
> +	struct x1600_pwm_wfhw cur;
> +	unsigned int ch =3D pwm->hwpwm;
> +	u32 busy;
> +
> +	if (!rate)
> +		return -EINVAL;
> +
> +	x1600_pwm_read_waveform(chip, pwm, &cur);
> +
> +	/*
> +	 * Running with the same divider and initial level: load the new word,
> +	 * which the channel takes at the end of its period.
> +	 */
> +	if (cur.enabled && wfhw->enabled && cur.prescale =3D=3D wfhw->prescale =
&&
> +	    cur.inl =3D=3D wfhw->inl) {

You also need cur.idl =3D wfhw->idl I think.

> +		writel(wfhw->wcfg, x->base + X1600_PWM_WCFG(ch));
> +		writel(BIT(ch), x->base + X1600_PWM_UPT);
> +		return readl_poll_timeout(x->base + X1600_PWM_BUSY, busy,
> +					  !(busy & BIT(ch)), 10,
> +					  DIV_ROUND_UP_ULL(2ULL * USEC_PER_SEC *
> +							   (X1600_PWM_MAX_COUNT << cur.prescale),
> +							   rate));

What is the rationale here? You can return without waiting here even if
the setting isn't active yet. But maybe you have to delay writing if the
busy bit is still set on the next invocation of .write_waveform().

> +	}
> +
> +	/* The idle level first, so that stopping holds the right level. */
> +	x1600_pwm_set_bit(x, X1600_PWM_IDL, ch, wfhw->idl);
> +	if (cur.enabled)
> +		writel(BIT(ch), x->base + X1600_PWM_ENC);
> +
> +	/* The prescaler only changes while the channel is off. */
> +	writel(FIELD_PREP(X1600_PWM_CCFG_PRESCALE, wfhw->prescale),
> +	       x->base + X1600_PWM_CCFG(ch));
> +	x1600_pwm_set_bit(x, X1600_PWM_INL, ch, wfhw->inl);
> +	writel(wfhw->wcfg, x->base + X1600_PWM_WCFG(ch));
> +	x1600_pwm_set_bit(x, X1600_PWM_MS, ch, false);
> +
> +	if (wfhw->enabled)
> +		writel(BIT(ch), x->base + X1600_PWM_ENS);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops x1600_pwm_ops =3D {
> +	.sizeof_wfhw =3D sizeof(struct x1600_pwm_wfhw),
> +	.round_waveform_tohw =3D x1600_pwm_round_waveform_tohw,
> +	.round_waveform_fromhw =3D x1600_pwm_round_waveform_fromhw,
> +	.read_waveform =3D x1600_pwm_read_waveform,
> +	.write_waveform =3D x1600_pwm_write_waveform,
> +};
> +
> +static int x1600_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct pwm_chip *chip;
> +	struct x1600_pwm *x;
> +
> +	chip =3D devm_pwmchip_alloc(dev, X1600_PWM_NUM, sizeof(*x));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	x =3D pwmchip_get_drvdata(chip);
> +
> +	x->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(x->base))
> +		return PTR_ERR(x->base);
> +
> +	x->clk =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(x->clk))
> +		return dev_err_probe(dev, PTR_ERR(x->clk), "Unable to get clock\n");

Please make use of clk_rate_exclusive_get().

If you can write a new configuration even if the busy bit is active you
can also call clk_get_rate() here, cache the result and then set
chip->atomic.

> +
> +	chip->ops =3D &x1600_pwm_ops;
> +	return devm_pwmchip_add(dev, chip);
> +}
> +
> +static const struct of_device_id x1600_pwm_of_match[] =3D {
> +	{ .compatible =3D "ingenic,x1600-pwm" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, x1600_pwm_of_match);
> +
> +static struct platform_driver x1600_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "ingenic-x1600-pwm",
> +		.of_match_table =3D x1600_pwm_of_match,
> +	},
> +	.probe =3D x1600_pwm_probe,
> +};
> +module_platform_driver(x1600_pwm_driver);
> +
> +MODULE_AUTHOR("Olivier Louvignes <olivier@mgcrea.io>");
> +MODULE_DESCRIPTION("Ingenic X1600 PWM driver");
> +MODULE_LICENSE("GPL");
> --=20
> 2.39.5
>=20

--gwycectjexu4oivb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrfCZwACgkQj4D7WH0S
/k6XzAgArGS2AVhf28L25Jx3rrX2VDiu/3osTCvpW3QwkjrzTA+rFT8G8OUvjiCM
EGOFA/QJsqfMBpmU2GwiiBymt17QLSkBl9j3U+48+kFnEgVtwhf1VeiaTdEHtVuI
OkiBpFBHXpfoS0osIJH+UgrtbvZ5iU2lOW7Y03YMfFP51qmQntZL1FF7wxYVJdNW
mzhTsWuv+iOVVIiPkf9Q7O3fGkLtuRJIZQgAb6+dX8FhftNh6vMim3R7lrYEqCsi
2J1OfDz5iiiX0p8DOjmdLPNvrKH4Uh3zk6+oXT5WJZv3yuvry4XNAHFbF8KCTgxQ
2AxjpaQl/nM2+I/C5p7qloC0K++dPg==
=6OP/
-----END PGP SIGNATURE-----

--gwycectjexu4oivb--

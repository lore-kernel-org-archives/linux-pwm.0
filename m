Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734B82C0296;
	Fri,  3 Jul 2026 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783094458; cv=none; b=rvIJqr6QEcUv1MT3fj9T61WC6IRLOFSxaSYbT52Z0gJUhoJrZw02e3IAh4Mmwf8OIQDRT4cYPaEkSHGjsnEe6J2rh0SFPKyAL1YVigGx9RNJGOWawOW06HTYit4gLgq/yMCalLppWgEm7VzjnT3VMSVwWhpl6ivUpBLjl6DEt/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783094458; c=relaxed/simple;
	bh=6hagPdbe22KiMs/rgwFE/aaU5MN8++BzsZdpTEe46yI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MvD660M2NDZ2yvfB6tsJHW/FyHFpOAt1pjBnajwEjOQkRb81kI0rgqDtQHYHhNi+qXrz30ieaVE2ZEznam5Lf9qaiNa8RtACxT8qO9cMzviG7fnNraNXsYDOZbXK6wf53hcxjCB1A3ATtUHfrhLNN6rGeyLudaCVJD/aHdVUEVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D67FE20094B;
	Fri, 03 Jul 2026 18:00:46 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wfgJq-005wDU-2X;
	Fri, 03 Jul 2026 18:00:46 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wfgJq-00000000GYt-2okH;
	Fri, 03 Jul 2026 18:00:46 +0200
Message-ID: <3926e4b7ebde9d0fa83c6b4fa15256eab0c7d9e6.camel@pengutronix.de>
Subject: Re: [PATCH v7 2/4] pwm: sun8i: Add H616 PWM support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Richard Genoud <richard.genoud@bootlin.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <ukleinek@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai	 <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland	 <samuel@sholland.org>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Brian
 Masney <bmasney@redhat.com>
Cc: Paul Kocialkowski <paulk@sys-base.io>, Thomas Petazzoni	
 <thomas.petazzoni@bootlin.com>, John Stultz <jstultz@google.com>, Joao
 Schim	 <joao@schimsalabim.eu>, bigunclemax@gmail.com,
 linux-pwm@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, 	linux-clk@vger.kernel.org
Date: Fri, 03 Jul 2026 18:00:46 +0200
In-Reply-To: <20260703152215.192859-3-richard.genoud@bootlin.com>
References: <20260703152215.192859-1-richard.genoud@bootlin.com>
	 <20260703152215.192859-3-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fr, 2026-07-03 at 17:22 +0200, Richard Genoud wrote:
> Add driver for Allwinner H616 PWM controller, supporting up to 6
> channels.
> Those channels output can be either a PWM signal output or a clock
> output, thanks to the bypass.
>=20
> The channels are paired (0/1, 2/3 and 4/5) and each pair has a
> prescaler/mux/gate.
> Moreover, each channel has its own prescaler and bypass.
>=20
> The clock provider part of this driver is needed not only because the
> H616 PWM controller provides also clocks when bypass is enabled, but
> really because pwm-clock isn't fit to handle all cases here.
> pwm-clock would work if the 100MHz clock is requested, but if a lower
> clock is requested (like 24MHz), it will request a 42ns period to the
> PWM driver which will happily serve, with the 100MHz clock as input a
> 25MHz frequency and a duty cycle adjustable in the range [0-4]/4,
> because that is a sane thing to do for a PWM.
> The information missing is that a real clock is resquested, not a PWM.
>=20
> Tested-by: John Stultz <jstultz@google.com>
> Tested-by: Joao Schim <joao@schimsalabim.eu>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  drivers/pwm/Kconfig     |  12 +
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-sun8i.c | 938 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 951 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sun8i.c
>=20
[...]
> diff --git a/drivers/pwm/pwm-sun8i.c b/drivers/pwm/pwm-sun8i.c
> new file mode 100644
> index 000000000000..8f1023e3a2e5
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun8i.c
> @@ -0,0 +1,938 @@
[...]
> +struct sun8i_pwm_chip {
> +	struct clk_pwm_pdata *clk_pdata;
> +	struct sun8i_pwm_channel *channels;
> +	struct clk *bus_clk;
> +	struct reset_control *rst;

The rst field is unused, I suggest you remove it.

> +	void __iomem *base;
> +	const struct sun8i_pwm_data *data;
> +};
[...]
> +static int sun8i_pwm_probe(struct platform_device *pdev)
> +{
[...]
> +	ret =3D sun8i_pwm_init_clocks(pdev, sun8i_chip);
> +	if (ret)
> +		return ret;
> +
> +	for (unsigned int i =3D 0; i < data->npwm; i++) {
> +		struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[i];
> +		struct clk_hw **hw =3D &sun8i_chip->clk_pdata->hw_data->hws[i];
> +
> +		chan->pwm_clk =3D devm_clk_hw_get_clk(dev, *hw, NULL);
> +		if (IS_ERR(chan->pwm_clk)) {
> +			ret =3D dev_err_probe(dev, PTR_ERR(chan->pwm_clk),
> +					    "Failed to register PWM clock %d\n", i);
> +			return ret;

If this returns ...

> +		}
> +		chan->mode =3D SUN8I_PWM_MODE_NONE;
> +	}
> +
> +	ret =3D devm_of_clk_add_hw_provider(dev, sun8i_pwm_of_clk_get, sun8i_ch=
ip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add HW clock provider\n");

... or this returns ...

> +
> +	ret =3D devm_add_action_or_reset(dev, sun8i_pwm_unregister_clk,
> +				       sun8i_chip->clk_pdata->hw_data);

... the clk_hw registered in sun8i_pwm_init_clocks() are never cleaned
up, so this devres action should be set up right after
sun8i_pwm_init_clocks().

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add devm action\n");
> +
> +	/* Deassert reset */
> +	sun8i_chip->rst =3D devm_reset_control_get_shared_deasserted(dev, NULL)=
;

rst is never used again. It should be a local variable.

> +	if (IS_ERR(sun8i_chip->rst))
> +		return dev_err_probe(dev, PTR_ERR(sun8i_chip->rst),
> +				     "Failed to get reset control\n");
> +
> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
> +
> +	platform_set_drvdata(pdev, chip);
> +
> +	return 0;
> +}

regards
Philipp

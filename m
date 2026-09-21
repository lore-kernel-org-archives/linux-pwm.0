Received: from mail-wr2-f42.google.com (mail-wr2-f42.google.com [74.125.225.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A893EE1FD
	for <linux-pwm@vger.kernel.org>; Mon, 21 Sep 2026 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994771; cv=none; b=sRSH7HofGo+8y/HW5dlrOiby8bCe0/D7GxFJcYEvP0qgCKaR0Qr8rsovM0kjGcJ2wbvsNYtwtntcwEb7z2pCywWZNzBeyfZC7B3GZ+PRGWypuJl/M2AYQoTqaeZxs95l7gkkmX76QuHQqGgxKGbG3VhnnsosHPPDfPOLWjPPL2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994771; c=relaxed/simple;
	bh=7R1Rn+2qMXkFEF7BvVUCxelrDSnx+67+3Np2fXUKa84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdQHxC40+VaVo2cL/DS7b708YbPHwhrZ7U4CJd0Fajg7Py7YN7uqAbfdCvu/OiYfZf4ync716y84jX53yqvb3ZDrtNY/M9N7XzLV9V2E/jNUdcfFIJF9ciFjkoZ7q0lH/IYyS2bxMRgLEpUfduQ0jEtsGhmO/cpZ1cbiiHKn8Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=RBkw+hD5; arc=none smtp.client-ip=74.125.225.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="RBkw+hD5"
Received: by mail-wr2-f42.google.com with SMTP id ffacd0b85a97d-482f6351832so1477977f8f.3
        for <linux-pwm@vger.kernel.org>; Mon, 21 Sep 2026 05:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789994766; x=1790599566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VRzt0l54E3ZERRUZPLXC250ltjhNiAUfDutetMT3kZU=;
        b=RBkw+hD5dzaiiECDV+P0jR/36CJjARn/ZYd8e7BY8yQ1SrI2rUDmwYdS+0uiyZqfEY
         LIUQRnrPt8tQhszAUCJy0xzV5j6usICWvrrNV7JUOUR/AwWiYwoHL9QXsRjwOIpVoNBd
         AsmF6vdp24I5wT7NLfR/UDSE2VHmZBOZT0bUcRqz9z6LNTihjTb5yXqKZkw9oDcorcDb
         2Nq9leUIC8jDKgZzvmA8RFENWDT73fLlyq43StivztxQJyGs/4XSDKAnf1CcRHhg1/xL
         2sAv9luyAeP8ePRqRl6u1L8IDDLaLov9kxnCj5NX5jUaKb5febkVZql+q1zIV1efRKVW
         19IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789994766; x=1790599566;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VRzt0l54E3ZERRUZPLXC250ltjhNiAUfDutetMT3kZU=;
        b=WnPos8Fzjp/oT0g7p/d9vmzvW5c94Ki0PA5ON3+z6MGcHsC+ZtAGgL2maFlk3+Zl/6
         jaGlTxE1E7bBt69Dga0FHVCTXl4fIcH0zBWjM1mIRtFbKSKuM/LRevducAlrmsA97pFy
         y4N11ek9HgzUAkQsykmJRctnnJi6PMNCQbzGEUx2l8iEam+cX0r95EuIa39F/pd5dAA6
         ryoOsTFOStZx5rdM1nlNR2NUM2ykHmBTrvF4hNBRx6oC/U2uCUqIhrgfA5sQ6J45xrB9
         g10pSPJFVtg1MhZUdNw/whKMoZKzjWNlFxlFwf0YGf2Ni3Bq3Z/AeTCCcRa6lIi9WST1
         RRLg==
X-Forwarded-Encrypted: i=1; AKwUvBwrouKuh+OQU8D0SOOOS6IezO4MjvDvnjUtbK1Eatw9lurYaqioo6iGx0K8WxxrAXteWVjf0Yy/byE=@vger.kernel.org
X-Gm-Message-State: AFuF++k1LhTh9AwrPNdUAm+gQ6bhJDCCJCCm5GOFZJ4+69AoRcHvMEOe
	UdoHoyy224hUGamCWUP+e4uJ6gItKzdQk4Ni06sUCDV+x4mgs+uQvJpf8JfP4jY9W+PKgMXAqxg
	rRYvp
X-Gm-Gg: AYBFou1APoe2d2Jj2IB17njl9ERtvDKibod6aZ6T+ZmFSjGFSuA9l2NNK9uDqPDy3I2
	6ShwWfCp0VVt4fPWRdEdI7GsHtjb5UTcsTD+1ax3LI/YItyD1ZEzXYC8V4PNRoKNFIXl6SVw2K4
	z/xlODC3XSybdfAHkAt8d34IcXlk3+KQ7VLPIm+74g5dkShd639gYPDU1QE7M3PEpzB5i6/BIhO
	RyURDJT0TwoltJZKgaTLUtKP+63FBLf1HsyP68Vbh+hX6FJg7lbRJXpvapg0E23JIDrjFyGFRWm
	4WlwFfRKiD70nGOd263fzL3LunPFX742DoaJ0YJBZIFsCCY9gVNCPXf6ND3pxvi0SetfMdmyHeG
	enFIdl5gmGrr+CTSMaMbR4vlU1UpAKSE2IRFZgIbkcbI4sKVVPVig8ixAVtAVuuoZ9dTc9wOdOX
	5dIK6tmvREu5H4V+tSzfmJk6bSgRXY7B7yfc398XsoGdwxlTM54zZf5TeeAXCCHyzN7QH3pRWof
	8Ep
X-Received: by 2002:a05:6000:2890:b0:487:370:45d3 with SMTP id ffacd0b85a97d-4871e26e3e9mr13472477f8f.43.1789994766281;
        Mon, 21 Sep 2026 05:46:06 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-487244608e7sm23927472f8f.6.2026.09.21.05.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:46:05 -0700 (PDT)
Date: Mon, 21 Sep 2026 14:46:03 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] pwm: tegra: Make use of dev_err_probe()
Message-ID: <arEiVZG7UqxpqAPZ@monoceros>
References: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
 <641219a7d76bbcd8fe98b5955f2355ed45f55986.1789741839.git.u.kleine-koenig@baylibre.com>
 <arD6ILv1sd8YBUXj@orome>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xmimg5iqxopngnsh"
Content-Disposition: inline
In-Reply-To: <arD6ILv1sd8YBUXj@orome>


--xmimg5iqxopngnsh
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/3] pwm: tegra: Make use of dev_err_probe()
MIME-Version: 1.0

Hello Thierry,

On Mon, Sep 21, 2026 at 11:38:41AM +0200, Thierry Reding wrote:
> On Fri, Sep 18, 2026 at 04:33:45PM +0200, Uwe Kleine-K=F6nig wrote:
> > Usage of dev_err_probe() is more compact than dev_err()'s, emits the
> > error code and handles -ENOMEM and -EPROBE_DEFER properly. Benefit from
> > these improvements.
> >=20
> > Also add a few messages in error paths that lacked an output before.
> >=20
> > Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > ---
> >  drivers/pwm/pwm-tegra.c | 52 ++++++++++++++++++++++++-----------------
> >  1 file changed, 31 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > index 5cdbe120ba2d..efb7ab60f602 100644
> > --- a/drivers/pwm/pwm-tegra.c
> > +++ b/drivers/pwm/pwm-tegra.c
> > @@ -316,14 +316,15 @@ static const struct pwm_ops tegra_pwm_ops =3D {
> > =20
> >  static int tegra_pwm_probe(struct platform_device *pdev)
> >  {
> > +	struct device *dev =3D &pdev->dev;
> >  	struct pwm_chip *chip;
> >  	struct tegra_pwm_chip *pc;
> >  	const struct tegra_pwm_soc *soc;
> >  	int ret;
> > =20
> > -	soc =3D of_device_get_match_data(&pdev->dev);
> > +	soc =3D of_device_get_match_data(dev);
> > =20
> > -	chip =3D devm_pwmchip_alloc(&pdev->dev, soc->num_channels, sizeof(*pc=
));
> > +	chip =3D devm_pwmchip_alloc(dev, soc->num_channels, sizeof(*pc));
> >  	if (IS_ERR(chip))
> >  		return PTR_ERR(chip);
> >  	pc =3D to_tegra_pwm_chip(chip);
> > @@ -331,28 +332,39 @@ static int tegra_pwm_probe(struct platform_device=
 *pdev)
> >  	pc->soc =3D soc;
> > =20
> >  	pc->regs =3D devm_platform_ioremap_resource(pdev, 0);
> > -	if (IS_ERR(pc->regs))
> > +	if (IS_ERR(pc->regs)) {
> > +		/*
> > +		 * devm_platform_ioremap_resource() already emits an error
> > +		 * message with CONFIG_HAS_IOMEM, so don't emit another message
> > +		 * here.
> > +		 */
>=20
> Seems a bit counter-productive to leave comments like this. Function
> comments should document what the function does and then people should
> read those comments. Then we don't need to mention it every time we call
> these functions.

I often deal with bug reports by users where things fail without an
error message[1]. So a usual thing I do is checking probe (and other)
functions for silent error paths. As I fail to follow the (continously
changing) set of functions that emit an error message, this comment is
very useful for a me at least and I'd wish others would add such
comments, too. (An IMHO fine thing here would be to let no generic
resource getter function emit an error message, but that ship has
sailed.)

I'd be open for a shorter marker, that might even be machine-parsable.
=20
> >  		return PTR_ERR(pc->regs);
> > +	}
> > =20
> >  	platform_set_drvdata(pdev, chip);
> > =20
> > -	pc->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +	pc->clk =3D devm_clk_get(dev, NULL);
> >  	if (IS_ERR(pc->clk))
> > -		return PTR_ERR(pc->clk);
> > +		return dev_err_probe(dev, PTR_ERR(pc->clk), "Failed to get clock\n");
> > =20
> > -	ret =3D devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
> > -	if (ret)
> > +	ret =3D devm_tegra_core_dev_init_opp_table_common(dev);
> > +	if (ret) {
> > +		/*
> > +		 * devm_tegra_core_dev_init_opp_table_common() emits an error
> > +		 * message most of the time, so don't add another.
> > +		 */
>=20
> Same here.
>=20
> > @@ -385,17 +395,17 @@ static int tegra_pwm_probe(struct platform_device=
 *pdev)
> > =20
> >  	ret =3D pwmchip_add(chip);
> >  	if (ret < 0) {
> > -		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> > +		dev_err_probe(dev, ret, "Adding pwmchip failed\n");
>=20
> This stands out as very different from other error messages, so maybe
> change this to something like "Failed to add PWM chip" for consistency?

Fine for me, will fix in the next submission.

Thanks for your feedback,
Uwe

[1] last instance was just today, where on a bananapi USB didn't work
    and /sys/kernel/debug/devices_deferred ended up containing:

	1c13000.usb     platform: supplier 1c13400.phy not ready
	1c1c000.usb     platform: supplier 1c13400.phy not ready
	1c14400.usb     platform: supplier 1c13400.phy not ready
	1c13400.phy     platform: supplier axp20x-usb-power-supply not ready
	1c14000.usb     platform: supplier 1c13400.phy not ready
	1c1c400.usb     platform: supplier 1c13400.phy not ready
	axp20x-usb-power-supply

    It would be so easy[2] to add a useful debugging hint here

[2] https://lore.kernel.org/all/b699f8251afed736af454a981630926e45eb7da7.17=
89983244.git.ukleinek@debian.org/


--xmimg5iqxopngnsh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqxJwIACgkQj4D7WH0S
/k6TkQf/eAw5zDfaIbztIoZT+VAAcehCL1/kPn4I4Hi46xzJMzl40YQBF4L7/HXX
8j/EMjuck3VKqQGIVsByUhalES2OtJn7ArCIun6Gv/lNnQ9qAXdkifDnKFWMlg8Y
DwwrEF31d09eQXRZGAJoMiPNCXSCD5ySLfYyAPcL/PitgOWSWecir9tNH3QtvnJs
VUKv9AnmEwZ2pf7omkMU3GSHP97HbFXUll6lLpQn1P0qotsVB04W9becs5poiMuz
JLCEbPnsh5yIh2BDZpmCuskVAGatpRUIITMH3sBapm+zFRmUkGHWnDW59uM/3GMU
jG+1znJHsdEc1YuAhpXZd/lkwzbuWw==
=+P+D
-----END PGP SIGNATURE-----

--xmimg5iqxopngnsh--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4154CB8C8;
	Mon, 21 Sep 2026 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007289; cv=none; b=ud1Kj4y+j6wkDaSx1Ij6cT66/fdpy+94rvR+CvW/KkzC/vDmqlaGiiM4bigCYachSCrJh8IoCmN9SZYYLVxROHiwgmetMfuwKz3KLyIIwnrATCZc8QEzp6kqII22xn8oBONj8avhAkCEg3I8cKsuKyCiJLXQxL/3BWhwplngY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007289; c=relaxed/simple;
	bh=hjXbafy4rxZkXAf8mVKHOJ22dxFdhpv4unxVTvmtffw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zjf0kH2qXUgIdvuqUm0lBB2lwhgpp+n6g0XfAQ5bfxv8qQ44grPjzJmfBOZulSZ/SmhqKqQlGwERzbj9nyuai9DJT9GqwGCAKTTc2GXf5Sn8eDxP4MuIq86Pp18lmebtwy8J90mRkmRrZZhr7Dct1pI37uYD+1aScpisxLnZ1xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmMSZhTs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmMSZhTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BF61F000FF;
	Mon, 21 Sep 2026 16:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790007274;
	bh=ua+CeTf8EeH5BmbofI0sGMgT7vQHm+wg0hsM+OpZO+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DmMSZhTs56oa06SLaeij4alikNuHGjOhr5f4rIV1oMS5IXas0rbrAvC3V2tsntp7o
	 F0S9XOP0ThUYjPxJGHzXkXz+QmVYkEN9inRYxS9UciXXXAAVqHxoMsuIvTbxPDEz9k
	 Z2ETx7ivELdGQnyyYQ/6P3MR2+zFoLuBSCTBYOHqtsioeVO1Wbv0F+7mPokAYXSwoM
	 Wz65RGQbeexV5f2KuvtPjIVU+PaJNvD/ljZIAzid/g5bMQgg3z/KgHivqR0bhKysRt
	 a+QkawJE4CfYDnXCWWrw+HNUSku6RVTZoBJqE1VJ2ZZgGtWjqEMaJlXWxIjsuG3NFx
	 bcgGOIw+eyqnA==
Date: Mon, 21 Sep 2026 18:14:31 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] pwm: tegra: Make use of dev_err_probe()
Message-ID: <arFVjZ7bE2-lgnqm@orome>
References: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
 <641219a7d76bbcd8fe98b5955f2355ed45f55986.1789741839.git.u.kleine-koenig@baylibre.com>
 <arD6ILv1sd8YBUXj@orome>
 <arEiVZG7UqxpqAPZ@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="txouqlewv4ubh273"
Content-Disposition: inline
In-Reply-To: <arEiVZG7UqxpqAPZ@monoceros>


--txouqlewv4ubh273
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/3] pwm: tegra: Make use of dev_err_probe()
MIME-Version: 1.0

On Mon, Sep 21, 2026 at 02:46:03PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Mon, Sep 21, 2026 at 11:38:41AM +0200, Thierry Reding wrote:
> > On Fri, Sep 18, 2026 at 04:33:45PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > Usage of dev_err_probe() is more compact than dev_err()'s, emits the
> > > error code and handles -ENOMEM and -EPROBE_DEFER properly. Benefit fr=
om
> > > these improvements.
> > >=20
> > > Also add a few messages in error paths that lacked an output before.
> > >=20
> > > Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > > ---
> > >  drivers/pwm/pwm-tegra.c | 52 ++++++++++++++++++++++++---------------=
--
> > >  1 file changed, 31 insertions(+), 21 deletions(-)
> > >=20
> > > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > > index 5cdbe120ba2d..efb7ab60f602 100644
> > > --- a/drivers/pwm/pwm-tegra.c
> > > +++ b/drivers/pwm/pwm-tegra.c
> > > @@ -316,14 +316,15 @@ static const struct pwm_ops tegra_pwm_ops =3D {
> > > =20
> > >  static int tegra_pwm_probe(struct platform_device *pdev)
> > >  {
> > > +	struct device *dev =3D &pdev->dev;
> > >  	struct pwm_chip *chip;
> > >  	struct tegra_pwm_chip *pc;
> > >  	const struct tegra_pwm_soc *soc;
> > >  	int ret;
> > > =20
> > > -	soc =3D of_device_get_match_data(&pdev->dev);
> > > +	soc =3D of_device_get_match_data(dev);
> > > =20
> > > -	chip =3D devm_pwmchip_alloc(&pdev->dev, soc->num_channels, sizeof(*=
pc));
> > > +	chip =3D devm_pwmchip_alloc(dev, soc->num_channels, sizeof(*pc));
> > >  	if (IS_ERR(chip))
> > >  		return PTR_ERR(chip);
> > >  	pc =3D to_tegra_pwm_chip(chip);
> > > @@ -331,28 +332,39 @@ static int tegra_pwm_probe(struct platform_devi=
ce *pdev)
> > >  	pc->soc =3D soc;
> > > =20
> > >  	pc->regs =3D devm_platform_ioremap_resource(pdev, 0);
> > > -	if (IS_ERR(pc->regs))
> > > +	if (IS_ERR(pc->regs)) {
> > > +		/*
> > > +		 * devm_platform_ioremap_resource() already emits an error
> > > +		 * message with CONFIG_HAS_IOMEM, so don't emit another message
> > > +		 * here.
> > > +		 */
> >=20
> > Seems a bit counter-productive to leave comments like this. Function
> > comments should document what the function does and then people should
> > read those comments. Then we don't need to mention it every time we call
> > these functions.
>=20
> I often deal with bug reports by users where things fail without an
> error message[1]. So a usual thing I do is checking probe (and other)
> functions for silent error paths. As I fail to follow the (continously
> changing) set of functions that emit an error message, this comment is
> very useful for a me at least and I'd wish others would add such
> comments, too. (An IMHO fine thing here would be to let no generic
> resource getter function emit an error message, but that ship has
> sailed.)

I seem to remember that we discussed both options at the time and the
general concensus was that these functions should provide canonical
error messages since their whole purpose was to remove boilerplate and
about a quarter or so of the boilerplate was the error message, with the
added issue that error messages were all over the place. All of these
callsites are going to print an message for these errors, so might as
well add standard messages for these types of situations and save a
bunch of text. I think overall it's a win, but it comes at the cost of
people having to know that these already print errors.

> I'd be open for a shorter marker, that might even be machine-parsable.

I don't know if an extra marker would be all that helpful over a
comment. The beauty of the current solution is that the error handling
is reduced to just the check and the return value, everything else is
encapsulated into the helper.

There are semantic patches that check for these situations, but I
suspect not everyone runs those. I don't know if we can somehow make the
compiler warn about these situations.

> > >  		return PTR_ERR(pc->regs);
> > > +	}
> > > =20
> > >  	platform_set_drvdata(pdev, chip);
> > > =20
> > > -	pc->clk =3D devm_clk_get(&pdev->dev, NULL);
> > > +	pc->clk =3D devm_clk_get(dev, NULL);
> > >  	if (IS_ERR(pc->clk))
> > > -		return PTR_ERR(pc->clk);
> > > +		return dev_err_probe(dev, PTR_ERR(pc->clk), "Failed to get clock\n=
");
> > > =20
> > > -	ret =3D devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
> > > -	if (ret)
> > > +	ret =3D devm_tegra_core_dev_init_opp_table_common(dev);
> > > +	if (ret) {
> > > +		/*
> > > +		 * devm_tegra_core_dev_init_opp_table_common() emits an error
> > > +		 * message most of the time, so don't add another.
> > > +		 */
> >=20
> > Same here.
> >=20
> > > @@ -385,17 +395,17 @@ static int tegra_pwm_probe(struct platform_devi=
ce *pdev)
> > > =20
> > >  	ret =3D pwmchip_add(chip);
> > >  	if (ret < 0) {
> > > -		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> > > +		dev_err_probe(dev, ret, "Adding pwmchip failed\n");
> >=20
> > This stands out as very different from other error messages, so maybe
> > change this to something like "Failed to add PWM chip" for consistency?
>=20
> Fine for me, will fix in the next submission.
>=20
> Thanks for your feedback,
> Uwe
>=20
> [1] last instance was just today, where on a bananapi USB didn't work
>     and /sys/kernel/debug/devices_deferred ended up containing:
>=20
> 	1c13000.usb     platform: supplier 1c13400.phy not ready
> 	1c1c000.usb     platform: supplier 1c13400.phy not ready
> 	1c14400.usb     platform: supplier 1c13400.phy not ready
> 	1c13400.phy     platform: supplier axp20x-usb-power-supply not ready
> 	1c14000.usb     platform: supplier 1c13400.phy not ready
> 	1c1c400.usb     platform: supplier 1c13400.phy not ready
> 	axp20x-usb-power-supply
>=20
>     It would be so easy[2] to add a useful debugging hint here
>=20
> [2] https://lore.kernel.org/all/b699f8251afed736af454a981630926e45eb7da7.=
1789983244.git.ukleinek@debian.org/

I see. Yeah, I find it increasingly difficult to remember all the
context of a function call, whether it is that it prints an error
message or needs some lock to be held, sleeps or not. Sashiko has
been really good about pointing some of those things out.

Thierry

--txouqlewv4ubh273
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqxV+QACgkQ3SOs138+
s6HNoRAAgmI2ZiLP12EH1r2UHrED9HjWYRfSeR9ci+2l2B+V3RePnm7bigCLLLNJ
25NqRe/9mcjMt2f4o+r/2dIePPYHiI/4p+G35Jlz1HRsNt1tdcKfBOx4KngpBb8A
/QJJgjuI3TAWXkApJUs9eiyZxDdqZcb6kHFBc2eemYslUSPTTNTcYH0+Fh/IxL3N
Pn9VFlT9KdExN9dluSQmGyvy6L79KO0rHh1Gz84E9lYTGjGOjfNjDtYn/6ty8/ku
rBB5mISZ+W1Lap5cndnGxHEJmo0wsXMjRX4E6SvOXQ9I+k50MZEX52qCBl8cmaVI
XkiNmyUV2uuvREclt7NY4Mz3b4yYrB4osO8leVAATF3YXbuoE3/o6XVsA5DX538x
Ii61rQOTKnAaGZypkvX0HLlbmw3XpQ07x3rLA1RYIu8nAs6lCGZ+rZkv+YpOdYMz
TjF2IumAF6cnDB0HMf+BPLIIuvQpogy2oGzVPNnbtsJi5vszklcqHyTlnDksnlnd
aD83rVOwnhdi1hANL8laiEpI6oy+JWNZLpzNjY1PrlS3d4yJiYn73xzio3GJR1i4
gbiYc6DqtZgOT0UIXMUtic2whkPV4PHlbxMCdTl1Kl8BQeeqGGM/MTCslsBH0FXr
QK3O20XZe71KV3aT2SjRag3riGVoPppqqyOdEad2axDUe763DvI=
=tQNN
-----END PGP SIGNATURE-----

--txouqlewv4ubh273--

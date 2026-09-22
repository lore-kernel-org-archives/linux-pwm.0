Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE706424D41;
	Tue, 22 Sep 2026 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071651; cv=none; b=K5eHiTvvziEXZ2jE2RhC4pL2d7ShAULx2F4vjkI/mZkoxZHCsX4NzW7/kjWz5WC+EFXdrXd5XQzE+mnhwBO6GZn2bFkZD43qshWIFIjKKRYkqwo/MRJfXr6eWUV9E8J7uDCUEIaryA58k8AdnfyJ5xxpUX8+bQRblEJZm9+AqrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071651; c=relaxed/simple;
	bh=2y6rfd3V6t8r63itiesJ7pNBadW8mVuB/RTG4AHuQlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zz8EVV7oFODlY5sHAQGYKdUT/UGmFH0npfdl08t/riqwiQHMLbAsMTMSwxHth5AGafvp6uGnNsu/gU+k/BkbJ9zGZ0UXi8FoOznJLPKioVtICEgjdVmaKv2/ZRHlU3RGmxs6fNwwjB/Z8FpvgRpvfkByp+yjki83R+QOrP+T2VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlaYSpBh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlaYSpBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25081F000FF;
	Tue, 22 Sep 2026 10:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790071648;
	bh=hwh+K2v/178tY1KA4Ry1KdU4gEsYtzRfHe28rjIAvaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JlaYSpBhIogs5L+R0VqdS/wOu7Uup6pb/dxidITuX3OWvWO72fbVPcM+0pV1XIy/W
	 FZ2uXAp95b1N6ZfVyywbSTIx8PcinVh1Mn03Rjb7FtGV1HFmuYP8caqjFG96zwzqUm
	 zHKQ+7vLDnjg/Rrfd6xH+K1PjQ6+t5DvIU9M0J/FpCFUQIgxselxDKsSFFQlpvK4S/
	 zRMJ3BOm9DJjIVxgi+0joF4DT/U1edWGVD1ufSFjt3J486N9WGka04SZbJIb6wr8MB
	 TUuRZ4IeE9e1+J0KYj/qXJ8htdFt9Lf6gx5sQeIjRRKn1ePHA/jZgo+sHecZmcW9LP
	 KMIu2YMQFt3Fw==
Date: Tue, 22 Sep 2026 12:07:26 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Ola Chr. Vaage" <ola.christoffer.vage@scoutdi.com>
Subject: Re: [PATCH v2 3/3] pwm: tegra: Implement .get_state()
Message-ID: <arJTSEfkILPQmqNV@orome>
References: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
 <b72b16cf704aa662a1b49805db284379d4fa4050.1789741839.git.u.kleine-koenig@baylibre.com>
 <arEAjOHU4rH5aGqb@orome>
 <arE932ZcHGB8RAN6@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yq6y463pp52ksygm"
Content-Disposition: inline
In-Reply-To: <arE932ZcHGB8RAN6@monoceros>


--yq6y463pp52ksygm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/3] pwm: tegra: Implement .get_state()
MIME-Version: 1.0

On Mon, Sep 21, 2026 at 04:26:03PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Mon, Sep 21, 2026 at 12:18:16PM +0200, Thierry Reding wrote:
> > On Fri, Sep 18, 2026 at 04:33:47PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > The registers of the PWM IP are readable. Use that to implement the
> > > .get_state() callback.
> > >=20
> > > Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> > > Tested-by: Ola Chr. Vaage <ola.christoffer.vage@scoutdi.com>
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > > ---
> > >  drivers/pwm/pwm-tegra.c | 48 +++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 48 insertions(+)
> > >=20
> > > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > > index b461d3877f43..0520d025c776 100644
> > > --- a/drivers/pwm/pwm-tegra.c
> > > +++ b/drivers/pwm/pwm-tegra.c
> > > @@ -310,8 +310,56 @@ static int tegra_pwm_apply(struct pwm_chip *chip=
, struct pwm_device *pwm,
> > >  	return err;
> > >  }
> > > =20
> > > +static int tegra_pwm_get_state(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> > > +			       struct pwm_state *state)
> > > +{
> > > +	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
> > > +	int rc;
> > > +	u32 val;
> > > +
> > > +	rc =3D pm_runtime_resume_and_get(pwmchip_parent(chip));
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	val =3D tegra_pwm_readl(pwm, pc->soc->enable_reg);
> > > +	if (val & TEGRA_PWM_ENABLE) {
> > > +		u32 scale, pwm0;
> > > +
> > > +		if (pc->soc->enable_reg !=3D TEGRA_PWM_CSR_0)
> > > +			val =3D tegra_pwm_readl(pwm, TEGRA_PWM_CSR_0);
> > > +
> > > +		scale =3D (val >> TEGRA_PWM_SCALE_SHIFT) & ((1 << pc->soc->scale_w=
idth) - 1);
> > > +		pwm0 =3D (val >> TEGRA_PWM_DUTY_SHIFT) & (2 * TEGRA_PWM_DEPTH - 1);
> > > +
> > > +		if (pwm0 > TEGRA_PWM_DEPTH)
> > > +			pwm0 =3D TEGRA_PWM_DEPTH;
> >=20
> > It feels like this has too many assumptions built-in. That's mostly a
> > predefined issue, but I think if we want to get accurate hardware read-
> > out, we need to address this.
> >=20
> > According to the register documentation, the PWM depth is 16 bits wide
> > (on generations where it can be programmed). The value defaults to 255
> > (which is n - 1 encoded, hence TEGRA_PWM_DEPTH), but it can technically
> > be reprogrammed to any 16-bit value, as far as I can tell.
> >=20
> > So I think for this to be correct we'd need to read out the actual value
> > before overwriting with TEGRA_PWM_CSR_0 contents above. At that point I
> > think we'd need to either adjust the mask to be (2 * depth) - 1, or
> > maybe better yet, avoid masking it out arbitrarily based on the depth
> > and instead cap it at depth so we never exceed the 1:1 ratio for duty
> > cycle vs. period.
>=20
> As long as .apply() also hardcodes TEGRA_PWM_DEPTH, it's IMO fine that
> .get_state() does so, too.

Okay, fair enough.

Thierry

--yq6y463pp52ksygm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqyU10ACgkQ3SOs138+
s6F4MQ/9EH+9WXVcAEauSWTHfQfBYZQong8bCSxqlh3YXSdOH6+QS9T54+FeEhdw
tLyg1gIzLCg3Dzex/nkGeQo/hC90bUo7LhRKajdj8BH78QOE4Jcrf66tbd1FXutX
c0O/uLyWwtAL4NUr45fE9evQqPMYmzbCz7HMe1lxo3zCsfZz3iUdOTDvrm1l7QG5
W0aI7Yu88rd3OjlH6jMEd1o6VIS4reYiERNRCcjr26faAE696ydA+5oUVkwXI2JZ
s++Nr6AARi4cFmZPJDaPpxPjZpNzZ18slrBNrKvSWXblRowXuya1zx9pyiMXl7n8
BU0vhWo6E/1Zb4cm1k0HySUEVOTVsGLQWT8ztvUJEiCAd+1VeNRqmPY/tVd9gvZR
dZl5LuU8PFm7GvhWi97B5CAQbzwf5/kb9KdfOcZKPgamQz6Hx+FaHC/VDtWypoU7
thp9l7fiL8wGjp0gxxIdKZL5oLa/qwUGHhsj7qQF+LefIv2XmE+w+IeuR9dvgueG
nZSv2nAy0MP2pBZ5nEysp5Hoip/mKhHSXsRg0DXeUNG6b4p8Il1AGnBHAR8TO/rF
3DAmTsfdLfjEFnGfx1SPGf1yfjCyTxJZn2S6Tys6MplLklFJ0lRnWFSNtmwwa9jY
EATSv8FgXgZZwXoVfn6ZDErO0HpF/66pNKbQOIZFXkjaNsSJLWg=
=YvDB
-----END PGP SIGNATURE-----

--yq6y463pp52ksygm--

Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436574756B8
	for <linux-pwm@vger.kernel.org>; Mon, 21 Sep 2026 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000769; cv=none; b=lLj1cS6YuMEBEdigPKDSdrz7BoKBW2KBq+6ufqNS74BzNJ0XtpgxtNefwyBN9/8gx2DYH7UFpM6QQ00omE8SIpNS3YitmexnE2pl4I1ehAAK5EaHZM/8ss5+i/QVAIXmY6xGESV6YAjGgKZaaFSxVVR+9XesWd0REMeB48aQYwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000769; c=relaxed/simple;
	bh=u79GVvIrNgovGs36Fao9Rh6cQHN/TgXSWpa2Q+lis6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKs6KRsVRL3MJom6EyxyT7kuwoXyrk/Cq2gGt1x6kPbf3mVKcXOun45D0AhpkGCkbTl7wiJweNYVSMGDNjJBp98IWD2C43n/zX5Q91SwZbVe27U6d0u1RuR7jVTzQZ4TtB41HgRnKsMAFKYPNkLP2SVlk4nQBpmk2cMwqRd7NvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=l1Ea1RHV; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="l1Ea1RHV"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485984ebf5cso2425783f8f.0
        for <linux-pwm@vger.kernel.org>; Mon, 21 Sep 2026 07:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790000765; x=1790605565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fKaXtSv/kbKul4ZN5Cjuy3lIzweY+anlAeJnxQKsOuk=;
        b=l1Ea1RHVmAsB0z7ojHjSr2xmmjYcjdH0qvg0JMOGJQm6HSEco0QARF+Rot97So+0Y/
         ZlBB6qtQCXX4ZD337dxI2fAvQc3yjy2AZn/pbHgEqZqQDAXN9ftI9i/DYoGpFQXCxJU3
         MiHACGJOxC9SKBWXtPs6jj7NKH7tilEDNChcgcDne8CE9OubcnSt54bEH+yquwgIJO4L
         gdPwFGCOWuaJWPnC3NppLC1Ay6xqzewUGfyFCrSV/g4BMhCmlftKFYdAZPvQKjLbFeeD
         lQqNgz9xk3VeYRoDoB59ZO89uJSyqG5YsUt1bvVD9Y5WutWv055qKBvofEqxmGvmhObw
         kjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790000765; x=1790605565;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fKaXtSv/kbKul4ZN5Cjuy3lIzweY+anlAeJnxQKsOuk=;
        b=jFIbEvYWliuCVHHrL4/AfRlM4DR15DYABFt8bnRQPNJyjZJSYCQlKfxElPF7QJ28mW
         HA0MuUWp59E+pxNXbyfShalxBF5Z3O/RUrGxMEt0jt+UbGL7T98t5H8jpiaKjhBxzvoq
         gQv0Ju8F4sgmBbLruXdUNqP+HHTvSgD5rr/fUH5nXDODp/BpzFTorrl6w86YECG4oS12
         g+p0Ld2GhJGra/sOsXhIb+89NwdsA8vzVP7QFYBmnqXi+yJBiO5mWmdtTZPDG88WHe7G
         nCSi+e5Q8XfjSSUDTXUENOUlNkmsYLY/Sb72//V7I70iPn5wBeL2GxjN+uPaJCLmeZxN
         4Qig==
X-Forwarded-Encrypted: i=1; AKwUvBxIFmDfLQ36QZyQHF5yX/+k6U0x5Asmh1YxncpOGvdry8vSm18XASDE2jRE4/jAMicvRXyPooRQbbU=@vger.kernel.org
X-Gm-Message-State: AFuF++laSPl5SKqt5q6OGBl4Bd8k2sOtmtZ6rVYRw63kqoRSU6MOOB3O
	jj2hzUq9b6nDahwXagi0UhNYdmOwMFk2kHZdKocX8W/RJ1gP2APtv0kRpCuZgYsqNV0=
X-Gm-Gg: AYBFou2F/4QcNYnJcXwwZL58MrtZRJXkGMCrglbaNQvS/uXRtK3BIps3UERbKmnQi0H
	8DY/mQI8vYP3u1MCtdHRlscoeiC1BWaKTM6xmzog4XSvYyeNbfIDfZm3G5GmVUYZF+sky4lFKwK
	siZh1hTRR/AAxtAGfmYD+Y/Kgu1e53ipx03BloOMG2Y1X3e5+uCJT/c8xqNW7Eccr+dyb3/oKXi
	JaXzEsMq12xRRqIDGB7Uim9VksqDSC99bsWXVQXiHmqSgYnjfRthc0XEQI/KbujaLFwE15qmcmh
	OeiHUw967Sb4GydDOfzdsuofvYY0Ja9Sz61Cp/N6m+QevaarJ1UIa6MCPjsSoCm1tByRTiEg5Pe
	lg6hNhCTH4KuFVc57ULbhbCCZPO9v4ipNmds06hIVcTzpG/fgDVaQCe9prAViB+M182PlpF6wWL
	hoDZVoq/pp3iciCwm8tRRp5rOo/oE9cp2ujcc101mdU/cQt8jOQMIvBIhSjvTYB/kL/xxZ2F+xn
	mlMzmvYLVaMeiDF+hcrmqERyWPfH6zAY0rge9ldt4rwTfqaS0PY69OtKJpQUw==
X-Received: by 2002:a05:600c:c8f:b0:49e:6c9b:4e94 with SMTP id 5b1f17b1804b1-49fc5743124mr150664255e9.28.1790000765458;
        Mon, 21 Sep 2026 07:26:05 -0700 (PDT)
Received: from localhost (p200300f65f19a904d4f76eed31f2ef79.dip0.t-ipconnect.de. [2003:f6:5f19:a904:d4f7:6eed:31f2:ef79])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4872459f446sm21874677f8f.35.2026.09.21.07.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:26:04 -0700 (PDT)
Date: Mon, 21 Sep 2026 16:26:03 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Ola Chr. Vaage" <ola.christoffer.vage@scoutdi.com>
Subject: Re: [PATCH v2 3/3] pwm: tegra: Implement .get_state()
Message-ID: <arE932ZcHGB8RAN6@monoceros>
References: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
 <b72b16cf704aa662a1b49805db284379d4fa4050.1789741839.git.u.kleine-koenig@baylibre.com>
 <arEAjOHU4rH5aGqb@orome>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qkbghpdorbcu5kso"
Content-Disposition: inline
In-Reply-To: <arEAjOHU4rH5aGqb@orome>


--qkbghpdorbcu5kso
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/3] pwm: tegra: Implement .get_state()
MIME-Version: 1.0

Hello Thierry,

On Mon, Sep 21, 2026 at 12:18:16PM +0200, Thierry Reding wrote:
> On Fri, Sep 18, 2026 at 04:33:47PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > The registers of the PWM IP are readable. Use that to implement the
> > .get_state() callback.
> >=20
> > Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> > Tested-by: Ola Chr. Vaage <ola.christoffer.vage@scoutdi.com>
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > ---
> >  drivers/pwm/pwm-tegra.c | 48 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >=20
> > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > index b461d3877f43..0520d025c776 100644
> > --- a/drivers/pwm/pwm-tegra.c
> > +++ b/drivers/pwm/pwm-tegra.c
> > @@ -310,8 +310,56 @@ static int tegra_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >  	return err;
> >  }
> > =20
> > +static int tegra_pwm_get_state(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> > +			       struct pwm_state *state)
> > +{
> > +	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
> > +	int rc;
> > +	u32 val;
> > +
> > +	rc =3D pm_runtime_resume_and_get(pwmchip_parent(chip));
> > +	if (rc)
> > +		return rc;
> > +
> > +	val =3D tegra_pwm_readl(pwm, pc->soc->enable_reg);
> > +	if (val & TEGRA_PWM_ENABLE) {
> > +		u32 scale, pwm0;
> > +
> > +		if (pc->soc->enable_reg !=3D TEGRA_PWM_CSR_0)
> > +			val =3D tegra_pwm_readl(pwm, TEGRA_PWM_CSR_0);
> > +
> > +		scale =3D (val >> TEGRA_PWM_SCALE_SHIFT) & ((1 << pc->soc->scale_wid=
th) - 1);
> > +		pwm0 =3D (val >> TEGRA_PWM_DUTY_SHIFT) & (2 * TEGRA_PWM_DEPTH - 1);
> > +
> > +		if (pwm0 > TEGRA_PWM_DEPTH)
> > +			pwm0 =3D TEGRA_PWM_DEPTH;
>=20
> It feels like this has too many assumptions built-in. That's mostly a
> predefined issue, but I think if we want to get accurate hardware read-
> out, we need to address this.
>=20
> According to the register documentation, the PWM depth is 16 bits wide
> (on generations where it can be programmed). The value defaults to 255
> (which is n - 1 encoded, hence TEGRA_PWM_DEPTH), but it can technically
> be reprogrammed to any 16-bit value, as far as I can tell.
>=20
> So I think for this to be correct we'd need to read out the actual value
> before overwriting with TEGRA_PWM_CSR_0 contents above. At that point I
> think we'd need to either adjust the mask to be (2 * depth) - 1, or
> maybe better yet, avoid masking it out arbitrarily based on the depth
> and instead cap it at depth so we never exceed the 1:1 ratio for duty
> cycle vs. period.

As long as .apply() also hardcodes TEGRA_PWM_DEPTH, it's IMO fine that
=2Eget_state() does so, too.

> > +		/*
> > +		 * scale + 1 is at most 1 << 17, TEGRA_PWM_DEPTH is 256, so the
> > +		 * multiplication for .period doesn't overflow a u64. With
> > +		 * pwm0 =E2=89=A4 TEGRA_PWM_DEPTH, .duty_cycle is also fine.
> > +		 */
> > +		*state =3D (struct pwm_state){
> > +			.period =3D DIV64_U64_ROUND_UP((u64)(scale + 1) * TEGRA_PWM_DEPTH *=
 NSEC_PER_SEC, pc->clk_rate),
> > +			.duty_cycle =3D DIV64_U64_ROUND_UP((u64)(scale + 1) * pwm0 * NSEC_P=
ER_SEC, pc->clk_rate),
>=20
> Maybe as part of the above this can be broken down a bit to make it
> easier to read? Something like:
>=20
> 	u64 duty_cycle =3D (u64)(scale + 1) * pwm0 * NSEC_PER_SEC;
> 	u64 period =3D (u64)(scale + 1) * depth * NSEC_PER_SEC;
>=20
> 	...
>=20
> 	*state =3D (struct pwm_state) {
> 		.period =3D DIV64_U64_ROUND_UP(period, pc->clk_rate),
> 		.duty_cycle =3D DIV64_U64_ROUND_UP(duty_cycle, pc->clk_rate),
> 		...
> 	};
>=20
> is a bit easier on the eye and would make checkpatch happy (or happier).

Fine for me, will address in the next revision.

Best regards
Uwe

--qkbghpdorbcu5kso
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqxPnkACgkQj4D7WH0S
/k77Kwf9HxX3gL2kjGUKkvvjXebMyyfQxZRXgqCU/pg12x5boLb18HblbZUDfnsX
d19SKdoOiLJ/HAWUgKF9O9XA1RN60DhMjkBSUQgOKWd8J0397yW5YcTyoXsWM7FU
+dLfLHUj9S4Mv12ZWdpUOsAzdqOeJmdcGwby+OE7WjUc7B7mgcHg+SiBL+0QhA+z
iye5Tag5LBtF/E6nCniBQV40ZFYME87gLKhtnZ6TrIKjGcw0TIEMb+fprw1Zm0ST
gV1hPx94YVT37Gf1sOCC945uutgq6b7iivRlk0o+wetKxUANXbdbjRbOZ3S98OOL
8L8Ibx6QLCqRAH4q0ud2Vk+nhi1FQQ==
=KT2n
-----END PGP SIGNATURE-----

--qkbghpdorbcu5kso--

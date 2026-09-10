Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676BD33C198;
	Thu, 10 Sep 2026 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048481; cv=none; b=DPj149mSKXFvX9jh2SkiXAy281j5Me6eFhO/KjI6jzfoukM6T3MTIgl4o+lDTd3n78IOvx1adKRmxdd1Pp4ZMduC5U/HZCasTgLoQLfWycVhTB+ddgxZZXJQG504mbdwJBH+C5Pmrxn9/DpOGnlfv0TpgI7Nj++JCUSipCwyoPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048481; c=relaxed/simple;
	bh=mTrdQfr7DOq6u+bICsUuHKijxfpQHZmd25ZL8e/2nwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+dtbcgg99MehN21wIAL4jJNCtUQPKuidA4Kcj/Ldq0FLffOey4/j9ObA6GI+faqHdx2IXKylz4CvPqM6+SVeHxgZaurl+6Rps3wAXtZD4VcDa6Dii4ST69bs93pflPPmey3OUtDJa+EGm8E3OqnfDVM2qjHepl0qKsoK8ilepE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHG5p0zj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHG5p0zj"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BE3C41F000FF;
	Thu, 10 Sep 2026 13:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789048480;
	bh=HqCghc0dDgDGFGeCMu0QA4P94gGXXWs5rdtW9NG33l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XHG5p0zj8EehcWzdCkhUnpcuB0KxM6+ZK0p0PpE04Jg8gnz6LDlMRzAOv1zmJCF0v
	 Ni+4f3REh5hq5ZCgMhEOsQPUT7yfTMvfkxGwKs+i22C0gy6ISqARRQ/wkddOP+2oJJ
	 G9AQLgcdii+WbMhzaWqIi5mGVpGm2XKBOHqoc23hsfPVWTQ8CG4mKZC6huQl27DkvA
	 hMmmwjr6vE5MSl8RRfUoNf+S/ZqiXTjf5HyYXU1BvNhFs36btWKxDwSYBFiRgQmLC5
	 MQ/Uc4SS4eX0VpaHauNlqMAoluj+s7STogW+y1DG5q7PCx9QWoHOWichArYPJA4n/6
	 /U0blE7LrxT7Q==
Date: Thu, 10 Sep 2026 15:54:37 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] pwm: loongson: Reload PWM configuration through
 counter reset
Message-ID: <aqK2R9HodI399ehb@monoceros>
References: <20260715-pwm-loongson-fix-v3-0-0aab2847eaa7@gmail.com>
 <20260715-pwm-loongson-fix-v3-2-0aab2847eaa7@gmail.com>
 <ap6Ciw_sMALvlROd@monoceros>
 <CAJhJPsULo0S5c6GKQvRqLtVx3nixZLuqRrh7hi5yJ7C5BuwLUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6qgygejms54hbaw3"
Content-Disposition: inline
In-Reply-To: <CAJhJPsULo0S5c6GKQvRqLtVx3nixZLuqRrh7hi5yJ7C5BuwLUQ@mail.gmail.com>


--6qgygejms54hbaw3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/2] pwm: loongson: Reload PWM configuration through
 counter reset
MIME-Version: 1.0

Hello,

On Thu, Sep 10, 2026 at 07:58:12PM +0800, Keguang Zhang wrote:
> On Mon, Sep 7, 2026 at 5:33=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@ke=
rnel.org> wrote:
> > [...] I wonder if the fix is incomplete. If at driver bind time
> > LOONGSON_PWM_CTRL_REG_RST isn't set and there are still wrong values in
> > the shadowed LOW and PERIOD registers the first period will be wrong.
> >
> > This would need:
> >
> >         val =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
> > +
> > +       /*
> > +        * Ensure that the values of LOW and PERIOD are sampled into
> > +        * the shadow register when the hardware starts running.
> > +        */
> > +       if (!(val & LOONGSON_PWM_CTRL_REG_RST))
> > +               pwm_loongson_writel(ddata, val | LOONGSON_PWM_CTRL_REG_=
RST, LOONGSON_PWM_REG_CTRL);
> > +
> >         val &=3D ~LOONGSON_PWM_CTRL_REG_RST;
> >         val |=3D LOONGSON_PWM_CTRL_REG_EN;
> >         pwm_loongson_writel(ddata, val, LOONGSON_PWM_REG_CTRL);
> >
> > I think.
>=20
> You are right that this patch doesn't handle the initial hardware
> state when the driver binds.
> Would you prefer that I submit a follow-up patch to address this, or
> are you planning to fix it yourself?

I don't have the hardware, so if you do that and test it, that's very
appreciated.

Best regards
Uwe

--6qgygejms54hbaw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqitpsACgkQj4D7WH0S
/k6V0Qf8D+LtoF2zkOqrIdgM9dzTiGKevyWqyWJWrOousQ/Nn41ocg8ngKcDQ7Rp
cNkWyC5sqHr7VBGkrr9g/zLQz0+2z5z/FVXpsHVnOHSm3i63SgLNECqhbDCE0CNX
YKEV5a1wsmkO5xS9o/9aP9TX/rJo/pnENHaY5W1gpqIY+DoOzpP1cKeK/NtJ49ry
ddImwtl2Npb1T7i3UW7Mj7N8lO15mFGSs9g5waXARlJKpHcCjtS4XbCrzWJgx5ms
xJhkSK9R4J38vzjTsMZ9OT0y6uCTopCns84ICw/rhyuVX03JtCJLAZsaAKJ4Hbxp
0tvf+Z35h2exq0ohhVyKUt8Rjf/wfw==
=rXmE
-----END PGP SIGNATURE-----

--6qgygejms54hbaw3--

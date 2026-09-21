Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C212D3EFD21
	for <linux-pwm@vger.kernel.org>; Mon, 21 Sep 2026 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021434; cv=none; b=BkKhxN7ZEalFTeRhsbbawaL/5nvM06iJcephlTB0Y28IuOaZVslaKAD1D592sQr+PCQjEFXS39ooK8nl+yVC5kHIRlXV5BeiHw8vszCEq2gLwvMmla0V9I9eDgp1c0TbDuXqtl35jsGottZrLvglu0I9s/j7OASkXTDkh9OD04M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021434; c=relaxed/simple;
	bh=taNf5/Tp609jJz/o1QdibWPNvIDa5FOtcz4S5G+LZAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=br4h1C0/1BuiWHPJd1EP1Tum7fuscbedeRFHFfh533r2YTga8TZJ0G4yG0HqtO45yUvVBsWZtSerPihMNh3ph3JDvDsXP9P2a9QbmvRDs4RaeSzj3iH2VTYLFLshoegb2nVUOdJWKGRrfmuDI3FFiKmS84sS0byzWcPxXCHqU7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=chOV7XAg; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="chOV7XAg"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71cdb22bso25571375e9.2
        for <linux-pwm@vger.kernel.org>; Mon, 21 Sep 2026 13:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790021429; x=1790626229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=edJlGdsW+IzYIhpth5aaFdSHP7ncbtzcihxUtYZk784=;
        b=chOV7XAg01OVsX4Ktfp/MgviXWtEq9TQu5jgdXpX+xvMvjO4aHu975l5xrntARDQLe
         ZhKFr+XyGwhojOYmIglgBWQL/7tX9dLPyre7i+O0Wbz63qPhijgqIBLhF+p7xRyuX8vU
         KxmmhaYTFtFlasxNuAmuieLT4K40sPWkQP/2VK6lDfszt2kCW4s4YDdr7upvSEzaIAzb
         e/SsZDoeoldR590iOzzXaEMasZUFmcTFXqMeGCn4ZHlRtDtSfexezw6Dw23I6Qb+S65w
         IA4JNY4Q8qxDXgm+M0mQ8qtptDptBSOaGCXXdvW7JfrYUX0LNGrxH9FvBj9J5BiUpQVC
         P6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790021429; x=1790626229;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=edJlGdsW+IzYIhpth5aaFdSHP7ncbtzcihxUtYZk784=;
        b=y21BC8FvRYDi819kC8j5OSCFTliEoPex28wjUNNCtlsCSduWO14m1fyN9SVY7DPcCT
         9IE6/YivyrQLsc6rsLN07FWHFqW5r6PVwsr0SkLBi681iaj0kvwvSLIZVVgGCFG2tdog
         1QzTihYhibJFSrz1kLDwARiEzoeXCDcd2w0inooKhxbvLVxJ3sBGSJwdXaPyAl1YcDAG
         P7SeQReendDrsK6fb3ozut6hPjspYgpLQ+F633ndTH6I2vu6N2GM3H+n421uzZjkHd87
         3t97UvKHanPyygF5RRY86eBktErQ+UlihY3svhdTILiyFNS8XI8fJ1B5G5SsEBI+PPUB
         8lhA==
X-Forwarded-Encrypted: i=1; AKwUvBxcQnTrcdafNHwypxxyCCHViqA1z1HuJt9s5XnP261aRE0+mePK6U5cwlrtxLuZO4ycNKsXG5tjI4M=@vger.kernel.org
X-Gm-Message-State: AFuF++mF0l0YYcgDby4Yu92n+wEclxAlN6+9uO+Q+nNt2tVCXDqgXz7L
	/ZyNkpZqV65Nnc38S4GKjTIqgd3oEwuDoqKU/QgJ8aj+FlwA+TpUiZWUu4Y/8qfc3mM=
X-Gm-Gg: AYBFou3FdujVIQcKaR0QTPAmMIXSQVBE3fQtMUC2yhyXgP32vK+L+97L2JqvuRhrpkI
	t/NplTlRK4dlzJCcUnotdi6xC84ttfPf/klOau+O0/8uRzshY6uy0fLUgpmrVn9qjNnWwfrTsY3
	NGzjrtDSVkk0KixomaT0MglQ9oyqQAzgLmdVjtupIPLqsUv/7b/hHvoZf4+OO++4bugG7BvgUcK
	JB018WDDt7F16BO7egOFXmT7ShHWMitXxPEUem4aqpc3wyrP1NLCqdR9cYe1mWG22Kvw7x7x0YI
	hVzeElGmXYhAuoal6OxU4ubMiGTghtDXF5GkTvE/M7+vSz4U2rgzllJ/riuDR1PVDXYeIoMY34v
	uWtecWjkWd+VZPh1R4kCVhVx4APrx31Daz2ALIhaVvgaBigKPlF3nD1gEoil2XxVg9pRwmREOym
	9teJXGcC+31jRSAD0XX+OnR3H6wg4gOVPpH/ByWZIQacCLCqcpflvN7Vq124mb9nqqmSgqNkKPX
	+PO
X-Received: by 2002:a05:600c:4ed4:b0:49c:cee2:a508 with SMTP id 5b1f17b1804b1-49fc5728f9amr149860325e9.16.1790021428998;
        Mon, 21 Sep 2026 13:10:28 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49fc59286b6sm251754085e9.4.2026.09.21.13.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:10:28 -0700 (PDT)
Date: Mon, 21 Sep 2026 22:10:25 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] pwm: tegra: Check for match_data being NULL
Message-ID: <arGKNDBsngs2NEZo@monoceros>
References: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
 <ed943d9be3b785514e0f65a5b8c13a78aba7a090.1789741839.git.u.kleine-koenig@baylibre.com>
 <arD7N6A6ncBNR1Jk@orome>
 <arE-s0zbTUn14aIr@monoceros>
 <arFYGka5NpcgJ8oQ@orome>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gnzowsmozdenpnzo"
Content-Disposition: inline
In-Reply-To: <arFYGka5NpcgJ8oQ@orome>


--gnzowsmozdenpnzo
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/3] pwm: tegra: Check for match_data being NULL
MIME-Version: 1.0

On Mon, Sep 21, 2026 at 06:24:39PM +0200, Thierry Reding wrote:
> On Mon, Sep 21, 2026 at 04:34:09PM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello Thierry,
> >=20
> > On Mon, Sep 21, 2026 at 11:47:17AM +0200, Thierry Reding wrote:
> > > On Fri, Sep 18, 2026 at 04:33:46PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > > > index efb7ab60f602..b461d3877f43 100644
> > > > --- a/drivers/pwm/pwm-tegra.c
> > > > +++ b/drivers/pwm/pwm-tegra.c
> > > > @@ -323,6 +323,14 @@ static int tegra_pwm_probe(struct platform_dev=
ice *pdev)
> > > >  	int ret;
> > > > =20
> > > >  	soc =3D of_device_get_match_data(dev);
> > > > +	if (!soc) {
> > > > +		/*
> > > > +		 * This can only happen if pdev was matched via pdev->name
> > > > +		 * (which should not happen today) or in combination with a
> > > > +		 * driver override.
> > > > +		 */
> > > > +		return dev_err_probe(dev, -ENODEV, "Unsupported device\n");
> > > > +	}
> > >=20
> > > We don't usually do this. Matching via anything other than OF device =
ID
> > > tables (or ACPI, I suppose) is a programming error and you deserve the
> > > crash which forces you to fix things rather than continue with an err=
or
> > > that is easy to miss.
> >=20
> > I don't agree to "you deserve the crash". IMHO even root should be
> > unable to make the kernel crash. I don't understand what you think
> > should be fixed if I hit that crash. My userspace interactions in /sys?
> > Which error is easy to miss?
>=20
> Oh, root can easily make the kernel crash in any number of ways. That's
> really kind of baked into the concept.

Yeah, right. root can poke in /dev/mem (unless STRICT_DEVMEM=3Dy). And
root can allocate memory until the machine crashes (unless a resource
limit is in place). And root can unbind devices, or bring down the
network, but that shouldn't result in a kernel crash. If it does, that's
a bug worth fixing.
=20
> To me this is in the same category as force-unloading a module. You can
> do it, but you should know that it's potentially dangerous and most of
> the time doesn't make sense either.

Yes, force-unloading is another such thing, but this can only be done
if MODULE_FORCE_LOAD (default n) is enabled.

The only thing I'm aware that root can do to crash the kernel where I'm
not aware of a guard rail is `kill 1`.

> It's called forcing because there
> are guardrails in place to prevent you from trying to do it.
>=20
> If a device cannot operate without device data, it doesn't make sense to
> bind to it with a driver override because then you just don't get that
> data.

Ack, it doesn't make sense, and so IMHO it's worth to spend a check to
prevent that from happening.

> I'll grant you that purposefully crashing the system is maybe a bit of
> an exaggeration if there's a knob specifically designed to let you do
> this, hence why I volunteered to look into opting out of driver_override
> where it doesn't make sense.

Cc: me if you find something. Until that happens I consider introducing
that check the right thing to do. My patch is essentially a codifycation
of such an opt-out. :-D But I agree a more semantical version would be
nicer (but not sooo nice that *I*'d start a new quest for it).

Best regards
Uwe

--gnzowsmozdenpnzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqxjy4ACgkQj4D7WH0S
/k6ljAf/XXz3ObrZ1C6gC2IW0gDCH+rRf82Q1RkSbDnNVrUksg6LqnlGq8+wBS28
jr5Y/SrnzLVkWnbNQFzi09Xk8/ukvJE4hfN8l8D/WPnnKXuRJshDENC6P6hKJs1w
Kn1d3cwne1dektKk7zJHBE4786qkwtnuG5yVfjdPFiC8rjijv4RexG+pd191G+US
Yu/pGj1EYG0T49B4mk34YnbUweMDYJrtUuthMYeqcA6vrrplJbZkZj4+GnpWt1gj
qZ+dd3LdrA16wjEIZITtCSib0YorlFDrVxEmaGv0/kNd6QWqvetyPCqiXu6E8GgG
0B8GsoKqUEy3VSGpnjJm6cxKgv/hew==
=9Zf4
-----END PGP SIGNATURE-----

--gnzowsmozdenpnzo--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A644C8C67;
	Mon, 21 Sep 2026 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007883; cv=none; b=fPZXszLmSnRF5RWsmvKdohPr+gUNQBDKwj0esM1BbhhsgQ9dLvYc/nZ7y9G9wmx1zcFTcHg4GBu6rtx6bO8whSZDEpSLoQzoD2hkU+wiKb4J8DX+6z7ZArKAw2aM7CWXVJBQflWi2rAAIZdEvhDtUuJbRbl3Rg6xrIm8yOdBPOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007883; c=relaxed/simple;
	bh=XW1ZlnJxNk2y8YaabeqSHfQ25ViAMd1EBr4H9M78FJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZLxK6QKJ0CDBsWSW+CzIp8N8TtpCDozefzvX2A0tc8A7KslZsZ+HlFA1LyH7Ax7L0DZIoQC4p4KA0XBmw+jhn+yXYp3eXvA6z6wWREeaD+zupON/dgs0EsVeU0ria63X4jOdy0rTQVpRYprOejfZNxuJCJ72GTt2pE2xoSdxYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfUDY7Fj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfUDY7Fj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108781F000FF;
	Mon, 21 Sep 2026 16:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790007881;
	bh=I4ZlrTIz7FGg79lxB9dHWC/bH0FGoNCXcCfyaQJngSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mfUDY7FjLtHZP43FxwQzN9I3Zfmawue7TvFL8Sa3o63jscHKIugoNZU/BCQ4LHgda
	 obTMEuWsTElzFr0+vvXLHZH96UCt1OdCoVe1MdCS0twVhNvA594O/b7ryQH3eIZNEf
	 BYV2neV8/rp+U2IocIlqMMpRfl4e5YyLVDitSORtJG8t0t2SNbgUT8JQxT4VivGRHd
	 aRLKnqOGVW+ZaxLDwrcYvUziBC+ybPg/8xLYMgyVCtRTVQ4tcZB5uErTBuC8wZ2xMX
	 kbOMFMJNawVOG9I1IiIM6RQPD77IXkCPddKEYR7ZufyCsnjbmkCufqjG4VqFpYLZiX
	 cqVF5NQ33w3ng==
Date: Mon, 21 Sep 2026 18:24:39 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] pwm: tegra: Check for match_data being NULL
Message-ID: <arFYGka5NpcgJ8oQ@orome>
References: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
 <ed943d9be3b785514e0f65a5b8c13a78aba7a090.1789741839.git.u.kleine-koenig@baylibre.com>
 <arD7N6A6ncBNR1Jk@orome>
 <arE-s0zbTUn14aIr@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cc43efw76xe5jxqu"
Content-Disposition: inline
In-Reply-To: <arE-s0zbTUn14aIr@monoceros>


--cc43efw76xe5jxqu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/3] pwm: tegra: Check for match_data being NULL
MIME-Version: 1.0

On Mon, Sep 21, 2026 at 04:34:09PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Mon, Sep 21, 2026 at 11:47:17AM +0200, Thierry Reding wrote:
> > On Fri, Sep 18, 2026 at 04:33:46PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > It's unlikely but not impossible that of_device_get_match_data() retu=
rns
> > > NULL. Handle this case instead of triggering a NULL pointer exception.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > > ---
> > >  drivers/pwm/pwm-tegra.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >=20
> > > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > > index efb7ab60f602..b461d3877f43 100644
> > > --- a/drivers/pwm/pwm-tegra.c
> > > +++ b/drivers/pwm/pwm-tegra.c
> > > @@ -323,6 +323,14 @@ static int tegra_pwm_probe(struct platform_devic=
e *pdev)
> > >  	int ret;
> > > =20
> > >  	soc =3D of_device_get_match_data(dev);
> > > +	if (!soc) {
> > > +		/*
> > > +		 * This can only happen if pdev was matched via pdev->name
> > > +		 * (which should not happen today) or in combination with a
> > > +		 * driver override.
> > > +		 */
> > > +		return dev_err_probe(dev, -ENODEV, "Unsupported device\n");
> > > +	}
> >=20
> > We don't usually do this. Matching via anything other than OF device ID
> > tables (or ACPI, I suppose) is a programming error and you deserve the
> > crash which forces you to fix things rather than continue with an error
> > that is easy to miss.
>=20
> I don't agree to "you deserve the crash". IMHO even root should be
> unable to make the kernel crash. I don't understand what you think
> should be fixed if I hit that crash. My userspace interactions in /sys?
> Which error is easy to miss?

Oh, root can easily make the kernel crash in any number of ways. That's
really kind of baked into the concept.

To me this is in the same category as force-unloading a module. You can
do it, but you should know that it's potentially dangerous and most of
the time doesn't make sense either. It's called forcing because there
are guardrails in place to prevent you from trying to do it.

If a device cannot operate without device data, it doesn't make sense to
bind to it with a driver override because then you just don't get that
data.

I'll grant you that purposefully crashing the system is maybe a bit of
an exaggeration if there's a knob specifically designed to let you do
this, hence why I volunteered to look into opting out of driver_override
where it doesn't make sense.

> > Driver overrides aren't going to work with these devices anyway, so I'm
> > beginning to think it might be worth looking into opting out of the
> > override behaviour for select drivers.
>=20
> I think there are much more drivers that don't expect to be forced on a
> device, so opting in for override would be a more sensible result. Of
> course the path to there is more painful ...
>=20
> Best regards
> Uwe

Yeah, driver_override has been baked into the driver core for quite a
long time (platform devices seem to have had this functionality for more
than a decade).

You're probably not wrong about opt-in being the more natural choice,
but looking at commit 3d713e0e382e ("driver core: platform: add device
binding path 'driver_override'"), the intended use-cases are very
generic, so it would probably lead to a continuous stream of patches
needing to be added whenever a new device wants to be supported with
vfio or something.

Thierry

--cc43efw76xe5jxqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqxWkQACgkQ3SOs138+
s6EfIhAAsvshoTesQTfrJCF4vjN9N0WONFlSJ5uvGQt19cLckjR+Q/kj84q6FMO8
X7u5/FmyoVD/N+wecH/YpFrygVAMWdyiQrVnRjXvwi7OaBozpQhXPFcXfu81cck+
JeyBrl62G7lbh+Br7vzEWUGuT1M9fi3LIrHPREq2lwoiU84+iPbVr8TKJyhe7L36
sVnstyo2+YkadubZ0PLyMxXqyZ8tHnILxgMMiPfrIHmH/DRaTCO47HEGuM7eLgS8
Mp8LjpXJD/KRpnKKjevo2zSelgJ2VaBSP56ZQhcgGt2+sQ8G/zcOzNqDxdHAv1XH
9Aiwr0HqOS/VKoQH6LVkugrs+lD49MgV7IHxGPlRMCo2aCBvGnzTm4gHxmXacDgJ
0iozuHtRt+iWhy2rWL3QaHCeuuJyp9HjiFSSdxrdxg2DbR5sCKcUfvPh1+i6zK71
HzJ8pH6/BByPiuTt0k/f0v9/h/iuufm3RvL7yGTa4F4viPkL7STaKz6U+2422Ogk
i3wN3mBNQFk0IzryzbQ+5BlksX41K8nsx0oVApSnboAEXYuOuhNJcQgL2qbJKuLv
8wQkeDVjXqN51283iEj2Dhl+cJvsfIycYybs8fS7O+OiwjT7TUliZ3HfOUF19g9n
3Ecs45RHPH2B1kqlEF3iZRsUzooGd1VrPLvPgp2bPwBlM9bHFCM=
=Ul3u
-----END PGP SIGNATURE-----

--cc43efw76xe5jxqu--

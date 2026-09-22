Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33801E51E0;
	Tue, 22 Sep 2026 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790086170; cv=none; b=F1mKXfYik5czBeft5Xh/f4bQBPe1EnDi8LZYdyLjEdnq852Mqy4H3mAfv5eXZvgWLcQSz+rPzTBh2TpjDTxUtkEWoLdUBuYzAJyWsM6xYiAhc50Hj/wKELuHKgLmbcJ8BOr+mV2BTDDD1Jk4dPZw74Ag10YidASh8iZouMnM8U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790086170; c=relaxed/simple;
	bh=5eUWwYmyoYKd8yyHHOjwiHKH6MfndOASxVI4Yvk4aGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjXRE+aanWCuaxCkhxFAZKbzdIaSLExBfii5fhx8ay7Agfbg1RIHjcIsRevudHoZSgZoajPGDgtJ/a+aNsBuS78m5CftowfLO/R0sdSybzIl5fb2cm1Wk1oaU9vAtsaau4G1mzBiX8Qnl6sP70oxRW1KvR2J2Mw6RdufioGBkgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIP2jaeb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIP2jaeb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D75B1F000FF;
	Tue, 22 Sep 2026 14:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790086168;
	bh=D6Aavxp3VhJXWJ3oPsCmDA1giEaBo0wNTN0QHHkvpZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iIP2jaebLtctuzSGbrZY0QfqI9chrrXPXz3jFj5CwKIMmBFUnN8SEm+i+1/moEraU
	 sH8paMLNbdoCaCfmuSIGin8lywL6pEBdLlc+REioPrGgw1HKriAGIutx7Jko5Z286s
	 thBUGglIHN/JC+Z73IFSBSdj5LiqTV05ZrYIi25I+GsWhdrOqnq7jvyAWOuuYyJPux
	 OYQXzvBXh2H/GTh9yWZrEI4iV1RE9xdfLfiRNud9pJNjo0T35MmbIOqfShv9RIXKgz
	 dzZhJkUIRJVqWrD36Uo4KJcLIF0p49iScqBTPPaQhNiR1RP0bZOVrhqFIflhR/GR6i
	 whHXp1KEtRKGQ==
Date: Tue, 22 Sep 2026 16:09:25 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>, 
	Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] driver: core: Allow drivers to opt out of
 driver_override
Message-ID: <arKLt__frMjzSA4t@orome>
References: <20260922-driver-override-opt-out-v1-0-58c35ded3b83@nvidia.com>
 <20260922-driver-override-opt-out-v1-1-58c35ded3b83@nvidia.com>
 <2026092227-marbling-untying-c1df@gregkh>
 <arJ6s51FV4T9IK5w@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kwbsr3rt6ars6dkv"
Content-Disposition: inline
In-Reply-To: <arJ6s51FV4T9IK5w@monoceros>


--kwbsr3rt6ars6dkv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] driver: core: Allow drivers to opt out of
 driver_override
MIME-Version: 1.0

On Tue, Sep 22, 2026 at 03:17:26PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Greg,
>=20
> On Tue, Sep 22, 2026 at 02:13:58PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Sep 22, 2026 at 01:38:28PM +0200, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > >=20
> > > Some drivers rely on device data obtained through device ID matching =
and
> > > will not work otherwise. Some such drivers don't check for the validi=
ty
> > > of the device data because it is never NULL when the device is matched
> > > against the device ID table.
> > >=20
> > > However, Uwe recently pointed out that drivers always need to check t=
his
> > > device data because any device can be forced to bind against a driver=
 if
> > > their driver_override sysfs attribute is set and the driver rebound. =
Any
> > > such device will now not have device data from a device ID match table
> > > and may crash.
> > >=20
> > > Add a flag that allows drivers to opt out of the override mechanism w=
hen
> > > it doesn't make sense. This allows us to deal with these situations in
> > > the core rather than sprinkle checks throughout all of these drivers =
to
> > > check for validity of the device data.
> > >=20
> > > Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > ---
> > >  include/linux/device.h        | 12 +++++++++---
> > >  include/linux/device/driver.h | 12 ++++++++++++
> > >  2 files changed, 21 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > index 90cdd77458bb..45c23cc5efa8 100644
> > > --- a/include/linux/device.h
> > > +++ b/include/linux/device.h
> > > @@ -899,14 +899,20 @@ static inline bool device_has_driver_override(s=
truct device *dev)
> > >   *
> > >   * Returns > 0 if a driver override is set and matches the given dri=
ver, 0 if a
> > >   * driver override is set but does not match, or < 0 if a driver ove=
rride is not
> > > - * set at all.
> > > + * set at all or the driver opts out of the override mechanism.
> >=20
> > What's wrong with just not allowing bind/unbind at all?  Why would you
> > want that, but NOT the driver_override file?
>=20
> bind/unbind and driver_override are two very different operations. The
> first is something that should generally work and I consider it a safe
> operation. The practical use includes reloading drivers that hang and
> also switching operational devices on a devboard that cannot be used at
> the same time due to pinctrl conflicts or different clk needs.
>=20
> driver_override is a foot gun that allows to bind unsuspecting drivers
> on foreign devices and thus make e.g. of_device_get_match_data() return
> NULL for a driver that assumes that cannot happen because all
> of_device_id entries have a non-NULL .driver_data yielding null pointer
> exceptions.
>=20
> See also the feedback you got on
> https://lore.kernel.org/all/20260914-bind_taint-v4-0-eadf8a090903@linuxfo=
undation.org/
> where (apart from me) Danilo Krummrich argued that unbind/bind should be
> considered safe compared to driver_override and also our conversation in
> #kernelnewbies where Richard Weinberger concurred to that.
>=20
> Having said that I think there is only a handful of drivers that are
> actually supposed to work when used in a driver override (vfio stuff,
> spidev and i2c-dev come to mind), so I'd prefer that drivers opt-in
> instead of opt-out. Otherwise we yet another flag that drivers should
> set in general but don't because driver authors are not aware[1]. The
> few drivers that rely on driver overriding should be identified quickly,
> and if we miss one that doesn't result in a way to make the kernel oops.

We could easily invert the logic in this patch to make this opt-in, but
it might be difficult to know exactly which ones want to opt-in, given
it's been enabled by default for a really long time.

Thierry

--kwbsr3rt6ars6dkv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqyjBUACgkQ3SOs138+
s6FB0w//YYnwrP3Ylhg3ZzfG+Tds7tZLFcuHw1pBiUwC/YxW5Q3fl7JDC3t2SL/3
ogmRufIr6xCsCX1DtB17OjdEo1gGTToxG6eFNKV6DsUvRpyW+nF+r0S+RW+Zz1BC
+uq+s6cSV1rujTJlevs4rBHDnau1YUc6I651fTS6X3xvZBoXSslUqxePtmU8n0aC
JhiXR856APtcRyFOs7OX3MEHJB+SpUosWU8qrC05Rpx5piHEcbj+yfo8RypfV2PH
nDcHQRANYSnLQmjYtTB0cmrPC8HT9UQVo5ALJI1WCuX1i8MzKiCRnMvIeTigIBO5
Dq3rhf/Yg3wejrxtPpcDFDFcgQu5dLnBEi3eTAfEFQa3rk8xvg1Qq6rsMLkk7Af4
mjV7NDbUW6P56nUSfsb0n9RvbocBb57b5gdo3+Qr4J3VkJYcWQAvf/G9IW05rPfY
fjmo+Wnns8IDVz9xVdtBF1Oc0MQLlkM+plzSIcE5a/C9T30iLZtx0MAHTPsMi36T
BpB2226AJYXXWtJY5FfzrIP97iUn67QPcSZQqEJedPUtq2aG5Xh/1IbkfMXyMNFo
yXae75FKPsBMsvm/3uk9uYq9WiblC7Gy+15sNTRyI0z/TDsOeiIzuWLApB+fvoFU
3CLOuTay5DYZ1Z/n8UEuniB99361gX/HCv0+y7R4P83SIVBvF+o=
=ohp9
-----END PGP SIGNATURE-----

--kwbsr3rt6ars6dkv--

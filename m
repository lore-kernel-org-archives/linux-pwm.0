Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FD555C1B3;
	Tue, 22 Sep 2026 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083051; cv=none; b=g5HlGlqB7KSVlV75UIMDi/UPHFYVhVeis/OkXtwVIPu/f/v0eCVM07QaPaK+zsXBAUmXwHbUaYT6n92lGKVxF3WVLhzq94ohCG/IBzHzz/VxjigtEYtCQPTp9/qMalbMl2jx+8lpoacXIAIIAtn7gvFdxSblf9aVOOF71xY8+dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083051; c=relaxed/simple;
	bh=YWNdjPvEx/KhIQdM1gbBQejt9KbStbxX8QvR6Cv4bwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbD2znOGBgB10/AAfITxJj9Hh3O9ZuFTxiBZTo7VN+WWY5ivz9eRvZ35Vzofm4sEdaELRZ6ffyHWby3c+1/9/UXFzo2TeUg2Pad8xNXEPIp9YdRqYbPPFdcFzy7rRtEOavVa8j3sSTv/1Xs/vF6ofOYPd11zkzKjz+b18uIJeuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaGotFeH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaGotFeH"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F340F1F000FF;
	Tue, 22 Sep 2026 13:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790083049;
	bh=3CuW6X4BV947wXj6uooDWMNAbu6GMqHgJtFrQHwQVos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OaGotFeHzcZ4cvq9FZgbdVxd6tmfKIaSZors5fNlEuGF5kaQwkKYKmDg+zkq2jYPl
	 UjegRwYI0qgT2roUfIxly/dYTCgqb+OktEq5wFox0EOcYsFpIt9Vnk+rbewibK9OON
	 UCFlJZvx38H3M2ddhcPHKML+RoC/wU1b9+avmLwF4KCne6fp83dB0Ia04ITfDKg7u4
	 ot/s+HFp27ecKJBdXAHxn+R9meOFHmKHubyH3miaf4+zI8v6pzODGIHwJ0k/wXeo6f
	 rsK8YzkofQ8qAq8OhtL/BVHePKFS//09DuJ/k35W1HVwqTqNcE6M/qHKJms50Ja5im
	 Zm+STgRNC56/A==
Date: Tue, 22 Sep 2026 15:17:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>, 
	Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] driver: core: Allow drivers to opt out of
 driver_override
Message-ID: <arJ6s51FV4T9IK5w@monoceros>
References: <20260922-driver-override-opt-out-v1-0-58c35ded3b83@nvidia.com>
 <20260922-driver-override-opt-out-v1-1-58c35ded3b83@nvidia.com>
 <2026092227-marbling-untying-c1df@gregkh>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7wypyhczpeuoxmol"
Content-Disposition: inline
In-Reply-To: <2026092227-marbling-untying-c1df@gregkh>


--7wypyhczpeuoxmol
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] driver: core: Allow drivers to opt out of
 driver_override
MIME-Version: 1.0

Hello Greg,

On Tue, Sep 22, 2026 at 02:13:58PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 22, 2026 at 01:38:28PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Some drivers rely on device data obtained through device ID matching and
> > will not work otherwise. Some such drivers don't check for the validity
> > of the device data because it is never NULL when the device is matched
> > against the device ID table.
> >=20
> > However, Uwe recently pointed out that drivers always need to check this
> > device data because any device can be forced to bind against a driver if
> > their driver_override sysfs attribute is set and the driver rebound. Any
> > such device will now not have device data from a device ID match table
> > and may crash.
> >=20
> > Add a flag that allows drivers to opt out of the override mechanism when
> > it doesn't make sense. This allows us to deal with these situations in
> > the core rather than sprinkle checks throughout all of these drivers to
> > check for validity of the device data.
> >=20
> > Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  include/linux/device.h        | 12 +++++++++---
> >  include/linux/device/driver.h | 12 ++++++++++++
> >  2 files changed, 21 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 90cdd77458bb..45c23cc5efa8 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -899,14 +899,20 @@ static inline bool device_has_driver_override(str=
uct device *dev)
> >   *
> >   * Returns > 0 if a driver override is set and matches the given drive=
r, 0 if a
> >   * driver override is set but does not match, or < 0 if a driver overr=
ide is not
> > - * set at all.
> > + * set at all or the driver opts out of the override mechanism.
>=20
> What's wrong with just not allowing bind/unbind at all?  Why would you
> want that, but NOT the driver_override file?

bind/unbind and driver_override are two very different operations. The
first is something that should generally work and I consider it a safe
operation. The practical use includes reloading drivers that hang and
also switching operational devices on a devboard that cannot be used at
the same time due to pinctrl conflicts or different clk needs.

driver_override is a foot gun that allows to bind unsuspecting drivers
on foreign devices and thus make e.g. of_device_get_match_data() return
NULL for a driver that assumes that cannot happen because all
of_device_id entries have a non-NULL .driver_data yielding null pointer
exceptions.

See also the feedback you got on
https://lore.kernel.org/all/20260914-bind_taint-v4-0-eadf8a090903@linuxfoun=
dation.org/
where (apart from me) Danilo Krummrich argued that unbind/bind should be
considered safe compared to driver_override and also our conversation in
#kernelnewbies where Richard Weinberger concurred to that.

Having said that I think there is only a handful of drivers that are
actually supposed to work when used in a driver override (vfio stuff,
spidev and i2c-dev come to mind), so I'd prefer that drivers opt-in
instead of opt-out. Otherwise we yet another flag that drivers should
set in general but don't because driver authors are not aware[1]. The
few drivers that rely on driver overriding should be identified quickly,
and if we miss one that doesn't result in a way to make the kernel oops.

Also note that setting .suppress_bind_attrs on a driver doesn't prevent
driver_overriding. After you point a device to a different driver you
might not make it bind via sysfs immediately, but that might happen at a
later point. (I'm not sure, but maybe it's enough to plug in a USB
thumbdrive?)

Best regards
Uwe

[1] Do you know about struct device_driver::probe_type =3D
    PROBE_PREFER_ASYNCHRONOUS?

--7wypyhczpeuoxmol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqyf+QACgkQj4D7WH0S
/k4tGAgAuOwHvbppmvPB5KVXqKAItL0QhWDCPbRbDHnbVo6P09XPDFwmb9/LeFmC
wU6t8tSfzMcSgGbaiY3mIcuN9QGgWiARg2GoPizNQ1KzJuSDpowTDv8kmHp7Es9l
H56C07e8FDyDqo11LtkR4XUIrOFT8GpEd1Jvkgc7Wn4O2N8twKpvLThIh/AvB3ha
pEfx37+eb6wEBQvDsiWEKydjYsR6x2vCp4z7jg0cLfomyKGgXQKLa9zsF45nAf+W
xvSE0kvvZ77zW/u/m5zE6zRJtpXm0LnKOXhI69v8ba8LZ4YJotBybRWfWOdvzwsm
cINhXwO6g/AapvA7vb3RXMtvyFZesQ==
=A3FY
-----END PGP SIGNATURE-----

--7wypyhczpeuoxmol--

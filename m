From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC] pwm: chip_data vs device_data
Date: Tue, 6 Oct 2015 09:38:56 +0200
Message-ID: <20151006073856.GB18633@ulmo>
References: <56137655.40804@schinagl.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35518 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbbJFHi7 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Oct 2015 03:38:59 -0400
Content-Disposition: inline
In-Reply-To: <56137655.40804@schinagl.nl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Olliver Schinagl <oliver+list@schinagl.nl>
Cc: linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Olliver Schinagl <oliver@schinagl.nl>


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 06, 2015 at 09:20:53AM +0200, Olliver Schinagl wrote:
> Hey Thierry, list,
>=20
> While working on something in the pwm framework, I noticed that the void
> *data in the pwm_device struct is called chip_data. Why is it not called
> device_data, since it is the data associated with a PWM device, rather th=
en
> the chip, and on that note, if it really is chip related data (thus cover=
ing
> the whole chip, not just the single pwm device) why is there no chip_data=
 in
> pwm_chip?

The reason for the name is that it's chip-specific data associated with
a struct pwm_device. That is, a PWM chip implementation (i.e. driver)
can use it to keep per-PWM data that's not in struct pwm_device itself.

> Again, is this something worth my time to add a device_data and rename
> chip_data?

device_data would be redundant because it's already part of struct
pwm_device. Plain data might be okay, but I like the chip_ prefix
because it marks the data as being chip-specific data rather than
generic.

Thierry

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWE3qQAAoJEN0jrNd/PrOhDL8P/2xULTVx1jEV9P1mAWEReHv5
TDwbiV3I6/KkvygvLL0tjoP9un1RxQFl3AubZef+t8hx0tLjYVrHWuAdFVvdbjZ6
aWhfOH3uOJHpA15KOqrNsRAC+Ab1sMmwHmBMKwuchoVjD4CKuhOSiOMEYDIB/4kp
A58W/NJGT3EmJ++3hoF5fGEZdKaxl613QlG5mCrLwxtQWf0LOmjUbIyZAZkBJ04Z
QPMhKgwOL/VAICJXvR1jCZPd+Rf8JDIN1ST0IX5rG6/m/Es1NDA1mUPkb47onzFo
f9uPf3vY2csrd65jJEFA7KBwzDIb/PoMM+cFiEpytLG5QNFxtbUaCnlJJr4CRG0n
NVD5TPO5ILBVmnsDitZqeXdcYncT6pGmD5tuMOmzXcYfr2WVItS9p7+lVmW8p/xZ
lUBoO2dNHRfZJhZesrlSrQrFsbEIdpiRzQbxftMJyay3uqb90sXDvShWI/yiGpgl
YL5ZtwclFSZK1ho4vG2n2OMcj/UR2XfcIMBc7YP3CT0ZAz5TvTsj+bw6gW01eju7
bV6eANdNPAWBp3e1wKiOw8VxFFUBteh7WqcYABswnQMH4nw2qbgMm+dDuptYrwmV
SN53gYrdvkBEa3nIikwaYsdWhQddF8BDdEmdcr2JAc1zcBM4VyzpLOqi7tzaOrhr
RnmuDSggHO67tKB3+i4N
=gwVB
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--

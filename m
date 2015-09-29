From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC] pwm: core: unsigned or signed ints for pwm_config
Date: Tue, 29 Sep 2015 09:45:52 +0200
Message-ID: <20150929074552.GA3648@ulmo>
References: <560A3B7F.30803@schinagl.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37160 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932517AbbI2Hp6 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Sep 2015 03:45:58 -0400
Content-Disposition: inline
In-Reply-To: <560A3B7F.30803@schinagl.nl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Olliver Schinagl <oliver+list@schinagl.nl>
Cc: linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2015 at 09:19:27AM +0200, Olliver Schinagl wrote:
> Hey Thierry, list
>=20
> I'm going over the pwm core and notice that in the pwm header, duty_ns and
> period_ns is internally stored as an unsigned int.
>=20
> struct pwm_device {
>     const char *label;
>     unsigned long flags;
>     unsigned int hwpwm;
>     unsigned int pwm;
>     struct pwm_chip *chip;
>     void *chip_data;
>=20
>     unsigned int period;
>     unsigned int duty_cycle;
>     enum pwm_polarity polarity;
> };
>=20
> However, pwm_config takes signed ints
> int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns);
>=20
> So digging a little deeper in the PWM core, I see that pwm_config dissall=
ows
> negative ints, so having them unsigned has no benefit (and technically is
> illegal)
>     if (!pwm  || duty_ns < 0|| period_ns=3D 0 || duty_ns > period_ns)
>         return -EINVAL;
>=20
> and because (after the check) we cram the signed int into an unsigned one:
>=20
>     pwm->duty_cycle =3D duty_ns;
>     pwm->period =3D period_ns;
>=20
> This could end up badly when using any unsigned int larger then INT_MAX a=
nd
> thus ending up with a negative duty/period.

I don't think this is problematic because we're rejecting negative input
values and store the non-negative ones in an unsigned int, so we can
never store anything that would overflow the internal representation.

> I haven't checked deeper if this
> is accounted for later, but would it be worth my time to convert all ints=
 to
> unsigned ints? Since negative period and duty cycles are really not possi=
ble
> anyway?

The reason for storing them as unsigned internally is precisely because
they can never be negative. The reason why pwm_config() has plain ints
is historic. It's always been on my TODO list to convert them over to a
unsigned variant, but never high priority enough. It's also problematic
because doing so needs to modify a public API and hence requires
auditing all consumers and providers to make sure nothing breaks.

I'm not sure if it's worth spending this effort now. Boris Brezillon
posted patches a few weeks ago to introduce an "atomic" API and that's
going to require updating all users anyway. The new API also uses the
correct types, so any effort should probably go into testing and
migrating to the new API.

Thierry

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWCkGtAAoJEN0jrNd/PrOhNLUP/0kALlQOXye+6uXfl4AAmWTT
KRv+vWx56noXh5T87spaZfD/3MLvEHWcdKrn9yUfZpWCGVnOrHQxov6MqINNwSpt
gi2rFjerFfAPR7roA/f9HE+TVgbnnbD5W+R2f6Mds3PKVFMbAavM6wNmDdCWw+rr
YQoV7UEAteeqFT0Ec+3nPnxsDSASAd2KN9Gz3Sqzf0RcvGSEj4sLkEFBTQuUnNqB
IZuGEc3A8xTbCIlh63jmFO9cwMhRa53ZyABBLUrfft/SKviKl/VsrMubSUSz9PrS
AH/gLjBMMUcJ2U++1qqK+TvlQaQXxhUaW212+l7NgVP65a21lNSFarZ3hhRLu/9+
kYVfDtZpuBq3I5ccCZOv9L8j/C8WRr99+fcQ20JlixlRQeAwg6wflGrqb9BQ2abM
xAypgxO7jATNw3W531CCpPoAM+I0UDPdjvndexF+KnQtMqwXIoJJ8uTn1QAWiM2M
+OEV9Xui/lIgA52rJLjPidWDkAAnyl09ylyM5Vl9qtR0EJkAoDGAokKOODaKdayt
fac42HLx9HIJHn+OFmLNgzkpEJBdGFdcI05CWa6mOF6LQ3LB6wfeBTRX8em1u640
5vlP2KPkk71Sl3esYEWBbnPEx7E8HSklIt0lD1gF/igz/EjfcC5g8DePbuaIFLKB
bA9pcS2I7GCGSxS6AUMP
=A7rL
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

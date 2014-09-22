From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: quick help on PDM DAC driver
Date: Mon, 22 Sep 2014 13:27:08 +0200
Message-ID: <20140922112707.GR1470@ulmo>
References: <CAC3mp01MC3SaR8WmcDOXmGaB60eYfifx+YMT8xvxE2L=gZ093A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="562f9N4fbIs+fPrJ"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:55936 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbaIVL1L (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Sep 2014 07:27:11 -0400
Received: by mail-wi0-f170.google.com with SMTP id fb4so2618893wid.3
        for <linux-pwm@vger.kernel.org>; Mon, 22 Sep 2014 04:27:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAC3mp01MC3SaR8WmcDOXmGaB60eYfifx+YMT8xvxE2L=gZ093A@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Naidu Tellapati <naidu.tellapati@gmail.com>
Cc: linux-pwm@vger.kernel.org


--562f9N4fbIs+fPrJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2014 at 04:37:11PM +0530, Naidu Tellapati wrote:
> Hi Thierry,
>=20
> Many thanks for your quick response.
>=20
> There are total 4 blocks available on our SOC, those could be used
> either as PWM DAC (or) PDM DAC blocks. If one of them is used as a PWM
> DAC block, it can=E2=80=99t be used as a PDM block. As an example if the =
user
> wants, based on the configuration from the device tree, he could use
> all the 4 blocks as PWM DAC blocks (or) all 4 as PDM DAC blocks (or) 2
> PDM DAC blocks & 2 PDM blocks (or) any combination of these two types.
> Since there are 4 blocks available, total 16 combinations of these two
> types (PDM & PWM) are possible.
>=20
> For example based on sort of channel mask defined in the device tree,
> If the user wishes to use the blocks as PWM DAC blocks, my driver
> exactly fits into linux PWM frame work. As usual, the PWM blocks
> expect the user to configure all the required configuration attributes
> (frequency, duty-cycle etc) as defined by the Linux PWM Framework.
>=20
> Bu if the user wishes to use the blocks as PDM DAC blocks, my driver
> does not exactly fit into PWM framework. In this case the PDM DAC
> block takes only a 12 bit value (as input) program in one of the SOC
> configuration registers as an
> input and based on some simple internal logic, the block produces a
> form of analogue output according to the relative density of output
> pulses to the intended analogue signal amplitude. The width of the
> output pulse varies with the 12-bit value we program in one of the SOC
> configuration registers.
>=20
> If the user wants to change the width of the output pulse, he has to
> program different values for 12-bit value. For example different
> 12-bit input values 0xFFF, 0x800, 0x0800, 0x0080, 0x0008, 0x001 will
> produce output pulses of totally different widths.

What's the relation of the 12-bit value to the resulting signal? Does
each bit in the value correspond to a fixed interval so that a one is
high and 0 low? That is, does:

	0x800 produce -___________
	0x080 produce ____-_______
	0x008 produce ________-___
	0x444 produce _-___-___-__
	0x555 produce _-_-_-_-_-_-
	0x00f produce ________----
	...

? If so you can probably still mimic PWM behaviour by subdividing the
duty-cycle into 12 intervals.

> The idea is to implement a driver which could be upstream-able. I am
> trying to understand how I could use the existing PWM Framework to
> achieve this. If you think this does not fit into existing PWM
> Framework, I request you to please suggest me some better approach.

Even if you can't mimic PWM using PDM it's still possible to use a PWM
driver only if all channels are configured in PWM mode.

Thierry

--562f9N4fbIs+fPrJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUIAeLAAoJEN0jrNd/PrOheAEQAImrbGJxdPZYdA2UkrBrHLVN
VCAqIJ1/NHaRuQv8EOFNJrQvr6ZykwCu1pf3CsPfQHUBBefLWk978hTUI3KI1G+k
Pr7iYkSXl+g7/GlHMCO1babgm9qswKyXybm9NsLKKjSc8gI4K7OCDEBEZ6z3IRVi
tL2TSeerWwjog0AhT/XVumf2pwyvCkXXYLkuv9ITYY483g9UWwfZZ8FwVfcAdsJ1
Q75fJJz1zVfUjcxzZhUpw9RLcTxRvPMQT+Y/nAANd/8d6VrfJOEW5yoqdgD2ReIH
0Bn44wEdrQWxShJfrqgZSaR7MfnHzFjx72G/QGMBpHxwmO+T5UA07MPDUz+HTnZL
ZLIJ5ggw3YivIquvt0yuIJrXeH20CEztxl872Yc44VhPYPWzDOcC4Iahcv6ilX33
cgm+xthAkLchuX9KuufWaz95+2SnhutJTeSxRU5h0II7aOeXGME639evqElizbTn
j0JtgWTLYkl68aYno4Cf0Ayksai/la38fdEVNQFel7fYoD+fUsxqSnP/TJ3bHhbe
5WqJKblInLlqfwwjjFeuXfnZw2g2n65Jfajcyxv9R9KPhu4A3vCq1Eg+NuYY/X9z
V8GVudthg4xFDRY87w3HTyRwJmCraeEpvo/fEePDhPwVpQ0hi6kZ4p2uSqMgB4GF
1UBZe04U7JgGM8TqDRZQ
=rL0t
-----END PGP SIGNATURE-----

--562f9N4fbIs+fPrJ--

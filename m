From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: fsl-ftm: set pwm_chip can_sleep flag
Date: Fri, 23 May 2014 09:16:18 +0200
Message-ID: <20140523071617.GB6310@ulmo>
References: <1400717120.23867.1.camel@phoenix>
 <08012c6e5240435ea1ce1836229f0b21@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:64140 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbaEWHSl (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 23 May 2014 03:18:41 -0400
Received: by mail-ee0-f47.google.com with SMTP id c13so3294157eek.20
        for <linux-pwm@vger.kernel.org>; Fri, 23 May 2014 00:18:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <08012c6e5240435ea1ce1836229f0b21@BY2PR03MB505.namprd03.prod.outlook.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Cc: Axel Lin <axel.lin@ingics.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2014 at 01:02:21AM +0000, Li.Xiubo@freescale.com wrote:
> > Subject: [PATCH] pwm: fsl-ftm: set pwm_chip can_sleep flag
> >=20
> > The implementation of .config(), .enable() and .disable() operations in=
 this
> > driver may sleep, thus set pwm_chip can_sleep flag.
> >=20
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > ---
>=20
> Acked-by: Xiubo Li <Li.Xiubo@freescale.com>
>=20
> @Thierry,
>=20
> There are still 4 patches before this one, and I'd like to know the statu=
s of
> them:=20
> 	[PATCHv2 0/4] FTM PWM adds regmap and endianness support.

I was holding off on those because I thought I had seen some discussion
about how to represent endianness support in DT and I'm not aware that
there were any conclusions yet.

Thierry

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTfvXBAAoJEN0jrNd/PrOhamEP/062ZO2E9+KX7w1iPkxTY/F6
pJgxz0dZ8Q7/WQoeAMRznZ0X1mo6VZKAVHrPRpTjawsswzt24yBUbUS+aJEcR0K3
LMVf7dfKdFBgOGa+pevGs/xkWICFkq/cHYVU83Bbhxe+PdtKzXJanYJdEANWjZ5R
vQ3p3452RVozZn/cBHBwd4bBO0/fnOAEngbib6KbbuEIpuOORsBQM5XIvIl689b2
oNQEkunlSs/tDn6oNWgUPM/QU9N94K2v9bgeZ/L47lzGq9N2eHzVdcdgmA+lSBwa
la6s4qPEvQs1A24QhtX1k+dA9DRvvEydwWGEs2Te9FD8OrPvyUlIJcBBau82MpbH
Q/gvQYefRV9ub4hwcd3IbeRnpBV3RPqA8thx+cvYm9BrIuQlUfUC+PiM++ps7OAL
btytnoYemdCnWJNKKv4vtQ0Pku28TjQKzcX8jmc42WqATPcjhVZIih5seIY9upCU
k+J/fCV9ZIXuxQshcxS90mBdm0s1wpF4B6P2rR0mtUZb2DZabbxHo8Dpv3MS5HE+
BlROisVrm42a/lK1jOuOxYboiCMZ5+7XiwOgRS09KU2V0eEVMKGFv0WJrr8sivbm
wraw3lxOS4AvcDpTgdWPoGWRieJWQ1Gxt5f+W0Chd9WL+a1O4ipfeZAiOzMCEFD8
D3p5+mXZ0EpKv5SBKNt9
=O+F7
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--

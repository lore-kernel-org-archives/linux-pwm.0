From: Alban Bedel <alban.bedel@avionic-design.de>
Subject: Re: [PATCH V4] pwm: lpc32xx - Add a driver for the motor PWM
Date: Thu, 11 Sep 2014 10:36:21 +0200
Message-ID: <20140911103621.198f7ef6@avionic-0020>
References: <1410363822-22151-1-git-send-email-alban.bedel@avionic-design.de>
	<12709842.iga6ki5KTS@wuerfel>
	<20140910175941.5c44837f@avionic-0020>
	<3043402.gA1yIrlkCZ@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/BDRRaeeI_B__tI7NPrXWs0I"; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:55302 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbaIKIgi (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 11 Sep 2014 04:36:38 -0400
In-Reply-To: <3043402.gA1yIrlkCZ@wuerfel>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alban Bedel <alban.bedel@avionic-design.de>, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Roland Stigge <stigge@antcom.de>

--Sig_/BDRRaeeI_B__tI7NPrXWs0I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Sep 2014 18:28:39 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday 10 September 2014 17:59:41 Alban Bedel wrote:
> > On Wed, 10 Sep 2014 17:51:36 +0200
> > Arnd Bergmann <arnd@arndb.de> wrote:
> >=20
> > > On Wednesday 10 September 2014 17:43:42 Alban Bedel wrote:
> > > > +- #pwm-cells: should be 3. See pwm.txt in this directory for a des=
cription of
> > > > +  the cells format. The only third cell flag supported by this bin=
ding is
> > > > +  PWM_POLARITY_INVERTED.
> > >=20
> > > If you don't have multiple pwm outputs or programmable period, I woul=
d say it
> > > should use #pwm-cells=3D<1> and only pass the polarity.
> >=20
> > There is 3 channel, so 3 PWM from the API POV, and the period is
> > independently programmable for each one.
>=20
> Then you should put the channel number into the first cell and the period
> length into the second cell, as the pwm.txt document says.

That's what is implemented in this patch, by using
of_pwm_xlate_with_flags() for the .of_xlate callback.

Alban

--Sig_/BDRRaeeI_B__tI7NPrXWs0I
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUEV8FAAoJEHSUmkuduC28Mz8P/i5s2Fj+YQcB9OFcGwsoRdrr
aR2DNHXMcnJfROlS6eqRhm0DPtFlL5y6rzP7wRUenJ4Vgd+sWO5hI5UwPm5lLT4T
bb98y6ULuq2oYhSgPU1MUf4Nhf6zDQnL3/fFNsR4trZj9rzVeWJt80fpwDL8suZ4
EBF72DlRU1jwzKxf8SZOm7G5c+/FHRsad2gW/SaZIHg5vnN6l7E7mzHsOWWP9Sf6
KHwoIlOR76wvLcItUDF9ZWhGGgu6RdmBcMBpOAhWOTMQqMWQnzLYzzz3jxIm6SSc
ftTvVkL0nJ3j7piIDf4vuq01lsV0rm1+zY6BAvlTWg9dgGPen8wB63qL8u/kH78z
Pc6lg1NpRi7gzdx7BbcMaFdPQoiMBO1UaCYf8C8YYHOBhj5YYCPUuKRQ8iCGOrz0
kELk1HcE0x8ndpw+PmTp8+LkRlwqJlvwSgKPzaUQRgB4P5avG/N2gyDdNoyu63Hv
yJOntQeYF5Zp/XPG5sOCFY8t1eI/LfQwTqy+DTfsOQvuvPhAcF6O3rjHlwmke951
I9ydqCNB0OW8vCtg82uMB+QmrT28yGIfKqRN3ohyehHWQtaMsh83qRjF9CuOgdGL
BIXjaCEGmhBE6CI+BtqEATmPwCaOmjyZVYxybxOAfoAb39hFBYUxEVErPVBaIZim
o064bM2xtqhcG5A7S/DS
=7SNq
-----END PGP SIGNATURE-----

--Sig_/BDRRaeeI_B__tI7NPrXWs0I--

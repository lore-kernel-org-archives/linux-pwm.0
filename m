From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: quick help on PDM DAC driver
Date: Tue, 23 Sep 2014 09:27:53 +0200
Message-ID: <20140923072752.GK30514@ulmo>
References: <CAC3mp01MC3SaR8WmcDOXmGaB60eYfifx+YMT8xvxE2L=gZ093A@mail.gmail.com>
 <20140922112707.GR1470@ulmo>
 <CAC3mp01gADb-SPJhd9dYwKg2fQgmmeGDQ+xt8qYahRovNSpXMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k18oBAwMkTg3OUap"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:43832 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbaIWH1z (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 23 Sep 2014 03:27:55 -0400
Received: by mail-wi0-f172.google.com with SMTP id em10so4252220wid.5
        for <linux-pwm@vger.kernel.org>; Tue, 23 Sep 2014 00:27:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAC3mp01gADb-SPJhd9dYwKg2fQgmmeGDQ+xt8qYahRovNSpXMA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Naidu Tellapati <naidu.tellapati@gmail.com>
Cc: linux-pwm@vger.kernel.org


--k18oBAwMkTg3OUap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2014 at 07:28:43PM +0530, Naidu Tellapati wrote:
> Hi Thierry,
>=20
> Many thanks for your continued help in this regard.
>=20
> Each bit in my 12-bit input value to the PDM block does not in anyway
> corresponds to fixed interval. My hardware PDM block works with the
> following simple logic
>=20
> counter [12:0] =3D counter [11:0] + pluse_in [11:0]     /* pulse_in is a
> 12-bit input value to PDM block */
> pdm_out =3D counter [12]
>=20
> The above logic runs for every pdm_clk cycle.

I don't see how this could reasonably fake a PWM. The best you can
probably get is a 0%, 50% and 100% duty-cycles.

> And hence I am of the opinion that I need to have a Linux PDM
> Framework which is similar to PWM Framework and which provides
> pulse_in as device attribute to the Linux User Space.

Given the peculiarity of the device I don't think adding a framework is
necessary. But you could perhaps add a driver to drivers/misc that
exposes the pulse_in parameter in sysfs.

Thierry

--k18oBAwMkTg3OUap
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUISD4AAoJEN0jrNd/PrOh/wYQALQQ8dUu4iBylYxDWSMGfeqc
7D5SFTnwGpGPJOlaPwEXoqejwwbltDVOdvAaY4pshAWgKvWmpCv3qJUY2s7nj42m
pkMg/GBr6JRiRoEVR1k/Ealx7ogRG1cXbH+L9FyntiNPlTxDQnDSrCxoU+wn/B6a
awMMxTMSblv8nbWUu/CijOMGjqtFCP+mJKpQEUOLC8CCehBq+2oLqliSY+vr5Bql
KNYneY/1KAAw5INpSIfYqFdKbHhFoX5yfzk/NMjiMPS+2UVNvjX5qqbNS6w6tx8j
rvUAmKRLeNz7H9tdhlp5ZDW0TAYyXR72XAxHJaqtY8SOabL+stu27vc69fh5YOLp
itEjDf6tysO82ZF1aj8b3C3qqwu3sHW/eEwE6Lwl3hK4zBIRede41pJbDXkRYDAf
+B281139+45MleJ/EGkBwyn8Oj0dmOJUnoWLyxwbsKGrP3lR77qGV/uzUIhTi0GH
TG+6hIA4K9c0PLAPU+zmgOpBopq8r78ulmkD5wBzGkNvg1XpX1duCdZH+V7V31Tz
3iSXHO1gXG+JO6HEiIDBFc5ADDbwZC4gydUa/zpXm6Mhq6TQkxYkWj9VXszq3DlZ
UMCsjvZtRczurx2TEmLqqYt4pknEtMd+J/uR1YKqheRNyiBJJMc+hPiFy9U851Nn
qfb2px8qS/ozUfc3q1zg
=GFYS
-----END PGP SIGNATURE-----

--k18oBAwMkTg3OUap--

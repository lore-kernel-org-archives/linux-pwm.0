From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 10/20] pwm: sysfs: Add PWM Capture support
Date: Fri, 10 Jun 2016 16:04:04 +0200
Message-ID: <20160610140404.GL27142@ulmo.ba.sec>
References: <20160608092135.21184-1-lee.jones@linaro.org>
 <20160608092135.21184-11-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f54savKjS/tSNRaU"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34909 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081AbcFJOEJ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Jun 2016 10:04:09 -0400
Content-Disposition: inline
In-Reply-To: <20160608092135.21184-11-lee.jones@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, patrice.chotard@st.com, robh+dt@kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org


--f54savKjS/tSNRaU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 08, 2016 at 10:21:25AM +0100, Lee Jones wrote:
> Allow a user to read PWM Capture results from /sysfs.
>=20
> To start a capture and read the result, simply read the file:
>=20
>   $ cat $PWMCHIP/capture
>=20
> The output format is "<period>:<duty_cycle>".

The format below is "<period> <duty cycle>".

No need to rev the series for this, I can take patches 8 and 10 as-is
and make those modifications myself.

Thierry

--f54savKjS/tSNRaU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXWsjSAAoJEN0jrNd/PrOhpPYP/j7XlVJNWcQPlZkahuPSlNfh
4/bwlVycw5kxK2CBPwFxmSL28mDoS7dvmdYXrCEGfpBRWgOwNK0xJXDY4XKVOoJf
caY6LuxFAgovQOZG9CbAPXL2RzpRo8Uef/9VmCn8+y5tzwu99MXgh8KqR20YF80Q
TrT1c+/Kzb9vXOXWSE+P6Kf2kLAYslDkKks0fmR+vY4Kxf/ALmdyWiYlYOryVo+r
YsSTSZmP5AjWfjKxOlqNd7LFQNBaNTOhPXsQOnEzvlHttsmWqY+zcIJuCj2KY7Yn
YEclIGb/QIAm7Ie25QFgr3L+1qnq7MMF+VvMrXaMxpHJI/ZhQvmHlE8oIYMBLPpd
g8My5U5eeHiaxzhd+2RwzF9ns39om43SYk82G5pNv8PrEw1IT8X8qNfK7zql4inB
Qfu6tI1JHR28hmBG588BYcz4L29fKhKm5RlZHjn/6BA6iteZjbaiOA7EDwiTR4Qt
UFy8VMKUR+f2PM6/oVPFMW2v9keysaEAtemSOYcXSHnuQcZaHMJxs36xbUASX7LT
auaMezxfaatSmh0KTV8tbddjJEHfoDjWM4Gu3akr5rsfa1t0y3g38eC3exRrnaDR
4khP1pBa7ZVL/c+ak++2Z+6US8GnrCo0jz6XcUFcXEcioSp6wa2fyMM/qVzxs7DD
fbhIInxqMixWXqkkGRHA
=8lAP
-----END PGP SIGNATURE-----

--f54savKjS/tSNRaU--

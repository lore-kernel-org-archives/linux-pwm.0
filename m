From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 0/2] Imagination Technologies PWM support
Date: Fri, 30 Jan 2015 12:27:52 +0100
Message-ID: <20150130112751.GC32359@ulmo>
References: <1420826088-13113-1-git-send-email-ezequiel.garcia@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:41282 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbbA3L14 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Jan 2015 06:27:56 -0500
Content-Disposition: inline
In-Reply-To: <1420826088-13113-1-git-send-email-ezequiel.garcia@imgtec.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: Andrew Bresticker <abrestic@chromium.org>, James Hartley <james.hartley@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, vladimir_zapolskiy@mentor.com


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2015 at 02:54:46PM -0300, Ezequiel Garcia wrote:
> A new round for the IMG PWM driver.
>=20
> The IMG PWM controller is muxed with a PDM controller, through a shared
> so-called periph register bit, which sets the output as PWM or PDM.
> Because this register is not part of the pin controller block, but rather
> PWM/PDM specific, and because the register is also used to set the PDM va=
lue,
> it is simpler to use a regmap-based syscon to deal with it.
>=20
> This time, I'm removing the PDM driver from the submission and submitting=
 the PWM
> alone. The PDM was written as a misc driver, but had some design issues, =
so for
> now I'm proposing to merge the PWM only.
>=20
> The series is based on v3.19-rc3. If at all possible I'd like to see this=
 merged
> for v3.20.
>=20
> Comments welcome!
>=20
> Naidu Tellapati (2):
>   pwm: Imagination Technologies PWM DAC driver
>   DT: pwm: Add binding document for IMG PWM DAC

Applied the series with Vladimir's Reviewed-by on patch 1/2 and the
license text updated as discussed in this thread.

Thierry

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUy2q3AAoJEN0jrNd/PrOhLwwP/j5Qt9wnepVC3um27HPYPqwr
6GlkLrSCKux/oPkUlSuGhCqHvY//ksHvr+s9QwBKzzxdxicVxMNy0fXNmYkVlbmC
2CUz92l+ou/dxf0KLon/8vo8a3z7nGDxbvpJTkUySqDiLuUCjjfYM2TFSmAHMXWP
9p8/6cfIVb6nRlJkYhFphlNwDoCR+YfjVL5L4eLBKuPB1Kd3OqH5Q4bumNhoSXF9
KZGt7vcKmxv9Gq/qhhQ1y5XY7MCBaVO5VkRFgh1UimgYS5O2utKlbWs8Mzea0c0m
etrF8fTubN9VklEAOV51qIMbTECyBU02S2RHDzVIOeFnzUmGUtZRQMOVIfN2jiBb
mgeNSXhCZnXlIdPgVSYw5glRE/yiEoA0shfdAZZG1Ci9ayQexvgRD3Lm1iWrTy3X
zQebxwnn2MBYDmC5vPt/M47OmGuJckANcyqpqJ8WEQGST4dUI3KkZMQBv2qs+YpD
y25Mq/oF4fTo0sHR85425hd7alwEX7+EolctuCeQXDulDH/s7LGLS8VTy30kIqlH
6lRwuvn44YrDg8DgFVBykmDiWBWei9mCGP/v0dowb15Fx6vlRrEBJRL4en+3H07q
7xCMS/f1gqYilw+sqYDuMWAaDnzM89+4gcnqJ8DTw+noc4Wl8lh5tiYTVXDXvpOn
CA0mvnmH0BorqIUhpjj+
=EAhM
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--

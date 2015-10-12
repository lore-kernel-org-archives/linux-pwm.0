From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 2/4] ARM: dts: sun5i: Add PWM channel 0 pinmux setting
 for A13/A10s
Date: Mon, 12 Oct 2015 15:51:22 +0200
Message-ID: <20151012135122.GE2278@lukather>
References: <1444557308-10892-1-git-send-email-hdegoede@redhat.com>
 <1444557308-10892-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AAi0U5uflHqV1n1C"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:39432 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752205AbbJLNvY (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Oct 2015 09:51:24 -0400
Content-Disposition: inline
In-Reply-To: <1444557308-10892-2-git-send-email-hdegoede@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>


--AAi0U5uflHqV1n1C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2015 at 11:55:06AM +0200, Hans de Goede wrote:
> Add a pinmux setting for the first pwm channel. This is often used for
> backlight dimming on tablets.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--AAi0U5uflHqV1n1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWG7raAAoJEBx+YmzsjxAga9IQAJlxx1IPpxLceZQaYx6ZVFys
1DX7sM28YwaPAFzkHhUZL3xFBCPxpC5HllbcZA54lHZUdlp0m9Qs4tUIgrlgiN56
a0WbPRLt2OLsucsy6QryGBNDBzSTmHvgH9xDabXn7aVWCNG0d6WXPsU0E9od63cE
5At7ke3VQYBZSq+lAncC6XzzIQeEqxv/ykgpxIolA+1V+KTEWeFyur31RL3YKcm5
LXwh9VLFmd7821AK4dHiS/LGpff73O3OIyUYNrKGBzvWQSx1oRZYH2uIhw9UwKXE
4eSQLXGgmxtPEpSDSV78OVi0e1H557lgB2LGz43E0//W7Z0z1BaRsih5zWeU4kvB
m24JYRR9xIkiWuyq2eyIaSyCQ7fLuJHXGAvreL61qY0FbuKmu3xaZQEjNdftRXN0
YDx+e2wM0gBNkAVRpllA2A8yuNT6tG8Jx3RWyJyxLK8LjqPD1nmku1uUpudwXdVI
EtLK94XNuygOseerXBLGarEY5tBcYixZfm8r2ZBHQHVyUVPJq77XDB9gU16cgeFi
i+hhUwNUqAI6OP5zFlqyqN1xfn3Aka1k3AD20Y64fo8BNGTc10kyxzSndS+jzG+a
gWTEfpGEc81QEIozAjyNDNcT2y+tozYQdwkOz4l1CxYz176hQTS/eYt5gD9Qcg6S
r7vAoObVQ9ZL321ipLFn
=fLe9
-----END PGP SIGNATURE-----

--AAi0U5uflHqV1n1C--

Return-Path: <thierry.reding@gmail.com>
Date: Wed, 26 Jun 2013 11:48:46 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: renesas-tpu: Add MODULE_ALIAS to make module auto
 loading work
Message-ID: <20130626094845.GA27083@manwe>
References: <1372177502.26044.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <1372177502.26044.1.camel@phoenix>
List-ID: <linux-pwm.vger.kernel.org>
To: Axel Lin <axel.lin@ingics.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>, linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2013 at 12:25:02AM +0800, Axel Lin wrote:
> This driver can be built as module, add MODULE_ALIAS to make module auto =
loading
> work.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/pwm/pwm-renesas-tpu.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyrj9AAoJEN0jrNd/PrOhHZMP/0iw1gTtR/q2X5yZ3NiNCLSS
w42t9XoX8WWrdF7QrsJNbdFAY810vVTJJgi3V3jARmIviig2onFB9swJdjSG5dis
WclF6Hp0uvpp9Kj25cJxi9NEwHmctHPAtpsow/pnfJKxJHvLx76Y3Nb6CDS8UIjI
UlxJJJNPVJOakaJADWGU/5bWTOae8iyDIyY1Gl0VNTSE1pifiCTT2A5P1rYSYJcK
Q141CHa88ppy+cMCPbn0KTfaONGoy45t6ZCuNmIsLBki2v6kbUMpuqkiSZmBYrpi
XT9M93vT3uOMsEyR3Knao/u43lyw6TB+hC1nNMxD85uaQaBNlzXu9nI7EVeh5+Th
aGpPYmt48GY63qOtIHju/iAtj4chPuhJ51LdJK9/GPJOHkOMRMLg60qtoj1KCiHJ
qyGdY0Chsschk+aH6d38vE8nQbOZqpO82eL74vIAG3F9ebOd8d/JGr0mDMr3LO4g
V0imAw78XqnHosd7+AvY30TkRRb4EZbCCubox+PWNINHmQG99wRO5yCVy+R9vl3D
PFGRqzrXbeSniTihm5ngUUYcP5LpM1wTq9QBYogrRrnkF0M6/m4HhIasc/6JwUbg
4hlY5wHwsmBjCx/5UbYod8erKI/dfiYHljumbpf+5oDhG2b9dpLDHX1nIUPluN81
qKLWAtQD+ACnyNgi3sso
=z2KL
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

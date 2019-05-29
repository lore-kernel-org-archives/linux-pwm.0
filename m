Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37599 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfE2Niz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 May 2019 09:38:55 -0400
Date: Wed, 29 May 2019 15:38:47 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20190529133847.GC17223@ulmo>
References: <1559116082-9851-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1559116082-9851-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
In-Reply-To: <1559116082-9851-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 4/4] pwm: rcar: Remove suspend/resume support
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2019 at 04:48:02PM +0900, Yoshihiro Shimoda wrote:
> According to the Documentation/pwm.txt, all PWM consumers should
> implement power management instead of the PWM driver. So, this
> patch removes suspend/resume support.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pwm/pwm-rcar.c | 39 ---------------------------------------
>  1 file changed, 39 deletions(-)

Yes, I like that very much. =3D)

Thierry

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzui2cACgkQ3SOs138+
s6GxmA/+POUfNHliQaqlcfEfhelIVyhekxNxRXbU+EAM/lAVh2ivDi/xE5UfTRcw
vwRBet4rcu0U7kMC5k45eMBCnNqtLC8Ilv90EQp30cJpk9iMXMAmEtrvwJSD8Nmq
XcphkdPV8ZZ4cTIXorAnboVyZ5/jzFqXvkfzIW+9GjjjXyEZaPk1ZVNVzFHJdbYs
SeTW3Ikhb5HswIPjrwVwp046a/tCrSW12dH5e17jrS+9FLRmN165KGJHmVi8YsN7
PNWKd87fO69jHgFnM4J+zNcVdWr5Eugk57Ij2awj6kiYFq+PTkTEP6mr11wkbkkU
iXVkG+6M23v084NincQMX9lDhwzyE+DAo8iw1luFz/uCUprPGv8U1wReYGwbWQsK
b8DEeOaQdlZkjorEkMfWTgVvFmHsix7ksu1Y24Dp/8MYCfbdy1deP/YHV8BBEBTJ
TSaRfL3B/bIPAuzugL3gQaSeP1M9JX6DkIvgw3SGEiPTn98fpDLwINjdD2sq2K9y
XqnHjUtsVHnvhL+wJUFKWls/tBoYtIXyuJzTnVFq5MfI/srqNqnVbuh9Dtr+fgrj
lWujP0jn/ewiaVnHqGkG1J9DHSRAW2giXMlx1/oj9Y3O2xeCpYHfYHJm9xTHngex
kRsTENOz7wmIp11h2facbqiK7YACd+Nv1vylYXXpcAosCIpZfQA=
=mRY/
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--

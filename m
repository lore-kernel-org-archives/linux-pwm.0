Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51006 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfE2NcS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 May 2019 09:32:18 -0400
Date: Wed, 29 May 2019 15:32:14 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20190529133214.GA17223@ulmo>
References: <1559116082-9851-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <1559116082-9851-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 0/4] pwm: add power management on sysfs and switch to SPDX
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2019 at 04:47:58PM +0900, Yoshihiro Shimoda wrote:
> This patch series is affected from the following email:
> https://marc.info/?l=3Dlinux-renesas-soc&m=3D155896668906609&w=3D2
>=20
> - The patch 1 adds descriptions into Documentation/pwm.txt.
> - The patch 2 is not related to the topic though, switches to
>   SPDX identifier of sysfs.c.
> - The patch 3 adds suspend/resume support into sysfs.c.
> - The patch 4 removes suspend/resume support from pwm-rcar.c.
>=20
> This is the first trial so that I didn't make patches for other
> PWM drivers to remove suspend/resume support.

Thanks for doing this. It's looking already pretty good. Just a couple
of minor comments in the individual patches.

Thierry

>=20
> Yoshihiro Shimoda (4):
>   pwm: Add power management descriptions
>   pwm: sysfs: Switch to SPDX identifier
>   pwm: sysfs: Add suspend/resume support
>   pwm: rcar: Remove suspend/resume support
>=20
>  Documentation/pwm.txt  |  7 +++++
>  drivers/pwm/pwm-rcar.c | 39 --------------------------
>  drivers/pwm/sysfs.c    | 75 +++++++++++++++++++++++++++++++++++++++++++-=
------
>  3 files changed, 72 insertions(+), 49 deletions(-)
>=20
> --=20
> 2.7.4
>=20

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzuidoACgkQ3SOs138+
s6FwwxAAga8ifvrvDsJAjH0PgPFLDaWAlHBR6Bwzj1eSOGa9GDZF+JC4ob3A4LGL
nd58uu65oQGQTUbqw15NBgDONYrAECX1BCNjvMh1OZgJKajklSB8shnHWwzcoG8b
NmlD5FIq2Ch4YG9rSsRk6g92lrHit6iR6xjEP9dbG+I4JYyyTtWWYBH3n/8vGgYC
HvF++Ub/+9ue7l4VNM6UEcd13sQr3Z1d+gNyTbNfsmqEy32+3k56CLiFAIZL6M71
IvbgQuCW4ZGA3HhFCFJOvdGEweajMuhHQTt0+lLypynbwhxR0T19HZIrkhkAUyvW
k5czuqtPNMkxMcdQVDQAlOo6N/pg3aYxlWvctxVAwwmt5/pV+slQcr+slka4qRXK
uxBlgeiPISVEGxH8Yu1+cPy4N20Il6qM0lLNjgnDGNs9tZj6yzFIuJFutICoAuvh
Ubw0vN0PAXlMweA7Ux3PLTSUX8X4DYAvZU7FcRHT91OWZioJPAQ9TKxJMvndAMzy
zC610iQ9HovjZEgdMlv5z1H3f6sw84/qqBWAk91kt2CXLHjREW0P2oaZGA1u5V9k
J3OrGd5c0ZyjdOiMK3IzUhYbj3hX7eX4hu4u9TBSPQ1bqA0h9zXdoPD8zH1qCHz3
68T65C1Fe6gC4MQXIwR5Mm6eEv69kmdYC14mk7/7Ng6mlQ0mRVQ=
=+vwo
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--

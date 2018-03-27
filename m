Return-Path: <thierry.reding@gmail.com>
Date: Wed, 28 Mar 2018 01:27:01 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 0/2] pwm: rcar: Add suspend/resume support and cleanup
 for runtime_pm
Message-ID: <20180327232701.GA24786@ulmo>
References: <1520929098-20873-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <1520929098-20873-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 05:18:16PM +0900, Yoshihiro Shimoda wrote:
> This patch set improves power management for Renesas PWM driver.
>=20
> Changes from v1:
>  - Add Reviewed-by Geert-san in patch 1 (Thanks!).
>  - Check a condition in suspend/resume if requested or not in patch 2.
>=20
> Hien Dang (1):
>   pwm: rcar: Use PM Runtime to control module clock
>=20
> Yoshihiro Shimoda (1):
>   pwm: rcar: add suspend/resume support
>=20
>  drivers/pwm/pwm-rcar.c | 50 ++++++++++++++++++++++++++++++++++++++++++++=
------
>  1 file changed, 44 insertions(+), 6 deletions(-)

Applied, thanks.

Thierry

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq600IACgkQ3SOs138+
s6EBww/9HN4VdVhQ15y1gF4OswgIsVEDt0WOUJdz729al/1sjIfWJvk/YLNJWv89
q6Yc2WrP4QDR+pqqvioSLcnu6kWSHgiGfzDd6XbxQRUmyrQNkOrB3hdAyZXJ9qre
8gtxaxzP/LJWgb+vGjh8tk+3HevTno9NnItFKwrJtdCZiz0h+oARhy+wGiNNdVfz
FxmYauVSdfeBIMp2e4iXcx5x3REfqlQwmHaGPxwOvmcmIHywj0h2LO8O2Wovz95m
a3MG9udJq7Y9/vcaj6V0OtEZXH3xK44BiboJNaq5+Y4w4zUwZBS9+umgi1xIcfjb
CUDHwHZq+h5n3Ifnd/IOzOaem1KgBt+qQXZzs6RA6XZnWK5aRYc9BdQO197hUXw8
mCwfuhOicQmZO8uTbqJk3tUOjHaG3YBN4AdpgNaOWyTIb03pkJP7eYwQTqWjOXA8
4oMtR0f3HvWn9dvzcupI65kuHC6d9HQnD5NevnvJ+UA5C1NHYjCpYM4zPer5Xt0z
iBWl5FsnwwqO8AXtgczHHpyYx5ccIRQjqlflvbcNESzB77IRtfgQKIWnGL25zDZf
gDB4BeAePrERPuHJy8HoTDq33pcYvNKaf1lklULtKagUMAxrvscbNzk2mcLyIXK/
vnwpYyx8kXPLPpeabsJ6VaXc/RPICM551PiPaXiKFRe8qZ8UhYw=
=JJw9
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

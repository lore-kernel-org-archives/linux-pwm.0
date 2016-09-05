From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 11/17] pwm: sti: Supply PWM Capture clock handling
Date: Mon, 5 Sep 2016 12:42:03 +0200
Message-ID: <20160905104203.GK31424@ulmo.ba.sec>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-12-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8tUgZ4IE8L4vmMyh"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160816093508.28307-12-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--8tUgZ4IE8L4vmMyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2016 at 10:35:02AM +0100, Lee Jones wrote:
> ST's PWM IP is supplied by 2 different clocks.  One for PWM
> Output and the other for Capture.  This patch provides clock
> handling for the latter.
>=20
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/pwm/pwm-sti.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Applied, thanks.

Thierry

--8tUgZ4IE8L4vmMyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzUv6AAoJEN0jrNd/PrOh5loQALQYBe25fCOUH9hUhG++RgpR
MVzrGqd2L9F43Dx28YJtSXiH5vjRwZIoPUnhxD7mcA8tggmACjXwuqfqrBFqxV2M
4iRQnHo0RWRd+KkXBZ9c1FblNNmSW8UnOuDw8ZDDvRKp1NhZPsWvR73wpRJdagft
l6H7kTHrUnTdztCJ40S0ATq3rZgJU858eJS82/GIzQu4WYM1G06ozXCUE0ENC8Yl
jiiNzWHK3IGqkwHY6Iaolky46/bZxjO2YrsNGW/yTggdTV1ohVOnjmOat28Rvldb
2l3L54iWWjiU/5WWGNQ9o/iSfAB2B2vWy0WrxpHvld7j6+XzxNvXikQhiZ18nwDF
NIkA1K5w98AoQ448Uyz9zsC5hI/ithwiZZa8tR/7QPJmYAy1A7qRBCQkzzNZP956
vFkw0OX4y5Fd09Gsu1bkoKsFTQLBzKtprWsATQk0atfApjEAWnMx851md4u+xzbT
Oj0OZrSEWplP3UhRvk2CHp/NgDNPUCT38AOzeJrUe4Tm+aTVd4PZGtW8p3z5sGNk
LGO6HlAJSNueoElEv749Vs9c8wjs2CioTTtxcANV+X29jMo5kDVOZqCXQACeRP/Q
HhlJJLDtUSwef5fPaJpzmVeJyg2U9zfmbo0UUkiqazDDsP8Xts5FJ+GqM9+2+DWx
wtL6NyMHvk67EjnYGciA
=M6cC
-----END PGP SIGNATURE-----

--8tUgZ4IE8L4vmMyh--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

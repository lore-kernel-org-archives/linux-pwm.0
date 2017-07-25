From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] pwm: Convert to using %pOF instead of full_name
Date: Tue, 25 Jul 2017 13:38:54 +0200
Message-ID: <20170725113854.GA22355@ulmo>
References: <20170718214339.7774-45-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170718214339.7774-45-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2017 at 04:43:25PM -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
>=20
> Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> Cc: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> ---
>  drivers/pwm/pwm-meson.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAll3LcoACgkQ3SOs138+
s6HTMA//fz+bs4r8D0dSnuIYttegcttTvpJk0/5rfZiYhSiMgc/vy2Ysa/1bPtt9
2ACeEQZM95tW5L45p9hmW3PMSlRXsSy5F0/4UAwnze5C0WvD378xGgJR0pOIuGBd
8bwBpswV8TV5cu1h5Ly1M36HCJ/paH4CPpJ9wACifDGP1D4j2R1hxHwzxWfhMCTT
XCcp1Jw+xs0eRqyruQ5PL674IXhsC1eWoAVefL6guVYZYUiNPMp+w8z4Imp3PbHl
41s4gHU9viLvloOOQTsZg6yQcJmenSq0TTmKkL0RrUvcBmusKurDGf35eo63bXH7
0Q+uAkX34Br+c1EFCmlbsLZyiktneCk9wsCXzjp0v4l7Sfyy/YOrIxm2e31uzrfi
aRez4tpSuUYP+8p6OdlvC6mOhGk9lMXs8ymm/e3vbdZLtaswBBUu/K2jZCUApw+r
XsyO6oyp+qzmWXjgbU4P6O85uVjIp1fWSPO7JXc/Vreyq/DRRfPvvEo1HQsvnrT/
6VVMsU0CCunnmIt7FabhXSYg5yRUxFET1FJChiIkoDFTsBtCqn/dJlmavc4dfSFV
F14+/eY21gA7nKfkPfUvu4SnFMRxQcFNtNLuGqNRjiLprxBhGCXfh2WgL+9VfNiD
X2vIpYVORdqXgJi64sLsXzcwesvTNlGIEK9TKO25RPlyCgLaWIA=
=pH7M
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

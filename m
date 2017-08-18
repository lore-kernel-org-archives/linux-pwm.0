From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 6/7] pwm: rockchip: Add rk3328 pwm support
Date: Fri, 18 Aug 2017 17:45:22 +0200
Message-ID: <20170818154522.GH18307@ulmo>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
 <1502206967-24366-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WRT3RXLOp/bBMgTI"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1502206967-24366-1-git-send-email-david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--WRT3RXLOp/bBMgTI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 11:42:47PM +0800, David Wu wrote:
> The rk3328 soc supports atomic update, we could lock the configuration
> of period and duty at first, after unlock is configured, the period and
> duty are effective at the same time.
>=20
> If the polarity, period and duty need to be configured together,
> the way for atomic update is "configure lock and old polarity" ->
> "configure period and duty" -> "configure unlock and new polarity".
>=20
> Signed-off-by: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/pwm/pwm-rockchip.c | 43 ++++++++++++++++++++++++++++++++++++++++=
+--
>  1 file changed, 41 insertions(+), 2 deletions(-)

Applied to for-4.14/drivers.

Thierry

--WRT3RXLOp/bBMgTI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmXC5IACgkQ3SOs138+
s6EJiw//VNSz1bku3vHi7OCK/bI4afQ8lX5PzwCct4CNlIFIgT4ImoOa+GcnsOWj
YjojRpkubCnbYMU5WmkQlEp4K/6yImyXdNyHjPP1B+wDwvlsY7YRNHd1uL+oXhyI
Gfi0fqkV8TNL3E3j0gly7G71pj1s+CPZasVTyySCmW9WG0TYQc+TgZXFXrEpaYO5
iBKnJ8OZ1MBpJjoHQLatpLyaunHxT2Kei4J/UcYZ7FwYQYA/dBMtz6WW6GK/BElF
aJz7EZIwrq1i9kKQuc+vYHZcdbYV8JPe2UxjZk+veZmF8qMC19zSlz5KLdEYkyFW
xwPEYb0JGE/jSsfYeIumcoHZ02dIa/yb+clIcznVLVar5hvOAyVRsxABZ34A2CnE
srh/mkEcfY6GNoTGbtQ0wswQDJD7MHdJAVlGf1h+FMfpggpQEIl0AqoSM9SqIYzd
YQiXwcbzbuBKKMzJQzBHlK6ZAyXd0cNc4JkNr+oYxo13fA6H3bcPWCNjLI3uP3Dz
GS41HaxGkURyrb8ByxBtuQpAj42c0Ozfww/BUyHP7xEwTHkV2Tq7o8dhbTxhOqef
PHuw/a1/Qx5uEdEIWB32tMliLuu+L34xW7Uj2Lai7TFX2twVc5fofJdsmTwKIohS
4B0bReDu+dJTECebJYVlkdYp+ViDXlph960DPI48/e0Lyzrqpwo=
=0/oW
-----END PGP SIGNATURE-----

--WRT3RXLOp/bBMgTI--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

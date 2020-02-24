From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] regulator: pwm: Don't warn on probe deferral
Date: Mon, 24 Feb 2020 16:12:54 +0100
Message-ID: <20200224151254.GB2570205@ulmo>
References: <20200224144048.6587-1-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200224144048.6587-1-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2020 at 02:40:48PM +0000, Jon Hunter wrote:
> Deferred probe is an expected return value for devm_pwm_get(). Given
> that the driver deals with it properly, there's no need to output a
> warning that may potentially confuse users.
>=20
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/regulator/pwm-regulator.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5T5/YACgkQ3SOs138+
s6F1tA//XZ0O/MXj5NzYNLezzQBOO9AP+EWE7TGAMZi9h9OgaOiydAtBEKusD2ds
Wnkcuo+5xB/9HDTlLSLgsLbAtCfaxbKXJOnMiXkghKaBH1K6BSbKAGZWncgDKz8s
c6mFgFAhUyVDxY7UHz06cqrtJ3sM2HZbsTVXA4RMC5GZDx79TR17NWAchdMOMwKt
OAWjCFP44ycFN2yq7qwjYn3tEs9fvKMPR0Yrj233ExjadK6f8VltEGG0kWWtxRIy
clbiI1qBTiDs5Z6NdSGD/ma0XmVUy258KlQ3pljJhaE8S8SxOWgTCd+UpgXZtlWD
mW9kqwMrWPpbw5Wtn2P89RL+pinUWGz05HFQPNqBbakRELqcvIRKxfyZfR+gdIjl
u+DaYU9dtk83VJZc3fwt7gMcCLpm56LhgxYmIkWRe50DHuq0s7aQklmDVZmaHv6x
rw8kv+rca3NFQPgbivAHASGOsqqHzTB7QgHZ0T+51PJPMOaQ7SjWBZMn4s/Dgco1
CUtFUPyI8N+MEE0FcLe1k7N2oqbrOr5e9ASpOYccbmkIBVNApNJrydhVWFI3ZE8W
tUj6tyfqDn3PnpTw2JtjZYNLJUyccpn/RXqXi5+rHPgSVD7b611D7SBSOSR5YyvC
k5TWAbjhI230BT9eBRYkO/vCNA2JPwd4HGZZY9Qc6tfPFvx5778=
=mAqf
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--

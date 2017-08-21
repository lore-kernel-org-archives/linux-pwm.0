From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] pwm: pwm-tiecap: Add TI 66AK2G SoC specific
 compatible
Date: Mon, 21 Aug 2017 08:12:34 +0200
Message-ID: <20170821061234.GF18996@ulmo>
References: <20170807114943.22612-1-vigneshr@ti.com>
 <20170807114943.22612-2-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rWhLK7VZz0iBluhq"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170807114943.22612-2-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2017 at 05:19:40PM +0530, Vignesh R wrote:
> Add a new compatible string "ti,k2g-ecap" to support PWM ECAP IP of
> TI 66AK2G SoC.
>=20
> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-4.14/drivers, thanks.

Thierry

--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmaedIACgkQ3SOs138+
s6GZHRAAnuHmEBq/oGgR52BkijTHuQ4yXLF2XLL9nBIPOElBQbz813M2ac9+fXaE
aNlxVptbt2O/lMhlWpRGxvUm+F3ZM7LvDDWLHkSQF13FncLTQ9tAFofVxhD/UNzy
0JCBVQJBr+vDJDiNoLChhBz6OzF/lYkBVBPSag4ecOMHJAw2y8ol6ZPSL71V/fH8
wt2yd18NbdQWjXjuipNWok1gHAgkfz5mqSjjndH15Ct9H/YFcVsQ/dNso1f3POfj
EybZ+309a9CVThuExkMwGbquCSPxpAtt8nkOyCDLuF8FfEUOPKcIef2jXaYAwj5s
y76PnG0SX5is8j4USThzpRnEOP1PAxL5GV/QyYdbRXCpcmHgYtr1N6CVNpu0fmIs
pYNBqJ3eiLQKAWqQx4oYwOlpaIGdLeXQAcdp08CAeFAQMnv6NNVhP1bCxAOupz4t
pe4NvbA5yTX4Hml6Ouz5zqCeAB5LFmKakoOP+7RMlNiW8h3/SQNOjzXij73WCazH
yGmUdrR8QUT6NShTNX23o/W+luwFGrhZ2JRQHo5dwCLzW6QDENT/gyl1rYnxG/Bd
NfJN/XpYlWH7Pv2q1G1Y4tkTRzcbWsLI/KYGvLC2YOhot5rvOOsZuoFPKnWc10XU
LTkpOfFagTY7iaVhJmakcT6Jn6p9JCd7XTMlPAw8MgzqBdcLgvg=
=4VF5
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

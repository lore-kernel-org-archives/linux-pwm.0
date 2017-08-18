From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 3/7] pwm: rockchip: Use pwm_apply instead of the
 pwm_enable
Date: Fri, 18 Aug 2017 17:36:03 +0200
Message-ID: <20170818153603.GD18307@ulmo>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
 <1502206715-24174-4-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1502206715-24174-4-git-send-email-david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 11:38:31PM +0800, David Wu wrote:
> Drop the custom hook of pwm_enable and implement
> pwm_apply_v1 and pwm_apply_v2 instead.
>=20
> Signed-off-by: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
>  drivers/pwm/pwm-rockchip.c | 141 +++++++++++++++++++++++++--------------=
------
>  1 file changed, 77 insertions(+), 64 deletions(-)

Applied to for-4.14/drivers, thanks.

Thierry

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmXCWMACgkQ3SOs138+
s6H+tg//eu6xMs28G5JWXG4cD2JYkkvOMnGGhUucZ3cUCkMqsrFiEl4IC45INhVw
DxCnXXp1SIQRRS2Vj6EmnG/r/B+wWOUihMk+ceO6wt44AvpP+r3kkZl2ta1bA75t
SYqOhna91K1wfLAeIKIlqEHIg8NTH05OQd5VS1GJxgUTJsRNtlog1RfIfQiqbOzp
1xCNqvQF1Aqh+GZtWecOQ8xOAwskkMnO9nagbueAydlKoIVSpAuejiapmXyVhc5B
ii9wOMkEoBu4amZFkte1kghCvxa0uqwPSf6ajTyw25ioO8+An9JWwYyz3xiATkAd
m9djf+k0B9Ko/vVvLeioY3ZcX/1UqHPdo+CAJ7YjDFj+Ke9rUEoyFiB/EcKXkcBu
qmGtqeYiKYp+9lSOAv203As58H8TrWSDFkFLbLYwz4C8PNltgPutdGpPH8My2F8I
MpockJzHckBPAoTbHllz3c3pNIGj02zGFzyTyJ87d7J7tsSH/cLkZTuXnqhOXauL
6udI07Bu0Oc8DY3PieNTZ2xbILzOrF4Y4tjoGnvrMD+2cuoOa7Pd/94etay2enq1
oZiCWgkztPLTfFBgRFODyYHP0ybYpEbA2UqdqvB1dfgJUhCgHGNdtb7Me7quiV84
9ckRNhWorCX//GAuuBkRonmy+1rJnyReVLf/+qALb7j5ECx1JuE=
=WnAt
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

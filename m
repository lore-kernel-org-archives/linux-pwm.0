From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v10 08/12] pwm: mediatek: Add MT7629 compatible string
Date: Fri, 27 Sep 2019 13:28:31 +0200
Message-ID: <20190927112831.GA1171568@ulmo>
References: <1569421957-20765-1-git-send-email-sam.shih@mediatek.com>
 <1569421957-20765-9-git-send-email-sam.shih@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6096961051883250003=="
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1569421957-20765-9-git-send-email-sam.shih-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Sam Shih <sam.shih-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, John Crispin <john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--===============6096961051883250003==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2019 at 10:32:33PM +0800, Sam Shih wrote:
> This adds pwm support for MT7629, and separate mt7629 compatible string
> from mt7622
>=20
> Signed-off-by: Sam Shih <sam.shih-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/pwm/pwm-mediatek.c | 6 ++++++
>  1 file changed, 6 insertions(+)

I picked this patch up and made some minor adjustments to make it build
without the num_pwms patches. With that I don't think there's anything
left from this series that you need.

Let me know if that's not true.

Thierry

>=20
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index ce7525d8d71b..7035abfbdc6a 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -307,11 +307,17 @@ static const struct pwm_mediatek_of_data mt7628_pwm=
_data =3D {
>  	.pwm45_fixup =3D true,
>  };
> =20
> +static const struct pwm_mediatek_of_data mt7629_pwm_data =3D {
> +	.fallback_npwms =3D 1,
> +	.pwm45_fixup =3D false,
> +};
> +
>  static const struct of_device_id pwm_mediatek_of_match[] =3D {
>  	{ .compatible =3D "mediatek,mt2712-pwm", .data =3D &mt2712_pwm_data },
>  	{ .compatible =3D "mediatek,mt7622-pwm", .data =3D &mt7622_pwm_data },
>  	{ .compatible =3D "mediatek,mt7623-pwm", .data =3D &mt7623_pwm_data },
>  	{ .compatible =3D "mediatek,mt7628-pwm", .data =3D &mt7628_pwm_data },
> +	{ .compatible =3D "mediatek,mt7629-pwm", .data =3D &mt7629_pwm_data },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, pwm_mediatek_of_match);
> --=20
> 2.17.1
>=20

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2N8l0ACgkQ3SOs138+
s6HrZw//YXizi7+n/nUsGnoQj0Nd4kpxgNnWEke0I4l6zm4ms4+hqUoPCWiFuZQO
PVvg+lUFZHGpTs72sB45wW81NFgwQbgdqMejJOl5F4oU8qErIMuwIsPJWsT5Pnxo
pezDZZVU545OzICGnWft3wFwh7nFKqQNB3085EApr5YU7jUmVdOTud+K13SfWZEf
0/LgRL2h4bVVkUR4b5ny6tpc8GnTsS/zDgZHXBeLBe95l9yLwPKqkzKLP/e+v4Wu
EH18RZb3Iw9G+q5nsmr7EZBSVnf685DGAW1+VK/w4nGCcjPTFUL0sBXpCFUhbzI7
SXU6YK4oWrXu0gmzqNjjAuTPRC48IU03nTUq8rLUa9EONioZiEOMmtQAq8u7l5hr
DLAo90ZHOMeeBoTNqBNfLkKOqtzBacsZPZycThPEbGBbyafo8cTvf/TWHidhbXvv
B9EL4Amo9AROzun9xmd7FLHa1p1i3df+/lvt7oW+Hs2E09g7gqWiMgYn6aBEnAhs
z9gN8Ys6MhUTpfagvjeA4yNTV02mNxSTobCYui0oQCvBmv13ztlZGLHZ7pTDgOjj
ks6J8EYPxvWBN4YZM+NYaqsOALBssEfB3qTtOsH9dyTELORrtFVKQyFDIUY9gaf9
DSq4SsUFGiOw4l+tXlLojB9JdORs+BasCKXB8ncmz/Vdj6Rn0O4=
=gb7b
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--


--===============6096961051883250003==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-mediatek mailing list
Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-mediatek

--===============6096961051883250003==--

From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC 2/4] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Wed, 10 Oct 2018 15:44:04 +0200
Message-ID: <20181010134404.GC21134@ulmo>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-3-git-send-email-atish.patra@wdc.com>
 <20181010131128.GA29142@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010131128.GA29142@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Atish Patra <atish.patra@wdc.com>, palmer@sifive.com, linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, linus.walleij@linaro.org, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com
List-Id: linux-pwm@vger.kernel.org


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 10, 2018 at 06:11:29AM -0700, Christoph Hellwig wrote:
[...]
> > +static struct platform_driver sifive_pwm_driver =3D {
> > +	.probe =3D sifive_pwm_probe,
> > +	.remove =3D sifive_pwm_remove,
> > +	.driver =3D {
> > +		.name =3D "pwm-sifivem",
> > +		.of_match_table =3D of_match_ptr(sifive_pwm_of_match),
> > +	},
> > +};
>=20
> What about using tabs to align this a little more nicely?
>=20
> static struct platform_driver sifive_pwm_driver =3D {
> 	.probe			=3D sifive_pwm_probe,
> 	.remove			=3D sifive_pwm_remove,
> 	.driver =3D {
> 		.name		=3D "pwm-sifivem",
> 		.of_match_table	=3D of_match_ptr(sifive_pwm_of_match),
> 	},
> };

I discourage people from doing that because down the road somebody might
add a field here that's longer than the alignment tabs and then either
it becomes ugly or they either have to realign everything to keep it
pretty. Single spaces around '=3D' don't have that problem if used
consistently.

Thierry

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlu+AiMACgkQ3SOs138+
s6EREg//bWfq+MbsvCFozGTRY2bewO2oXHvxKIEXUcmof2E5bb4d8Nji84cB29oG
LPQMtazXtr1/3sgvO8z1qd07P97gSHtOmGv5T/pFkMvvDh2bIYzVsvS/qegEabz8
Tjr0qBOUZfvy2NrsR0okSsYJr/qTWFZ6NyTkLZkwPNTKLInj6LxM1jsu7sxcso0K
lmdJ6vlYXeHDAzihK503O9sj1qbuYODppXsXrrqvx5bNdQfKmRZod2rs3kh4CsMa
cQ5hFJI7Kju9j9ndSlhj9s4R85BP00KInQ19+sduOxT490UDX47Fi3CGglQyJDjO
OEyW66jFsBI7y/bnW8ngLFz86Db5/p5iwRx81mLtE4pfrEONY4vjm8bqsHIF3U9R
Gcr1JaF+x3U8SYchjJMrxJjz2cdrzKoVD9XG+cGbzlxNEeWWxuALNZDN8paJkN8q
0QDgxDyc4zdo8mrHgOdlRxY35raBaKZLpUXdm8jYZeUT7oMYRvA0tlAkufbWuKHn
GpK7ERekVaApyNbabJTmk8gYbWIRrcosEpgrNjOrlSgkS92KBfX0TwOxHOUuVaKs
zM0rriWqTYEar2SUxqOuBJEckNVkJI8mKGG5Ks0S3i/hswft8+FFW2FCqgw1iau4
zm5VgMLqmhT+tZ1xFga5rOMQW/zNcBXPOoNqxe8EFvMjJMATjfw=
=cs39
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--

From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v1 3/4] ARM: dts: add pwm pins for r40.
Date: Mon, 15 Jan 2018 09:39:16 +0100
Message-ID: <20180115083916.z7wn5cwungywyevh@flea.lan>
References: <20180111113323.GA21976@arx-s1>
 <20180111124701.g52kjm3hozn72je5@flea.lan>
 <CAJeuY7-FeiEtSkg=udnEx_==3SS=dinyk7fKqhLwdXcKE3510g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qbqwrsydzs6jhe5t"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJeuY7-FeiEtSkg=udnEx_==3SS=dinyk7fKqhLwdXcKE3510g@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Hao Zhang <hao5781286@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, linux@armlinux.org.uk, Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--qbqwrsydzs6jhe5t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2018 at 03:07:46PM +0800, Hao Zhang wrote:
> 2018-01-11 20:47 GMT+08:00 Maxime Ripard <maxime.ripard@free-electrons.co=
m>:
> > Hi,
> >
> > On Thu, Jan 11, 2018 at 07:33:23PM +0800, hao_zhang wrote:
> >> This patch add pwm pins for r40.
> >>
> >> Signed-off-by: hao_zhang <hao5781286@gmail.com>
> >
> > You should order your patches differently. We try to be as bisectable
> > as possible, and if we just apply this patch the DT will not compile
> > anymore.
> >
> > Your patch 4 should come before this one.
> >
>=20
> Do you mean that the order of patch be applied is from the first to
> the last in the patch set ?

Yes and each steps should compile and not introduce any regressions
(ideally :)).

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--qbqwrsydzs6jhe5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpcaLMACgkQ0rTAlCFN
r3Q5UQ//Z4h/LQucBXfTs1nC1b3kulyl0cIhaomwLqiWbWMrjHAHZ+UlOBA7ZbrR
vaq/5h2npdtWfAn0GAYH/Z3ucShe5S1/+lintmjjfz3m07khMckI5reeemHbB+Tc
n8jdHa/oS6K6u3A5gFSTUX6wZMqwNZE9eUtR6MhF5nuysgw5pKOMzLgmdyrtiUjV
cWTrNMHVqMpk+TI1tBTM9Qdhq8/zk5WTxATd3Jn7NLIbMWBj01a9ZN/T3Uegk2nj
hQvjOAVCvFnjS8fZjp+iFQDzwYGcBZERQKQWaP88bCIpAccYaGjcKqtG64v5euGl
vzWeieWKgk853uY8vwTXRKMVQ2NNDgPUUWVIhggO/XbG2Y0m8tZWnsCRMSe0hChs
IxIZao+sQ6vWrI3VDk8gi6l3YxM3GMDgL5YMcdZKUSuGiTf7v2+S8a8xzg67pjRd
abS19Ofwmrkpkx4Et/yXDaNU9KJc4qIxRpsrEMYU90+07BNgY+JjWfsfBlUC03zq
LZb99L7POT8ASTRc6L3c+tuj/Bn7CkgIAxjTfCzmLRqb0MaiBkne29uviYIlcXwx
ztO7iQr2JsTDjagndzJkuVS/skG6QOw35Vg4hM5zfgKFm3rnEqEVcvuqaJxPsoXB
qZgn13jBniELbJ4laeCeLcFGuRGEUT6atD6w9lGljggwclzcM6I=
=FDFV
-----END PGP SIGNATURE-----

--qbqwrsydzs6jhe5t--

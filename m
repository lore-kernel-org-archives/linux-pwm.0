From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH 0/3] Add pwm-cells on STM32 LPTimer
Date: Wed, 28 Mar 2018 00:57:58 +0200
Message-ID: <20180327225757.GK28163@mithrandir>
References: <1519392965-28235-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YZQs1kEQY307C4ut"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1519392965-28235-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: alexandre.torgue@st.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, benjamin.gaignard@linaro.org
List-Id: linux-pwm@vger.kernel.org


--YZQs1kEQY307C4ut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 02:36:02PM +0100, Fabrice Gasnier wrote:
> Add missing generic #pwm-cells on STM32 LPTimer to allow initialization
> of channel, period and polarity.
>=20
> Fabrice Gasnier (1):
>   ARM: dts: stm32: update pwm-cells for LPTimer on stm32h743
>=20
> Gerald Baeza (2):
>   dt-bindings: pwm-stm32-lp: add #pwm-cells
>   pwm: stm32: LPTimer: use 3 cells xlate
>=20
>  Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt | 3 +++
>  arch/arm/boot/dts/stm32h743.dtsi                       | 5 +++++
>  drivers/pwm/pwm-stm32-lp.c                             | 2 ++
>  3 files changed, 10 insertions(+)

Applied patches 1 and 2, thanks.

Thierry

--YZQs1kEQY307C4ut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq6zHUACgkQ3SOs138+
s6Ewuw/+Pvzqzm3HeKqw5SBFJCQzapVxLd5mXoopTKym8rM19GYk3fyNQmTOPdqc
zRNtxBolzGPAZzPtyLtW9p9W85j6C9SVbaXDsANMY+s/bNetjZ5j/YI6MaGd0MPO
As7akyi+NBWmar645OFXeYGyT7v5mVAg+0Yp3h8KMg7mBgpdnAmi2QmdPHGrtSK5
pumEVCXztIpWRm+TXilUh0xNuex9WvHRINH9uLIiORmsBH0zCrSFU9H/nOH84t8a
hxwJCKSDGNRpeSOV4ZCdmlYDYiG7nP7IN0AN2FSIyJgmdHrfakNkyqZTyZ0g/cF+
Jl0xdBw8BnNzKEQob4j95ypdaE2SirIOGSNSKhHv2BcDW/fdfH9wyb44V2QLEckH
wGwH/eeuuCP2gu6uij5ZmGvQX9vRn1LXnQyobDHV4bgp1Nuwgus1DeM2EBY0aPrG
N03kcr+SNbjf7gpwft+0pEFoTmsA5oQtOPoRvSDmRjh+Zd0LwcFTtt6TBhkAvX9x
zRGtTe8QmHEj+iwoONSpcjTVJYw6oSC96y8u/t8H6WiiRVUxF5cOnyeQOXNkrDin
on4e+KwOUmqdxS4Nm/6f9nLefsBNNBJd5OmXm4eJ7bSbB8t8lxcUQIsR3O4uVZBn
3nTDkumEWxOYHefz2zYLYba2kudNOuDdKvt7IhQhxh2HlRcP/6A=
=7nCY
-----END PGP SIGNATURE-----

--YZQs1kEQY307C4ut--

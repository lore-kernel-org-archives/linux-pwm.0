From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCHv10 0/2] Add Allwinner SoCs PWM support
Date: Mon, 19 Jan 2015 14:38:56 +0100
Message-ID: <20150119133855.GB23778@ulmo.nvidia.com>
References: <1418850940-30835-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:53050 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbbASNjB (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Jan 2015 08:39:01 -0500
Content-Disposition: inline
In-Reply-To: <1418850940-30835-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Simon <longsleep@gmail.com>, Olliver Schinagl <oliver@schinagl.nl>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2014 at 10:15:38PM +0100, Alexandre Belloni wrote:
> Hi,
>=20
> This patch series adds support for the PWM controller found on the Allwin=
ner
> SoCs.
>=20
> The first patch adds the driver itself.
> The second patch adds the DT binding documentation
>=20
> Changes in v8:
>  - renamed the driver sun4i as the PWM IP is different in the next sunxi =
SoCs
>  - Took into account comments from Thierry
>=20
> Changes in v9:
>  - moved from using a mutex to a spinlock
>=20
> Changes in v10:
>  - rebased on v3.18
>  - corrected the module name in Kconfig
>  - Added dependancy on HAS_IOMEM and COMMON_CLK
>  - changes clk_rate in sun4i_pwm_config() to be a u64 to avoid unnecessary
>    casting
>  - removed unnecessary braces
>=20
> Alexandre Belloni (2):
>   pwm: Add Allwinner SoC support
>   pwm: sunxi: document OF bindings
>=20
>  .../devicetree/bindings/pwm/pwm-sun4i.txt          |  20 ++
>  drivers/pwm/Kconfig                                |  10 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-sun4i.c                            | 366 +++++++++++++++=
++++++
>  4 files changed, 397 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
>  create mode 100644 drivers/pwm/pwm-sun4i.c

I've applied this series. If anyone still wants to offer a Tested-by or
Reviewed-by, hurry up.

Thierry

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUvQjvAAoJEN0jrNd/PrOhZngP/0fbzpLC2otlUPFIe67ACYtC
BxM32ow6ZD18EWLJIiqyJBQJw+rK+DCnOopToc3grO9fpo2FZbEzQSQAKfr+44C5
vZyP3kgToenHd73HkLlxZWJCjuoIg2Xj4R9qKyqPrEB1ylDvve9QwlCY8NnwGqBJ
0u62eEKKYdADzRS5cbSvlLV86Vs8wWu2Hw4dRsEqpFvug3n1dokvYfikWsAODRat
uabO9LO024BE4LXmuMBp6RVwog4PnkMkvV3VJc2SRstL44S7dmZZA6rZ+Yu0Ld4B
Cyxg4mN1cpnl7olG5Q6cuZmCNIVfYqfwbz7JFLXPo3xhLX/Jn1BydoONQXpSoTjG
it6WThDkblRhjRYUa3x3CedqDWt1jlvfFU+UJm6pN836b5Lvx4eJAfci/gW0UgQA
O/DxibtvJVMLRuJEbL22ie0LodEnjKgM9KRHIWcG4a7SIuKSaKuUkBGqlMbS6zFI
0XdOtpkOZ2MSGRhJEJGYQ3brr+fXgM9t2bgJJAgI3eTnw9pE4qHtG04qvI5a6UTl
fP6z/E79a5IskSscdcWUldIWtmH2zz9oerhqtU2H30z0EvLmosaKl7AhRZMZApoS
uEB8ca42T2Z6oU13Y02Rlp+Dz5NZ5bRI/L1Q7Xz1SGIUkU9E5BpO3ReAEzN6dSHy
Mb5r0p458+f2ZJWE6S5Z
=vTYp
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--

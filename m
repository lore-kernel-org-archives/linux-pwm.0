From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: pwm: binding allwinner sun8i
 R40/V40/T3.
Date: Wed, 13 Dec 2017 16:50:00 +0100
Message-ID: <20171213155000.5qrykowmsawhy3sx@flea.lan>
References: <20171213144309.GA18167@arx-s1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y2veovlt2pdexrge"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:38878 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbdLMPuB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Dec 2017 10:50:01 -0500
Content-Disposition: inline
In-Reply-To: <20171213144309.GA18167@arx-s1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: hao_zhang <hao5781286@gmail.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, wens@csie.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org


--y2veovlt2pdexrge
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 13, 2017 at 10:43:09PM +0800, hao_zhang wrote:
> This patch adds allwinner R40, V40, T3 pwm binding documents.
>=20
> Signed-off-by: hao_zhang <hao5781286@gmail.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-sun8i.txt | 18 +++++++++++++++=
+++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt b/Docume=
ntation/devicetree/bindings/pwm/pwm-sun8i.txt
> new file mode 100644
> index 0000000..76750d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> @@ -0,0 +1,18 @@
> +Allwinner sun8i R40/V40/T3 SoC PWM controller
> +
> +Required properties:
> +- compatible: should be one of:
> +- "allwinner,sun8i-r40-pwm"

Please indent that part.

Once fixed,
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--y2veovlt2pdexrge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAloxTCQACgkQ0rTAlCFN
r3SFsQ/+LtikxtEBXrVwdbjoZeWHwK1bfPCTgHV2vt4hSUVwAO8Tx+RiJGiVOnuI
nlJ0p+TX7YVQ1enWhxarNGUSwxQ4JOUGWmj0x5NKbRcEF4XolLeQZDBmDDxE6lI6
9tvu1jRuT0O7Gv9Ep6gCokz8n/rL1D6HqfKD+bHRvUFK9fGRBHZuzvs0DLEYjJYT
XU4lK1syVw4PqZ/yV+0NHDAoyvx0XQSjbSj570oI/DsfGRUygM+CvoYj52p69VAH
9gh6MRJNIlBCm713tMU/OSwVEwVrvIzqMDnKETxe4/7tYIfgziSmPtdVxPJlBzJz
dj5II556DK0qXD4GzQI+8ZbMleizJ9RX0gJGyN8aarFsoFv1vxMY0NQJOP3MtuxF
1GuveFG5VJGuVIkMVFf+ZrgGCyDvt6ryhLhkrevNLzhrKo0o6GHyELK9yk2pwYn4
gtpmwCJRJjxUiBqe+F0dQAKtdyLhRKtwOylFDf4y2msbXzYSFOWp9xGZX1GwgwAf
DzlPecMZe/PY5+Ye24DzQ7lDh6cR2zKTqq4KMxim04mz2rlJxhhtYv+3z0OWP60q
vqYbzs5AhnuGE0lMShWIxShP9ZclS16oNEdnwZ41Aqx4L/N/Snhe8cOf9vedZg+V
7aLgL6zcT8AWuqnREPjkao+YYmiZTmLgm1htvK6hxb54fTHlsmo=
=BQJC
-----END PGP SIGNATURE-----

--y2veovlt2pdexrge--

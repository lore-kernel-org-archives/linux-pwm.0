From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 0/3] pwm: meson-axg: add pwm controller driver
Date: Tue, 5 Dec 2017 09:52:27 +0100
Message-ID: <20171205085227.GD7386@ulmo>
References: <20171204060018.8856-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3Pql8miugIZX0722"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:35934 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752830AbdLEIwa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Dec 2017 03:52:30 -0500
Content-Disposition: inline
In-Reply-To: <20171204060018.8856-1-yixun.lan@amlogic.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>, Jian Hu <jian.hu@amlogic.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2017 at 02:00:15PM +0800, Yixun Lan wrote:
> This patch series try to add PWM controller driver for the=20
> Amlogic's Meson-AXG SoC. Update the Clock sources, pin DT.
>=20
> Jian Hu (3):
>   dt-bindings: pwm: update bindings for the Meson-AXG
>   pwm: meson: add clock source configuratin for Meson-AXG

Applied both of these, thanks.

Thierry

--3Pql8miugIZX0722
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlomXkoACgkQ3SOs138+
s6E4RA/+KgrZ7PHAoM3+IL/ITWyTALfIf7ZThNvrNL/DtDMA0WOf0dx2plv2976D
CqJOChs0fbsNVxeDS8K7k5xNCuRY15f+tUc0utn944z+0GEuRgcHgK1uTQMTcRHJ
O4oDJSk9kC0RCZRq9T/YwbNHgCQv/miLRO+V36FfTZHk7sT+4DOFek6xlo6Qh14v
BI2m8nVF5i2ORRiU/eAqIKHtjtvlQYSLmraBb3zahBNdbBDB/nvXUoLnOLSuVu2O
FyrFnDotGK4U7ONALhxPO2GREIMhZMS5cjSXrmu+pbxFGVvHtfG8kPeQVQbQaCGs
xjQ28Sjd49LGpILmKqSOghRLvd6iJL4DrmimVkDh7vNHqepRjRbEiBh+XGOIjjFh
C+OnSbsdwiMZS+YdFMzHlo2ADQxABGObILFFCuu3Ok3ovDtX6dhH0BihmKbJHEGL
c3JAwnYuXsI3PT/nLJjTwNQJ7jZlh7pE+f1weinwKzFWd7uz8eui19/Vy/21R/a2
zuI715IjvuwhB0rXA4fwOKfIIcXURvNwU6Pdz5C+7pD4R92Fab3Mm1JORSCGbPgT
2fkLJ8w+EjjN/J5y/8h+O8aE6NU1W045HX5Wy9RhUEdiRsVoJ+K3+vHPE/kxsrV9
LmXInaUb5qXGHvodkzwDLTlPSTIpxQylHiUq8XiKxtGCbbAgEDQ=
=ZjWS
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--

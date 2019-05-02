From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [RESEND][PATCH v3 6/6] drm/atmel-hclcdc: revert shift by 8
Date: Thu, 2 May 2019 09:43:21 +0200
Message-ID: <20190502074321.6g26negwuqdjswrx@flea>
References: <1556195748-11106-1-git-send-email-claudiu.beznea@microchip.com>
 <1556195748-11106-7-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6uagg5yh6vlrxpcb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556195748-11106-7-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu.Beznea@microchip.com
Cc: bbrezillon@kernel.org, airlied@linux.ie, daniel@ffwll.ch, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, thierry.reding@gmail.com, lee.jones@linaro.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--6uagg5yh6vlrxpcb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 25, 2019 at 12:36:39PM +0000, Claudiu.Beznea@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>
> Revert shift by 8 of state->base.alpha. This introduced regresion
> on planes.
>
> Fixes: 7f73c10b256b ("drm/atmel-hclcdc: Convert to the new generic alpha property")
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--6uagg5yh6vlrxpcb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXMqfmQAKCRDj7w1vZxhR
xcseAP4vdJgH1hul/wM47RFdoRnyzZFVdLXER2Iuq1hWJ+PK0gEAtTag2QpyiY56
rGojbjlWkUYDM93h+BP6r0Fj5J5+4Q0=
=yTPE
-----END PGP SIGNATURE-----

--6uagg5yh6vlrxpcb--

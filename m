From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4 2/5] dt-bindings: pwm-backlight: add PWM delay
 proprieties.
Date: Mon, 24 Jul 2017 21:19:47 +0200
Message-ID: <20170724191947.GB32425@amd>
References: <20170721104813.5389-1-enric.balletbo@collabora.com>
 <20170721104813.5389-2-enric.balletbo@collabora.com>
 <61fbc94d-76d7-be7e-c0b3-30d27845434b@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34168 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755912AbdGXTTu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Jul 2017 15:19:50 -0400
Content-Disposition: inline
In-Reply-To: <61fbc94d-76d7-be7e-c0b3-30d27845434b@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2017-07-24 16:21:44, Daniel Thompson wrote:
> On 21/07/17 11:48, Enric Balletbo i Serra wrote:
> >Hardware needs a delay between setting an initial (non-zero) PWM and
> >enabling the backlight using GPIO. The post-pwm-on-delay-ms specifies
> >this delay in milli seconds. Hardware also needs a delay between disabing
> >the backlight using GPIO and setting PWM value to 0. The pwm-off-delay-ms
> >is this delay in milli seconds.
> >
> >Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >Acked-by: Pavel Machek <pavel@ucw.cz>
> >---
> >Based on the original Huang Lin <hl@rock-chips.com> work.
> >
> >Changes since v3:
> >  - Replace us for ms.
> >  - Add Acked-by: Pavel Machek <pavel@ucw.cz>
> >Changes since v2:
> >  - Use separate properties (Rob Herring)
> >Changes since v1:
> >  - As suggested by Daniel Thompson
> >    - Do not assume power-on delay and power-off delay will be the same
> >
> >  Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt | 6=
 ++++++
> >  1 file changed, 6 insertions(+)
> >
> >diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backli=
ght.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> >index 764db86..3108109 100644
> >--- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> >+++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> >@@ -17,6 +17,10 @@ Optional properties:
> >                 "pwms" property (see PWM binding[0])
> >    - enable-gpios: contains a single GPIO specifier for the GPIO which =
enables
> >                    and disables the backlight (see GPIO binding[1])
> >+  - post-pwm-on-delay-ms: Delay in ms between setting an initial (non-z=
ero) PWM
> >+                          and enabling the backlight using GPIO.
> >+  - pwm-off-delay-ms: Delay in ms between disabling the backlight using=
 GPIO
> >+                      and setting PWM value to 0.
>=20
> Whilst it is strictly true that the delay you added to the driver is
> currently between disabling the backlight and setting PWM value to 0 I do=
n't
> think the action should be described at this level of detail in the DT
> bindings.
>=20
> The semantic action that is being performed is "stopping the PWM". This is
> currently implemented by setting the duty cycle to 0 and then calling
> disable but that could change (especially so since the current behavior
> looks asymmetric versus the enable sequence).

Well, datasheet say the delay is required between given actions, so
yes, I'd say that belongs in the device tree at this level of detail.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAll2SFMACgkQMOfwapXb+vIlewCeJGX0Vfe9tiUGSd9xH0pKy1JW
lokAn2XUwgXfxIvJFxFNTWatx4g936VP
=c3j0
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--

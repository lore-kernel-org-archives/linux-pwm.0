From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCHv2] backlight: pwm_bl: disable PWM when 'duty_cycle' is
 zero
Date: Thu, 9 Jun 2016 14:51:25 +0100
Message-ID: <20160609135125.GA2385@dell>
References: <1465294429-8570-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36122 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbcFINuw (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jun 2016 09:50:52 -0400
Received: by mail-wm0-f47.google.com with SMTP id n184so226433837wmn.1
        for <linux-pwm@vger.kernel.org>; Thu, 09 Jun 2016 06:50:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1465294429-8570-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jingoohan1@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org

On Tue, 07 Jun 2016, Lothar Wa=C3=9Fmann wrote:

> 'brightness' is usually an index into a table of duty_cycle values,
> where the value at index 0 may well be non-zero
> (tegra30-apalis-eval.dts and tegra30-colibri-eval-v3.dts are real-lif=
e
> examples).
> Thus brightness =3D=3D 0 does not necessarily mean that the PWM outpu=
t
> will be inactive.
> Check for 'duty_cycle =3D=3D 0' rather than 'brightness =3D=3D 0' to =
decide
> whether to disable the PWM.
>=20
> Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> ---
> Changes wrt. v1:
>   - update binding docs to reflect the change
>=20
>  .../devicetree/bindings/leds/backlight/pwm-backlight.txt         | 9=
 ++++++---
>  drivers/video/backlight/pwm_bl.c                                 | 4=
 ++--
>  2 files changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-bac=
klight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backl=
ight.txt
> index 764db86..95fa8a9 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.=
txt
> +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.=
txt
> @@ -4,10 +4,13 @@ Required properties:
>    - compatible: "pwm-backlight"
>    - pwms: OF device-tree PWM specification (see PWM binding[0])
>    - brightness-levels: Array of distinct brightness levels. Typicall=
y these
> -      are in the range from 0 to 255, but any range starting at 0 wi=
ll do.
> +      are in the range from 0 to 255, but any range will do.
>        The actual brightness level (PWM duty cycle) will be interpola=
ted
> -      from these values. 0 means a 0% duty cycle (darkest/off), whil=
e the
> -      last value in the array represents a 100% duty cycle (brightes=
t).
> +      from these values. 0 means a 0% duty cycle, while the highest =
value in
> +      the array represents a 100% duty cycle.
> +      The range may be in reverse order (starting with the maximum d=
uty cycle
> +      value) to create a PWM signal with the 100% duty cycle represe=
nting
> +      minimum and 0% duty cycle maximum brigthness.
>    - default-brightness-level: the default brightness level (index in=
to the
>        array defined by the "brightness-levels" property)
>    - power-supply: regulator for supply voltage
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlig=
ht/pwm_bl.c
> index b2b366b..80b2b52 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -103,8 +103,8 @@ static int pwm_backlight_update_status(struct bac=
klight_device *bl)
>  	if (pb->notify)
>  		brightness =3D pb->notify(pb->dev, brightness);
> =20
> -	if (brightness > 0) {
> -		duty_cycle =3D compute_duty_cycle(pb, brightness);
> +	duty_cycle =3D compute_duty_cycle(pb, brightness);
> +	if (duty_cycle > 0) {

How does this work in the aforementioned:

  "The range may be in reverse order"

=2E.. case?  Surely when duty_cycle is when the screen should be at it'=
s
brightest?  Wouldn't it confuse the user if they turn their brightness
*up* and the screen goes *off*?

>  		pwm_config(pb->pwm, duty_cycle, pb->period);
>  		pwm_backlight_power_on(pb, brightness);
>  	} else

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

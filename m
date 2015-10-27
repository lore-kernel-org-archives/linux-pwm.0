From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 07/10] pwm: gpio: Add a generic gpio based PWM driver
Date: Tue, 27 Oct 2015 02:42:48 -0500
Message-ID: <CAL_Jsq+98bBt5-+Of-u6jCdGBiZfMvL=P=mMpvWT26qnPFMz5A@mail.gmail.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com> <1445895161-2317-8-git-send-email-o.schinagl@ultimaker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54391 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753544AbbJ0HnM (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 27 Oct 2015 03:43:12 -0400
In-Reply-To: <1445895161-2317-8-git-send-email-o.schinagl@ultimaker.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: Olliver Schinagl <oliver@schinagl.nl>, Thierry Reding <thierry.reding@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Joachim Eastwood <manabian@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Olliver Schinagl <oliver+list@schinagl.nl>, Linux PWM List <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Oct 26, 2015 at 4:32 PM, Olliver Schinagl
<o.schinagl@ultimaker.com> wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
>
> This patch adds a bit-banging gpio PWM driver. It makes use of hrtimers,
> to allow nano-second resolution, though it obviously strongly depends on
> the switching speed of the gpio pins, hrtimer and system load.
>
> Each pwm node can have 1 or more "pwm-gpio" entries, which will be
> treated as pwm's as part of a pwm chip.
>
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-gpio.txt |  18 ++
>  MAINTAINERS                                        |   5 +
>  drivers/pwm/Kconfig                                |  15 ++
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-gpio.c                             | 253 +++++++++++++++++++++
>  5 files changed, 292 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.txt
>  create mode 100644 drivers/pwm/pwm-gpio.c
>
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-gpio.txt b/Documentation/devicetree/bindings/pwm/pwm-gpio.txt
> new file mode 100644
> index 0000000..336f61f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-gpio.txt
> @@ -0,0 +1,18 @@
> +Generic GPIO bit-banged PWM driver
> +
> +Required properties:
> +  - compatible: should be "pwm-gpio"
> +  - #pwm-cells: should be 3, see pwm.txt in this directory for a general
> +    description of the cells format.
> +  - pwm-gpios: one or more gpios describing the used gpio, see the gpio
> +    bindings for the used gpio driver.

I'm not sure there is really much advantage to having multiple gpios
per node. It would simplify the driver a bit not to, but I don't feel
strongly either way.

> +
> +Example:
> +#include <dt-bindings/gpio/gpio.h>
> +
> +       pwm: pwm@0 {

Unit address should be associated with a reg property, so drop it.

> +               compatible = "pwm-gpio";
> +               #pwm-cells = 3;
> +               pwm-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>;
> +               pwm-gpios = <&pio 7 2 GPIO_ACTIVE_LOW>;

This would not actually compile. You can't have 2 properties of the same name.

> +       };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ba7ab7..0ae7fbf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4555,6 +4555,11 @@ F:       drivers/i2c/muxes/i2c-mux-gpio.c
>  F:     include/linux/i2c-mux-gpio.h
>  F:     Documentation/i2c/muxes/i2c-mux-gpio
>
> +GENERIC GPIO PWM DRIVER
> +M:     Olliver Schinagl <oliver@schinagl.nl>
> +S:     Maintained
> +F:     drivers/pwm/pwm-gpio.c

Can you add the binding doc too.

Rob

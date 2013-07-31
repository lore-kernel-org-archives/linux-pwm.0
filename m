Return-Path: <lee.jones@linaro.org>
Return-Path: <lee.jones@linaro.org>
Date: Wed, 31 Jul 2013 12:09:29 +0100
From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 4/4] Documentation: dt: bindings: add LP3943 bindings
Message-ID: <20130731110929.GG13298@lee--X1>
References: <A874F61F95741C4A9BA573A70FE3998F82E849ED@DQHE06.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A874F61F95741C4A9BA573A70FE3998F82E849ED@DQHE06.ent.ti.com>
List-ID: <linux-pwm.vger.kernel.org>
To: "Kim, Milo" <Milo.Kim@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Samuel Ortiz (sameo@linux.intel.com)" <sameo@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

On Tue, 30 Jul 2013, Kim, Milo wrote:

> Bindings for LP3943 MFD, GPIO and PWM controller are added.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Milo Kim <milo.kim@ti.com>
> ---
>  .../devicetree/bindings/gpio/gpio-lp3943.txt       |   42 +++++++++++++
>  Documentation/devicetree/bindings/mfd/lp3943.txt   |   33 ++++++++++
>  .../devicetree/bindings/pwm/pwm-lp3943.txt         |   65 ++++++++++++++++++++
>  3 files changed, 140 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-lp3943.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/lp3943.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-lp3943.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-lp3943.txt b/Documentation/devicetree/bindings/gpio/gpio-lp3943.txt
> new file mode 100644
> index 0000000..952fefd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-lp3943.txt
> @@ -0,0 +1,42 @@
> +TI/National Semiconductor LP3943 GPIO controller
> +
> +Required properties:
> +  - compatible: "ti,lp3943-gpio"
> +  - gpio-controller: device node as a GPIO controller
> +  - #gpio-cells: Should be two.
> +    1) pin number offset
> +    2) GPIO polarity
> +       0 = active high, 1 = active low

Please use the defines instead on '0' and '1':
    include/dt-bindings/gpio/gpio.h

> +		gpios = <&gpioex 9 1>;	/* active-low */

> +		gpios = <&gpioex 10 1>;	/* active-low */

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

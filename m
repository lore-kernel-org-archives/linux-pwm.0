From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3 2/2] drivers: pwm: pwm-atmel: enable PWM on sama5d2
Date: Mon, 27 Mar 2017 15:03:09 +0200
Message-ID: <20170327150309.14084428@bbrezillon>
References: <1490189375-20384-1-git-send-email-claudiu.beznea@microchip.com>
        <1490189375-20384-3-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490189375-20384-3-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, alexandre.belloni@free-electrons.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com, cristian.birsan@microchip.com, andrei.pistirica@microchip.com, tudor.ambarus@microchip.com, eugen.hristev@microchip.com
List-Id: linux-pwm@vger.kernel.org

On Wed, 22 Mar 2017 15:29:35 +0200
Claudiu Beznea <claudiu.beznea@microchip.com> wrote:

> sama5d2 can use the same atmel_pwm_data as sama5d3.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> 
> ---
> Changes since v2:
> - the variable name used to initialize the .data member of
> the of_device_id was renamed to atmel_pwm_regs_v2 to be
> consistent with the approach from the first patch from
> this series
> 
>  Documentation/devicetree/bindings/pwm/atmel-pwm.txt | 1 +
>  drivers/pwm/pwm-atmel.c                             | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
> index 02331b9..c8c831d 100644
> --- a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
> @@ -4,6 +4,7 @@ Required properties:
>    - compatible: should be one of:
>      - "atmel,at91sam9rl-pwm"
>      - "atmel,sama5d3-pwm"
> +    - "atmel,sama5d2-pwm"
>    - reg: physical base address and length of the controller's registers
>    - #pwm-cells: Should be 3. See pwm.txt in this directory for a
>      description of the cells format.
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index f147154..530d7dc 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -312,6 +312,9 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
>  		.compatible = "atmel,sama5d3-pwm",
>  		.data = &atmel_pwm_regs_v2,
>  	}, {
> +		.compatible = "atmel,sama5d2-pwm",
> +		.data = &atmel_pwm_regs_v2,
> +	}, {
>  		/* sentinel */
>  	},
>  };

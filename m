From: Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 07/10] dt-bindings: rtc: Add bindings for Netronix
 embedded controller RTC
Date: Sun, 21 Jun 2020 02:02:20 +0200
Message-ID: <20200621000220.GB131826@piout.net>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
 <20200620224222.1312520-6-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200620224222.1312520-6-j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko.stuebner-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>, Stephan Gerhold <stephan-3XONVrnlUWDR7s880joybQ@public.gmane.org>, Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, allen <allen.chen-4K37Az1KcQB9nmWX13WWKA@public.gmane.org>, Mauro Carvalho Chehab <mchehab+huawei-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi,

On 21/06/2020 00:42:18+0200, Jonathan Neuschäfer wrote:
> The Netronix EC implements an RTC with the following functionality:
> 
> - Calendar-based time keeping with single-second resolution
> - Automatic power-on with single-minute resolution
> - Alarm at single-second resolution
> 
> This binding only supports timekeeping for now.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
> ---
>  .../bindings/mfd/netronix,ntxec.yaml          |  7 +++++
>  .../bindings/rtc/netronix,ntxec-rtc.yaml      | 27 +++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> index 6562c41c5a9a9..f6a32f46f47bb 100644
> --- a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> +++ b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> @@ -34,6 +34,9 @@ properties:
>    pwm:
>      $ref: ../pwm/netronix,ntxec-pwm.yaml
> 
> +  rtc:
> +    $ref: ../rtc/netronix,ntxec-rtc.yaml
> +

Shouldn't the node simply be documented here?

Also, do you really need a compatible string to be able to proe the
driver? What are the chances that you'll get a similar EC without an
RTC?

>  required:
>    - compatible
>    - reg
> @@ -61,6 +64,10 @@ examples:
>                              compatible = "netronix,ntxec-pwm";
>                              #pwm-cells = <1>;
>                      };
> +
> +                    rtc {
> +                            compatible = "netronix,ntxec-rtc";
> +                    };
>              };
>      };
> 
> diff --git a/Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.yaml b/Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.yaml
> new file mode 100644
> index 0000000000000..4b301ef7319c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.yaml
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/netronix,ntxec-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RTC functionality in Netronix embedded controller
> +
> +maintainers:
> +  - Jonathan Neuschäfer <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
> +
> +description: |
> +  See also Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> +
> +  The Netronix EC contains an RTC, which can be used for time-keeping, alarm,
> +  and automatic power-on. Note that not all of this functionality is currently
> +  supported in this binding.
> +
> +allOf:
> +  - $ref: "rtc.yaml#"
> +
> +properties:
> +  compatible:
> +    const: netronix,ntxec-rtc
> +
> +required:
> +  - compatible
> --
> 2.27.0
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

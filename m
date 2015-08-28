From: Florian Fainelli <fainelli-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] Documentation: dt: add Broadcom BCM7038 PWM controller
 binding
Date: Thu, 27 Aug 2015 17:47:54 -0700
Message-ID: <55DFAFBA.1090804@broadcom.com>
References: <1440440877-10644-1-git-send-email-f.fainelli@gmail.com> <1440440877-10644-2-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1440440877-10644-2-git-send-email-f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On 24/08/15 11:27, Florian Fainelli wrote:
> Add a binding documentation for the Broadcom BCM7038 PWM controller found in
> BCM7xxx chips.

Got to think about this some more, I will just remove the optional
"clocks" phandle, since the PWM block really needs a input clock to
operate, will respin a v3 with these changes shortly.

> 
> Signed-off-by: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  .../devicetree/bindings/pwm/brcm,bcm7038-pwm.txt   | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
> new file mode 100644
> index 000000000000..8b9bc43b561e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
> @@ -0,0 +1,22 @@
> +Broadcom BCM7038 PWM controller (BCM7xxx Set Top Box PWM controller)
> +
> +Required properties:
> +
> +- compatible: must be "brcm,bcm7038-pwm"
> +- reg: physical base address and length for this controller
> +- #pwm-cells: should be 2. See pwm.txt in this directory for a description
> +  of the cells format.
> +
> +Optional properties:
> +
> +- clocks: a phandle to the reference clock for this block which is fed through
> +  its internal variable clock frequency generator
> +
> +Example:
> +
> +	pwm: pwm@f0408000 {
> +		compatible = "brcm,bcm7038-pwm";
> +		reg = <0xf0408000 0x28>;
> +		#pwm-cells = <2>;
> +		clocks = <&upg_fixed>;
> +	};
> 


-- 
Florian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

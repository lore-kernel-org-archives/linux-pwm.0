From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 16/23] dt-bindings: pwm: add description for rv1108 pwm
Date: Thu, 10 Aug 2017 11:17:27 -0500
Message-ID: <20170810161727.ql4zhot2awlvqc7c@rob-hp-laptop>
References: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
 <1501663675-12591-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1501663675-12591-1-git-send-email-andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Aug 02, 2017 at 04:47:55PM +0800, Andy Yan wrote:
> Add device tree bindings document for pwm on
> rockchip rv1108 soc.
> 
> Signed-off-by: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/pwm/pwm-rockchip.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
> index 2350ef9..b49f121 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
> @@ -3,7 +3,7 @@ Rockchip PWM controller
>  Required properties:
>   - compatible: should be "rockchip,<name>-pwm"
>     "rockchip,rk2928-pwm": found on RK29XX,RK3066 and RK3188 SoCs
> -   "rockchip,rk3288-pwm": found on RK3288 SoC
> +   "rockchip,rk3288-pwm": found on RK3288 and RV1108 SoCs

This should be: "rockchip,rv1108-pwm", "rockchip,rk3288-pwm"

If the RV1108 version is compatible with the RK3288 version.

>     "rockchip,vop-pwm": found integrated in VOP on RK3288 SoC
>   - reg: physical base address and length of the controller's registers
>   - clocks: See ../clock/clock-bindings.txt
> -- 
> 2.7.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/3] dt-bindings: pwm: kona: Add new compatible for new
 version pwm-kona
Date: Fri, 11 Jan 2019 21:48:01 +0100
Message-ID: <20190111204801.2ytdeblcai7lg3on@pengutronix.de>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547184076-20521-2-git-send-email-sheetal.tigadoli@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547184076-20521-2-git-send-email-sheetal.tigadoli@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Praveen Kumar B <praveen.b@broadcom.com>
List-Id: linux-pwm@vger.kernel.org

On Fri, Jan 11, 2019 at 10:51:14AM +0530, Sheetal Tigadoli wrote:
> From: Praveen Kumar B <praveen.b@broadcom.com>
> 
> Add new compatible string for new version of pwm-kona
> 
> Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
> ---
>  Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
> index 8eae9fe..d37f697 100644
> --- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
> @@ -3,7 +3,7 @@ Broadcom Kona PWM controller device tree bindings
>  This controller has 6 channels.
>  
>  Required Properties :
> -- compatible: should contain "brcm,kona-pwm"
> +- compatible: should contain "brcm,kona-pwm" or "brcm,kona-pwm-v2"

Is v2 used on a newer generation of kona SoCs? On i.MX these variants
are usually named after the first SoC that came with the new variant. Is
this sensible here, too?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

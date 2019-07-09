From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: Remove unused compatible strings
Date: Mon, 8 Jul 2019 20:04:25 -0600
Message-ID: <20190709020425.GA7984@bogus>
References: <20190607154410.10633-1-paul@crapouillou.net>
 <20190607154410.10633-2-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190607154410.10633-2-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 07, 2019 at 05:44:05PM +0200, Paul Cercueil wrote:
> Right now none of the Ingenic-based boards probe this driver from
> devicetree. This driver defined three compatible strings for the exact
> same behaviour. Before these strings are used, we can remove two of
> them.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: Rebase on v5.2-rc3
> 
>  Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
> index 7d9d3f90641b..493bec80d59b 100644
> --- a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
> @@ -2,10 +2,7 @@ Ingenic JZ47xx PWM Controller
>  =============================
>  
>  Required properties:
> -- compatible: One of:
> -  * "ingenic,jz4740-pwm"
> -  * "ingenic,jz4770-pwm"
> -  * "ingenic,jz4780-pwm"
> +- compatible: Should be "ingenic,jz4740-pwm"

Are you sure all 3 chips are exactly the same features and bugs?

The correct thing to do here generally is the 4770 and 4780 would also 
have ingenic,jz4740-pwm as a fallback compatible. Then the driver can 
match on that until you find some difference and can use the more 
specific compatible.

>  - #pwm-cells: Should be 3. See pwm.txt in this directory for a description
>    of the cells format.
>  - clocks : phandle to the external clock.
> -- 
> 2.21.0.593.g511ec345e18
> 

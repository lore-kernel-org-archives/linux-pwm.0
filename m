From: Simon Horman <horms@verge.net.au>
Subject: Re: [v3,5/6] pwm: add R-Car H3 device tree bindings
Date: Wed, 6 Apr 2016 10:23:31 +0900
Message-ID: <20160406012331.GJ27262@verge.net.au>
References: <1459424356-26061-6-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459424356-26061-6-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, magnus.damm@gmail.com
List-Id: linux-pwm@vger.kernel.org

On Thu, Mar 31, 2016 at 01:39:15PM +0200, Ulrich Hecht wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> index 0822a08..d6de643 100644
> --- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> +++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> @@ -7,6 +7,7 @@ Required Properties:
>   - "renesas,pwm-r8a7790": for R-Car H2
>   - "renesas,pwm-r8a7791": for R-Car M2-W
>   - "renesas,pwm-r8a7794": for R-Car E2
> + - "renesas,pwm-r8a7795": for R-Car H3
>  - reg: base address and length of the registers block for the PWM.
>  - #pwm-cells: should be 2. See pwm.txt in this directory for a description of
>    the cells format.

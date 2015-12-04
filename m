From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt: lpc32xx: pwm: update documentation of LPC32xx PWM
 device
Date: Fri, 4 Dec 2015 09:59:51 -0600
Message-ID: <20151204155951.GA30447@rob-hp-laptop>
References: <1449206553-26133-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54752 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753614AbbLDP7z (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Fri, 4 Dec 2015 10:59:55 -0500
Content-Disposition: inline
In-Reply-To: <1449206553-26133-1-git-send-email-vz@mleia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org

On Fri, Dec 04, 2015 at 07:22:33AM +0200, Vladimir Zapolskiy wrote:
> LPC32xx SoC has two independent PWM controllers, they have different
> clock parents, clock gates and slightly different controls, each of
> these two PWM controllers has one output channel.
> 
> The change updates device tree binding documentation to reflect two PWM
> devices.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> index cfe1db3..ab0907d 100644
> --- a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> @@ -8,5 +8,10 @@ Examples:
>  
>  pwm@0x4005C000 {
>  	compatible = "nxp,lpc3220-pwm";
> -	reg = <0x4005C000 0x8>;
> +	reg = <0x4005C000 0x4>;
> +};
> +
> +pwm@0x4005C004 {

Remove the '0x' and use lower case hex chars.

Rob

> +	compatible = "nxp,lpc3220-pwm";
> +	reg = <0x4005C004 0x4>;
>  };
> -- 
> 2.1.4
> 

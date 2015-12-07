From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/6] dt: lpc32xx: pwm: correct LPC32xx PWM device node
 example
Date: Mon, 7 Dec 2015 08:41:13 -0600
Message-ID: <20151207144113.GA6832@rob-hp-laptop>
References: <1449401522-22590-1-git-send-email-vz@mleia.com>
 <1449401522-22590-2-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39854 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932146AbbLGOlR (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 7 Dec 2015 09:41:17 -0500
Content-Disposition: inline
In-Reply-To: <1449401522-22590-2-git-send-email-vz@mleia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Roland Stigge <stigge@antcom.de>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org

On Sun, Dec 06, 2015 at 01:31:57PM +0200, Vladimir Zapolskiy wrote:
> The change removes '0x' from a device node address and uses lower case
> hex chars.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
> Changes from v1 to v2:
> - new change
> 
>  Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> index cfe1db3..1ab1abc 100644
> --- a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> @@ -6,7 +6,7 @@ Required properties:
>  
>  Examples:
>  
> -pwm@0x4005C000 {
> +pwm@4005c000 {
>  	compatible = "nxp,lpc3220-pwm";
> -	reg = <0x4005C000 0x8>;
> +	reg = <0x4005c000 0x8>;
>  };
> -- 
> 2.1.4
> 

From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/6] dt: lpc32xx: pwm: update documentation of LPC32xx
 PWM device
Date: Mon, 7 Dec 2015 08:42:20 -0600
Message-ID: <20151207144220.GA7414@rob-hp-laptop>
References: <1449401522-22590-1-git-send-email-vz@mleia.com>
 <1449401522-22590-3-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40023 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932358AbbLGOmY (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 7 Dec 2015 09:42:24 -0500
Content-Disposition: inline
In-Reply-To: <1449401522-22590-3-git-send-email-vz@mleia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Roland Stigge <stigge@antcom.de>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org

On Sun, Dec 06, 2015 at 01:31:58PM +0200, Vladimir Zapolskiy wrote:
> NXP LPC32xx SoC has two separate PWM controller devices, update device
> tree binding documentation to reflect this fact.
> 
> The change makes previous PWM device node description incompatible
> with the new version.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
> Changes from v1 to v2:
> - removed '0x' from a device node address and use lower case hex chars.
> 
>  Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> index 1ab1abc..74b5bc5 100644
> --- a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> @@ -8,5 +8,10 @@ Examples:
>  
>  pwm@4005c000 {
>  	compatible = "nxp,lpc3220-pwm";
> -	reg = <0x4005c000 0x8>;
> +	reg = <0x4005c000 0x4>;
> +};
> +
> +pwm@4005c004 {
> +	compatible = "nxp,lpc3220-pwm";
> +	reg = <0x4005c004 0x4>;
>  };
> -- 
> 2.1.4
> 

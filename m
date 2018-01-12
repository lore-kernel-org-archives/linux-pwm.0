From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 03/16] pwm: cros-ec: update documentation regarding
 pwm-cells
Date: Fri, 12 Jan 2018 10:31:23 -0800
Message-ID: <20180112183122.GA102880@google.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-4-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35635 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965141AbeALSb0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Jan 2018 13:31:26 -0500
Received: by mail-pg0-f65.google.com with SMTP id d6so5097555pgv.2
        for <linux-pwm@vger.kernel.org>; Fri, 12 Jan 2018 10:31:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1515766983-15151-4-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, corbet@lwn.net, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Fri, Jan 12, 2018 at 04:22:50PM +0200, Claudiu Beznea wrote:
> pwm-cells should be at least 2 to provide channel number and period value.

Nacked-by: Brian Norris <briannorris@chromium.org>

We don't control the period from the kernel; only the duty cycle. (Now,
that's perhaps not a wise firmware interface, and we may fix that
someday, but you can't just declare a breaking change to a documented,
reviewed binding.)

> Cc: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
> index 472bd46ab5a4..03347fd302b5 100644
> --- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
> @@ -8,7 +8,7 @@ Documentation/devicetree/bindings/mfd/cros-ec.txt).
>  
>  Required properties:
>  - compatible: Must contain "google,cros-ec-pwm"
> -- #pwm-cells: Should be 1. The cell specifies the PWM index.
> +- #pwm-cells: Should be 2. The cell specifies the PWM index.

Umm, "2 cells", but you use the singular "cell", and don't document what
the second one is? That's nonsense.

Brian

>  
>  Example:
>  	cros-ec@0 {
> @@ -18,6 +18,6 @@ Example:
>  
>  		cros_ec_pwm: ec-pwm {
>  			compatible = "google,cros-ec-pwm";
> -			#pwm-cells = <1>;
> +			#pwm-cells = <2>;
>  		};
>  	};
> -- 
> 2.7.4
> 

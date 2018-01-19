From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 10/16] pwm: Add PWM modes
Date: Fri, 19 Jan 2018 16:34:52 -0600
Message-ID: <20180119223452.doeqfd4aewkf5fla@rob-hp-laptop>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-11-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:38252 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756585AbeASWey (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 19 Jan 2018 17:34:54 -0500
Content-Disposition: inline
In-Reply-To: <1515766983-15151-11-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: thierry.reding@gmail.com, mark.rutland@arm.com, linux@armlinux.org.uk, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, corbet@lwn.net, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Fri, Jan 12, 2018 at 04:22:57PM +0200, Claudiu Beznea wrote:
> Define a macros for PWM modes to be used by device tree sources.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  include/dt-bindings/pwm/pwm.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
> index ab9a077e3c7d..b8617431f8ec 100644
> --- a/include/dt-bindings/pwm/pwm.h
> +++ b/include/dt-bindings/pwm/pwm.h
> @@ -12,4 +12,7 @@
>  
>  #define PWM_POLARITY_INVERTED			(1 << 0)
>  
> +#define PWM_DTMODE_NORMAL			(1 << 0)

Bit 0 is already taken. I think you mean (0 << 1)?

Personally, I'd just drop this define. A define for a 0 value makes more 
sense when each state is equally used (like active high or low), but if 
0 is the more common case, then I don't the need for a define.

> +#define PWM_DTMODE_COMPLEMENTARY		(1 << 1)
> +
>  #endif
> -- 
> 2.7.4
> 

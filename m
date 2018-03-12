From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH v5 2/5] dt-bindings: pwm-backlight: add PWM delay
 proprieties.
Date: Mon, 12 Mar 2018 09:10:41 +0000
Message-ID: <20180312091041.5sk3t27n5tryikie@dell>
References: <20180216174034.15936-1-enric.balletbo@collabora.com>
 <20180216174034.15936-2-enric.balletbo@collabora.com>
 <20180219111136.jpv4wtcm6h2hfwac@oak.lan>
 <CAFqH_51EGNzMx76WrjEr9Ss7QoU8FSHAhUf2OeencUC-XXtSWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFqH_51EGNzMx76WrjEr9Ss7QoU8FSHAhUf2OeencUC-XXtSWQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Jingoo Han <jingoohan1@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, linux-fbdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, kernel@collabora.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pwm@vger.kernel.org

FAO Thierry,

> oh, devicetree mailing list is not added, sorry, so cc'ing ...
> 
> 2018-02-19 12:11 GMT+01:00 Daniel Thompson <daniel.thompson@linaro.org>:
> > On Fri, Feb 16, 2018 at 06:40:31PM +0100, Enric Balletbo i Serra wrote:
> >> Hardware needs a delay between setting an initial (non-zero) PWM and
> >> enabling the backlight using GPIO. The post-pwm-on-delay-ms specifies
> >> this delay in milli seconds. Hardware also needs a delay between disabing
> >> the backlight using GPIO and setting PWM value to 0. The pwm-off-delay-ms
> >> is this delay in milli seconds.
> >>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> Acked-by: Pavel Machek <pavel@ucw.cz>
> >
> > Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> >
> 
> Lee, I guess that after Daniel ack the only ack missing here is one
> from Rob Herring?

I'd also like an ACK from the PWM Maintainer if possible.

> Rob, if you have a chance to look at this I'd appreciate.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

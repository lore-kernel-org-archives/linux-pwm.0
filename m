From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 03/16] pwm: cros-ec: update documentation regarding
 pwm-cells
Date: Wed, 17 Jan 2018 15:10:57 -0800
Message-ID: <20180117231056.GB112833@google.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-4-git-send-email-claudiu.beznea@microchip.com>
 <20180112183122.GA102880@google.com>
 <61b85600-7aee-e9d1-6587-17e5e419b03a@microchip.com>
 <c2078487-8cc6-429e-6c38-092d776c33aa@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c2078487-8cc6-429e-6c38-092d776c33aa-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Claudiu Beznea <Claudiu.Beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Jan 17, 2018 at 10:29:53AM +0200, Claudiu Beznea wrote:
> With these changes, if pwm-cells=1 then only PWM-channel will be parsed,

I'm not sure if I'm understanding you correctly but...no. If cells is 1,
then your driver change just causes us not to parse correctly, and
everything fails.

> if it is 2 PWM-channel and PWM-period will be parsed, if pwm-cells=3
> then PWM-channel, PWM-period and PWM-flags will be parsed.
> In your driver you used to have only one cell because you wanted to allow
> user to give as argument only PWM channel, and you did not want a change
> of PWM period (and in of_xlate function you initialize pwm period with 0xffff
> value: this is why I changed the binding in patch 7 of this series, file

It's not a matter of "allow", it's a matter of description. The period
isn't actually even 0xffff, that's just a pseudo-period, to reflect that
you have a choice of duty cycles of 0 to 0xffff. I (justifiably, I
think) didn't think putting this false value in the device tree was
accurate.

> rk3399-gru-kevin.dts). But e.g. sysfs could try to change the PWM period,
> there is no restriction to change the PWM period from sysfs, in the sysfs
> interface but the restriction is in PWM apply of the drive. The same things
> happens with these changes too. The user could introduce any PWM period via
> DT but the pwm apply function of the driver will return error.

sysfs has no bearing on a device tree binding. Just because we have a
broken interface here doesn't mean we should change how we describe the
hardware.

Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

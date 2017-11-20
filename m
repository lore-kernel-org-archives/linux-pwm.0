From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] pwm: imx: Allow keeping the PWM active during suspend
Date: Mon, 20 Nov 2017 15:19:32 -0600
Message-ID: <20171120211932.ro3ybgo6ih2542m2@rob-hp-laptop>
References: <1511015768-14140-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1511015768-14140-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Sat, Nov 18, 2017 at 12:36:08PM -0200, Fabio Estevam wrote:
> In some systems it is desirable to keep the PWM active during system
> suspend.
> 
> One use case is the imx6q-cubox-i board, which has an LED driven by PWM.
> When the system goes into suspend the PWM block is disabled by default,
> the PWM pin goes to zero and turn on the LED during suspend, which is
> not really the behaviour we want to see.

Seems to me the default behavior should be LEDs are off in suspend and 
you'd add a property to enable them if desired.

You problem to me sounds like something that should be fixed in the pwm 
and/or pwm-led drivers.

> 
> By keeping the PWM enabled during suspend the pwm-leds driver sets
> the brightness to zero in suspend and then the LED is turned off as
> expected.
> 
> Introduce the 'fsl,active-in-suspend' property to indicate that the
> PWM will stay active during suspend.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

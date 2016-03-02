From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM: dts: NSP: Add PWM Support to DT
Date: Wed, 02 Mar 2016 16:28:54 +0100
Message-ID: <4015342.1TJkp5X8uB@wuerfel>
References: <CAL2FKYkoXFm_pG6inxJqwkRqEK-TsMT2ndy4fgvQG1wT6AZ03Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL2FKYkoXFm_pG6inxJqwkRqEK-TsMT2ndy4fgvQG1wT6AZ03Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Mason <jonmason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Wednesday 02 March 2016 20:22:01 Yendapally Reddy Dhananjaya Reddy wrote:
> On Wed, Mar 2, 2016 at 1:55 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> > On Tuesday 01 March 2016 12:42:49 Yendapally Reddy Dhananjaya Reddy wrote:
> >>                 };
> >>
> >> +               pwm: pwm@31000 {
> >> +                       compatible = "brcm,iproc-pwm";
> >> +                       reg = <0x31000 0x28>;
> >> +                       clocks = <&osc>;
> >> +                       #pwm-cells = >;
> >> +                       status = "disabled";
> >> +               };
> >>
> >
> > Should this also list "brcm,kona-pwm" as compatible? From patch
> > 1, it sounds like that was the original one.
> 
> Arnd,
> 
> The NSP is a iProc based SoC and the pwm controller register offsets are
> slightly differ with the kona pwm controller. The compatible will be either
> "brcm,kona-pwm" or "brcm,iproc-pwm".

Ok, got it, thanks for the explanation.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

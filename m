From: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
Date: Tue, 17 Mar 2020 18:39:58 +0200
Message-ID: <CAGgjyvE9+fHDKiua=BWBaTRGaChsOvnUnG6RGA9Q4V4uPuPEhQ@mail.gmail.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-2-oleksandr.suvorov@toradex.com> <f281a6a0-a150-514d-ef02-4e51192031d7@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f281a6a0-a150-514d-ef02-4e51192031d7-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Claudiu.Beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Barker <pbarker-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Marcel Ziswiler <marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Igor Opaniuk <igor.opaniuk-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Philippe Schenker <philippe.schenker-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Ludovic.Desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Nicolas.Ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, palmer-96lFi9zoCfxBDgjK7y7TUQ@public.gmane.org, paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org, paul.walmsley-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org, Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.orgSascha Hauer <s.>
List-Id: linux-pwm@vger.kernel.org

On Tue, Mar 17, 2020 at 6:27 PM <Claudiu.Beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org> wrote:
>
>
>
> On 17.03.2020 14:32, Oleksandr Suvorov wrote:
> > @@ -187,7 +187,7 @@ static ssize_t polarity_store(struct device *child,
> >         if (sysfs_streq(buf, "normal"))
> >                 polarity = PWM_POLARITY_NORMAL;
> >         else if (sysfs_streq(buf, "inversed"))
>
> You may also consider this string     ^

Thanks for the feedback, Claudiu.

I thought about it and decided not to change the ABI, as this change
can impact lots of user-land applications.
As a minimum, I can push this change as a separate patch to be able to
revert the change of ABI only.
What do you think?

> > -               polarity = PWM_POLARITY_INVERSED;
> > +               polarity = PWM_POLARITY_INVERTED;



-- 
Best regards
Oleksandr Suvorov

Toradex AG
Ebenaustrasse 10 | 6048 Horw | Switzerland | T: +41 41 500 48 00

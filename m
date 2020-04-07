From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RFC PATCH v2 2/6] dt-bindings: pwm: document the PWM no-flag
Date: Tue, 7 Apr 2020 13:18:42 +0200
Message-ID: <20200407111842.hp7mhrlsuesa74ep@pengutronix.de>
References: <20200405192246.3741784-1-oleksandr.suvorov@toradex.com>
 <20200405192246.3741784-3-oleksandr.suvorov@toradex.com>
 <20200407061646.pcglaw43kfmrag6a@pengutronix.de>
 <CAGgjyvH5nmnXH068QTNPKzsjocNXfEP_yh0HO=L-oGaqQdYRuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGgjyvH5nmnXH068QTNPKzsjocNXfEP_yh0HO=L-oGaqQdYRuA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Barker <pbarker-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Marcel Ziswiler <marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Igor Opaniuk <igor.opaniuk-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Philippe Schenker <philippe.schenker-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Apr 07, 2020 at 01:51:42PM +0300, Oleksandr Suvorov wrote:
> On Tue, Apr 7, 2020 at 9:17 AM Uwe Kleine-König
> <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> >
> > On Sun, Apr 05, 2020 at 10:22:42PM +0300, Oleksandr Suvorov wrote:
> > > Add the description of PWM_NOFLAGS flag property.
> > >
> > > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
> >
> > As I already wrote in reply to the v1 series I'd prefer a name for 0
> > that explicitly handles normal polarity.
> 
> Uwe, AFAIU, there is no flag that forces normal polarity, the normal polarity
> is the default state if there is no flag to invert the polarity is set.

Yes, that's the status quo.

> '0' value in the bit flags cell really means there are no flags set
> for the PWM instance.

For me the relevance of giving 0 a name is mostly for human consumption.
Currently there is only a single flag encoded in the number in question.
But as soon as we add another, say PWM_AUTOSTART we have the following
possible settings:

	PWM_NOFLAGS
	PWM_POLARITY_INVERTED
	PWM_AUTOSTART
	PWM_POLARITY_INVERTED | PWM_AUTOSTART

Then for the first two a reader doesn't see if autostart is not in use
because the dt author doesn't know this feature (e.g. because autostart
is too new) or if they don't want autostart at all.

If however we had PWM_POLARITY_NORMAL and PWM_NO_AUTOSTART to complement
PWM_POLARITY_INVERTED and PWM_AUTOSTART every flag's setting could be
explicit and if there is a device tree that only has

	PWM_POLARITY_NORMAL

it would be obvious that nobody thought enough about autostarting to
explicitly mention it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

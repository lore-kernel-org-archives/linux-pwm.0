From: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 4/7] dt-bindings: pwm: add description of PWM polarity
Date: Wed, 18 Mar 2020 14:36:10 +0200
Message-ID: <CAGgjyvG=eqTUP0c3rnRq7vm7wZk-95oEtVEhV9GCBohC6sBcRg@mail.gmail.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-5-oleksandr.suvorov@toradex.com> <20200317230115.GM2527@pendragon.ideasonboard.com>
 <CAGgjyvEneCwFM8_tnKfNprqw2qkL_94rpsGF=ZgW-m75JBvegw@mail.gmail.com> <20200318122942.GA7833@pendragon.ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200318122942.GA7833-N3hz7ZxfLydczECFQUw77jytWr6r+dGw0E9HWUfgJXw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Barker <pbarker-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Marcel Ziswiler <marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Igor Opaniuk <igor.opaniuk-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Philippe Schenker <philippe.schenker-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Mar 18, 2020 at 2:30 PM Laurent Pinchart
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
>
> Hi Oleksandr,
>
> On Wed, Mar 18, 2020 at 01:37:00PM +0200, Oleksandr Suvorov wrote:
> > On Wed, Mar 18, 2020 at 1:02 AM Laurent Pinchart wrote:
> > > On Tue, Mar 17, 2020 at 02:32:28PM +0200, Oleksandr Suvorov wrote:
> > > > Move the description of the PWM signal polarity from
> > > > <linux/pwm.h>, prepare for removing the polarity
> > > > definition from <linux/pwm.h>.
> > > >
> > > > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
> > > > ---
> > > >
> > > >  include/dt-bindings/pwm/pwm.h | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
> > > > index 6b58caa6385e..c07da2088a61 100644
> > > > --- a/include/dt-bindings/pwm/pwm.h
> > > > +++ b/include/dt-bindings/pwm/pwm.h
> > > > @@ -10,7 +10,16 @@
> > > >  #ifndef _DT_BINDINGS_PWM_PWM_H
> > > >  #define _DT_BINDINGS_PWM_PWM_H
> > > >
> > > > +/**
> > > > + * a high signal for the duration of the duty-cycle, followed by a low signal
> > > > + * for the remainder of the pulse period.
> > > > + */
> > >
> > > Last time I checked, kernedoc didn't support documenting macros (enums
> > > are supported).
> >
> > That's why I dropped the kerneldoc tags leaving the descriptions only.
>
> But you forgot to replace /** with /* :-) Sorry for not being clear
> about what I meant.

Ah, yes, thanks! I'll fix it in the next version :)

>
> > > >  #define PWM_POLARITY_NORMAL                  0
> > > > +
> > > > +/**
> > > > + * a low signal for the duration of the duty-cycle, followed by a high signal
> > > > + * for the remainder of the pulse period.
> > > > + */
> > > >  #define PWM_POLARITY_INVERTED                        (1 << 0)
> > > >
> > > >  #endif
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Best regards
Oleksandr Suvorov

Toradex AG
Ebenaustrasse 10 | 6048 Horw | Switzerland | T: +41 41 500 48 00

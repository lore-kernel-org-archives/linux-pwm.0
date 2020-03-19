From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RFC PATCH 2/7] dt-bindings: pwm: document the PWM polarity flag
Date: Thu, 19 Mar 2020 08:05:10 +0100
Message-ID: <20200319070510.gc6hr53gn7n2osvb@pengutronix.de>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-3-oleksandr.suvorov@toradex.com>
 <20200317174344.GB1464607@ulmo>
 <20200317213056.futfiwn4qgr2njye@pengutronix.de>
 <20200318230539.GB2874972@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200318230539.GB2874972@ulmo>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Barker <pbarker-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Marcel Ziswiler <marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Igor Opaniuk <igor.opaniuk-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Philippe Schenker <philippe.schenker-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Thu, Mar 19, 2020 at 12:05:39AM +0100, Thierry Reding wrote:
> On Tue, Mar 17, 2020 at 10:30:56PM +0100, Uwe Kleine-König wrote:
> > Hello Thierry,
> > 
> > On Tue, Mar 17, 2020 at 06:43:44PM +0100, Thierry Reding wrote:
> > > On Tue, Mar 17, 2020 at 02:32:26PM +0200, Oleksandr Suvorov wrote:
> > > > Add the description of PWM_POLARITY_NORMAL flag.
> > > > 
> > > > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
> > > > ---
> > > > 
> > > >  Documentation/devicetree/bindings/pwm/pwm.txt | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
> > > > index 084886bd721e..440c6b9a6a4e 100644
> > > > --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> > > > +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> > > > @@ -46,6 +46,7 @@ period in nanoseconds.
> > > >  Optionally, the pwm-specifier can encode a number of flags (defined in
> > > >  <dt-bindings/pwm/pwm.h>) in a third cell:
> > > >  - PWM_POLARITY_INVERTED: invert the PWM signal polarity
> > > > +- PWM_POLARITY_NORMAL: don't invert the PWM signal polarity
> > > 
> > > This doesn't make sense. PWM_POLARITY_NORMAL is not part of the DT ABI.
> > 
> > "is not part of the DT ABI" is hardly a good reason. If it's sensible to
> > be used, it is sensible to define it.
> 
> That's exactly it. It's not sensible at all to use it.

If you think the argument is "It is not sensible to be used." then please
say so and don't add "PWM_POLARITY_NORMAL is not part of the DT ABI."
which seems to be irrelevant now.

> If you define it here it means people are allowed to do stuff like
> this:
> 
> 	pwms = <&pwm 1234 PWM_POLARITY_INVERTED | PWM_POLARITY_NORMAL>;
> 
> which doesn't make sense.

I would hope that a human reader would catch this.

> What's more, it impossible for the code to even notice that you're
> being silly because | PWM_POLARITY_NORMAL is just | 0 and that's just
> a nop.

I think this argument is a bad one. Whenever you introduce a
function or symbol you can use it in a wrong way. With this argument you
can also say GPIO_ACTIVE_LOW doesn't make sense because

	pwms = <&pwm 1234 GPIO_ACTIVE_LOW>;

is silly.

Keep well and fit,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

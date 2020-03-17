From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RFC PATCH 2/7] dt-bindings: pwm: document the PWM polarity flag
Date: Tue, 17 Mar 2020 22:30:56 +0100
Message-ID: <20200317213056.futfiwn4qgr2njye@pengutronix.de>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-3-oleksandr.suvorov@toradex.com>
 <20200317174344.GB1464607@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200317174344.GB1464607@ulmo>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Barker <pbarker-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Marcel Ziswiler <marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Igor Opaniuk <igor.opaniuk-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Philippe Schenker <philippe.schenker-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hello Thierry,

On Tue, Mar 17, 2020 at 06:43:44PM +0100, Thierry Reding wrote:
> On Tue, Mar 17, 2020 at 02:32:26PM +0200, Oleksandr Suvorov wrote:
> > Add the description of PWM_POLARITY_NORMAL flag.
> > 
> > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
> > ---
> > 
> >  Documentation/devicetree/bindings/pwm/pwm.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
> > index 084886bd721e..440c6b9a6a4e 100644
> > --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> > +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> > @@ -46,6 +46,7 @@ period in nanoseconds.
> >  Optionally, the pwm-specifier can encode a number of flags (defined in
> >  <dt-bindings/pwm/pwm.h>) in a third cell:
> >  - PWM_POLARITY_INVERTED: invert the PWM signal polarity
> > +- PWM_POLARITY_NORMAL: don't invert the PWM signal polarity
> 
> This doesn't make sense. PWM_POLARITY_NORMAL is not part of the DT ABI.

"is not part of the DT ABI" is hardly a good reason. If it's sensible to
be used, it is sensible to define it.

(And as far as I understand it, the term PWM_POLARITY_INVERTED isn't
part of the DT ABI either. Only the value 1 has a meaning (for some PWM
controlers).)

> The third cell of the specifier is a bitmask of flags.
> 
> PWM_POLARITY_NORMAL is an enumeration value that evaluates to 0, so it
> makes absolutely no sense as a flag.

Using 0 or PWM_POLARITY_NORMAL doesn't have an effect on the compiled
device tree, that's true. But having the term PWM_POLARITY_NORMAL (in
contrast to a plain 0) in a dts file is useful in my eyes for human
readers.

> PWM signals are considered to be "normal" by default, so no flag is
> necessary to specify that.

GPIOs are considered to be active high by default, still there is
GPIO_ACTIVE_HIGH (which also evaluates to 0). Also there is
IRQ_TYPE_NONE.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
Date: Thu, 19 Mar 2020 18:30:45 +0100
Message-ID: <20200319173045.ystpijvwtyvil2vq@pengutronix.de>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
 <20200317174043.GA1464607@ulmo>
 <20200317210042.ryrof3amr7fxp4w5@pengutronix.de>
 <20200318225953.GA2874972@ulmo>
 <20200319065039.szhh5dm6v3ejwijd@pengutronix.de>
 <20200319163700.GA3354541@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200319163700.GA3354541@ulmo>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Barker <pbarker-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Marcel Ziswiler <marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Igor Opaniuk <igor.opaniuk-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Philippe Schenker <philippe.schenker-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Nicolas Ferre <nicolas.f>
List-Id: linux-pwm@vger.kernel.org

Hello,

On Thu, Mar 19, 2020 at 05:37:00PM +0100, Thierry Reding wrote:
> On Thu, Mar 19, 2020 at 07:50:39AM +0100, Uwe Kleine-König wrote:
> > On Wed, Mar 18, 2020 at 11:59:53PM +0100, Thierry Reding wrote:
> > > On Tue, Mar 17, 2020 at 10:00:42PM +0100, Uwe Kleine-König wrote:
> > > > Having said this I think (independent of the question if "inversed"
> > > > exists) using two similar terms for the same thing just results in
> > > > confusion. I hit that in the past already and I like it being addressed.
> > > 
> > > I don't know. It's pretty common to use different words for the same
> > > thing. They're called synonyms.
> > 
> > In literature yes, I agree. In a novel it is annoying to repeat the same
> > words over and over again and some variation is good. In programming
> > however the goal is a different one. There the goal should be to be
> > precise and consistent.
> 
> We also need to make sure that things don't break.

And I'm entirely on your side here.

> It's a very bad idea to have a macro with the same name as an enum
> value for reasons I stated before. I think that's the most important
> thing here.

You might have missed it, but that's OK for me, too. And note that after
applying the whole series the enum is gone and so the problem. (First
hunk of include/linux/pwm.h in patch 5.)

> Also, if inversed is a synonym of inverted, we don't loose any precision
> at all.

grep doesn't know about synonyms, so if I grep for stuff about inverted
PWMs in the kernel I completely miss one half as it's called inversed
there. (Yeah sure, I can also grep for "inversed|inverted", but therefor
I have to know first that both are used interchangable here.)

That's a bit like a schematic that has "RESET#" in one place and
"nRESET" in an other. If you stumble about that you wonder if they are
two different names for the same signal or if they are actually two
different ones.

Have you ever read a specification that described some property, gave it
a name and then later used a synonym to describe it? In my eyes that's a
bad idea.

> All you have to remember is that you're dealing with a device
> tree constant in one case and an API enumeration in the other.

Everything you need to remember (or learn) about a subsystem makes it
harder work with it.
 
> So I think the current form is actually more precise, though I guess it
> could be confusing if you don't care about the difference.

If there is a technical need to have different names that's one thing.
But using synonyms to differentiate them is not optimal. Then please
let's have names where looking at the identifier makes it obvious which
is for the device trees and which for the API enum.

> > > > > And as you noted in the cover letter, there's a conflict between the
> > > > > macro defined in dt-bindings/pwm/pwm.txt. If they end up being included
> > > > > in the wrong order you'll get a compile error.
> > > > 
> > > > There are also other symbols that exist twice (GPIO_ACTIVE_HIGH was the
> > > > first to come to my mind). I'm not aware of any problems related to
> > > > these. What am I missing?
> > > 
> > > There's currently no problem, obviously. But if for some reason the
> > > include files end up being included in a different order (i.e. the
> > > dt-bindings header is included before linux/pwm.h) then the macro will
> > > be evaluated and result in something like:
> > > 
> > > 	enum pwm_polarity {
> > > 		PWM_POLARITY_NORMAL,
> > > 		1,
> > > 	};
> > > 
> > > and that's not valid C, so will cause a build error.
> > 
> > I admit I didn't look closely here and I assume you are right. If I
> > understand Oleksandr right this is only an intermediate step and when
> > the series is applied completely this issue is gone. Still it might be
> > worth to improve the series here.
> 
> 	$ gcc -o /dev/null -x c - <<- EOF
> 	>     #define PWM_POLARITY_INVERTED (1 << 0)
> 	>
> 	>     enum pwm_polarity {
> 	>         PWM_POLARITY_NORMAL,
> 	>         PWM_POLARITY_INVERTED,
> 	>     };
> 	> EOF
> 	<stdin>:1:35: error: expected identifier before ‘(’ token
> 	<stdin>:5:9: note: in expansion of macro ‘PWM_POLARITY_INVERTED’
> 
> Q.E.D.

I don't understand why you proved something here. I didn't doubt this.

> > My original question was about similar problems with GPIO_ACTIVE_HIGH.
> > Are you aware of problems there?
> 
> The problem exists there equally. We're probably not running into it
> because drivers don't end up including dt-bindings/gpio/gpio.h and
> include/linux/gpio/machine.h at the same time. Or they end up always
> including them in the right order.

Oh, that's worse than I expected. There are two .c files that include
dt-bindings/gpio/gpio.h:

	drivers/rtc/rtc-omap.c
	drivers/tty/serial/omap-serial.c

So the definition isn't even used in the gpio core to parse dt-stuff.
(And both files don't use any definition of that file :-|)

> For PWM the situation is slightly more complicated because we only have
> one header for the kernel API, so the likelihood of including it along
> with the dt-bindings header is increased compared to GPIO.

If a consumer or provider includes the dt-bindings file there is
something fishy. (Still catching this with a compiler message better
than "expected identifier before ‘(’ token" would be good.)
 
> > > > > Note that DT bindings are an ABI and can
> > > > > never change, whereas the enum pwm_polarity is part of a Linux internal
> > > > > API and doesn't have the same restrictions as an ABI.
> > > > 
> > > > I thought only binary device trees (dtb) are supposed to be ABI.
> > > 
> > > Yes, the DTB is the ABI. dt-bindings/pwm/pwm.h is used to generate DTBs,
> > > which basically makes it ABI as well.
> > 
> > We disagree here. With this argument you could fix quite some things as
> > ABI.
> 
> I don't understand what you're trying to say.

I don't want to follow your argument that dt-bindings/pwm/pwm.h is ABI
as well. device tree binaries follow an ABI (similar to machine code),
but the compiler and the source code (including headers) are not.

> > > Yes, the symbol name may not be part of the ABI, but changing the
> > > symbol becomes very inconvenient because everyone that depends on it
> > > would have to change.
> > 
> > Oleksandr adapted all in-tree users, so it only affects out-of-tree
> > users. In my book this is fine.
> 
> There used to be a time when it was assumed that eventually device tree
> sources would live outside of the kernel tree. Given that they are a HW
> description, they really ought not to be relying on the Linux kernel
> tree as a way of keeping them consistent. That's really only out of
> convenience.

The other way round however is fine, isn't it? So use the dt definition
in the kernel should be ok.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

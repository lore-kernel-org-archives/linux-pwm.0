From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Date: Tue, 23 Feb 2016 15:57:32 +0100
Message-ID: <20160223145732.GB27656@ulmo>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
 <2341981.a79ioYM9Es@diego>
 <20151110173416.GB21727@ulmo>
 <CAD=FV=WL3jYEgVe-m6QcAyQwfJgdX4J5OtKisKwyoKOrTSpEQA@mail.gmail.com>
 <20160125170855.GA10182@ulmo>
 <CAD=FV=Xvxeqo3imUmjukC5iYk3EZkrJ04G7C1B-w4xyr-r6-2Q@mail.gmail.com>
 <20160203145337.GD9650@ulmo>
 <CAD=FV=U_x1cxx6RrHuVgVV8GbOwm9DXXJcyiArbbQySUOaxrvQ@mail.gmail.com>
 <20160204110203.GL4455@sirena.org.uk>
 <20160204150150.553d36df@bbrezillon>
Reply-To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Return-path: <linux-sunxi+bncBDTKFPPJUEHRBXXGWG3AKGQEKKPKCAQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160204150150.553d36df@bbrezillon>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-pwm <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Feb 04, 2016 at 03:01:50PM +0100, Boris Brezillon wrote:
> Hi Mark, Thierry,
> 
> On Thu, 4 Feb 2016 11:02:03 +0000
> Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
> > On Wed, Feb 03, 2016 at 11:04:20AM -0800, Doug Anderson wrote:
> > 
> > > Sure.  ...but you agree that somehow you need a new API call for this,
> > > right?  Somehow the PWM regulator needs to be able to say that it
> > > wants the hardware state, not the initial state as specified in the
> > > device tree.
> > 
> > Wouldn't the most direct way to do that be to just not specify anything
> > in the DT?  If there *is* something in DT but we ignore it that's a bit
> > weird.
> 
> Just adding some inputs on this specific aspect. The reason we have to
> specify a period (and, to a lesser extent, the polarity) in the DT or
> PWM lookup table is because what most PWM users want is to specify a
> dutycycle relatively to a predefined period value.

That's not quite correct. The reason why we need the information in DT
is because it can't be derived from anything else. It is board-specific
data for which there's no heuristic that will work in all cases.

> If we decide to remove those information from the DT, then you'll need
> a way to define it somewhere else, and then the is question is 'where?'.
> 
> Users that really want to control their period (this could the case for
> the clk-pwm driver) could completely ignore DT/lookup-table information
> and set the period and absolute dutycycle directly.

Yes, I think clk-pwm is very special in this regard because the period
can be derived from the requested clock rate. It would be complicated to
implement DT parsing that ignores parts of the specifier in some cases
but not in others. Simply having the clk-pwm driver ignore whatever is
in the table (or perhaps bail out on periods other than 0 for example).

> Now, from what I seen, what most PWM users want to do is:
> 
> 	pwm_set_rel_duty_scale(pwm, rel_value, scale);
> or 
> 	rel_duty = pwm_get_rel_duty_cycle(pwm, scale);
> 
> where scale depends on the precision you need for your use case (most
> of the time it's expressed in percent).
> 
> So, how about providing this kind of API (this is what I proposed in
> one of my previous email)?
> 
> This would not only solve our problem (say you have a period at
> boot-time that differs from the one you'll set when first applying a
> new relative duty cycle, then the resulting relative value would still
> be correct), but it would also remove a lot of boiler plate code from
> PWM users code (if you take a look at pwm-regulator, pwm-leds, pwm-fan
> and probably others, you'll see that they are all doing this conversion
> manually).

I don't think this gains us much. The above would work for pwm-regulator
and pwm-fan, in both cases it'd replace a single line with two lines and
fitting the expressions into function arguments is likely going to be
hideous. For leds-pwm this wouldn't work, because of the low-active case
that it supports.

> Now, the last blocking point is, what if the PWM driver does not
> implement HW-readout. In this case, the pwm-regulator will probably
> expose a 0V output (IIRC, dutycycle is set to 0 by default) when it's
> actually providing something else. But is this really important? I
> mean, if the user really wants to have a reliable information, then he
> will implement initial-state retrieval in its PWM controller driver.
> Alternatively, we could put a flag specifying whether the PWM chip
> supports initial state retrieval.

I reached the same conclusion in another subthread. If hardware readout
isn't supported, I think the most natural thing to do is simply use the
initial state (i.e. what's defined in DT or board files) instead. There
is an argument, I think, to be made for having users apply the initial
state at probe time to forcibly apply the logical state to hardware and
subsequently not care about the initial state anymore. For most cases
that might not even be necessary, though.

Thierry
--pvezYHf7grwyp3Bc--

From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4 3/7] pwm: sun4i: Add an optional probe for bus clock
Date: Fri, 15 Nov 2019 08:25:28 +0100
Message-ID: <20191115072528.7p5ks7xhifjiso2p@pengutronix.de>
References: <20191108084517.21617-1-peron.clem@gmail.com>
 <20191108084517.21617-4-peron.clem@gmail.com>
 <20191113083524.aqtf2ed4ltuiazjg@pengutronix.de>
 <CAJiuCccqyPbxRLjv1NRy6eukMnma8OUJGKvVHHDSKwybNJgKrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJiuCccqyPbxRLjv1NRy6eukMnma8OUJGKvVHHDSKwybNJgKrg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>, Jernej Skrabec <jernej.skrabec@siol.net>
List-Id: linux-pwm@vger.kernel.org

Hello Clément,

On Thu, Nov 14, 2019 at 11:36:16PM +0100, Clément Péron wrote:
> On Wed, 13 Nov 2019 at 09:35, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Fri, Nov 08, 2019 at 09:45:13AM +0100, Clément Péron wrote:
> > > +     /*
> > > +      * Fallback for old dtbs with a single clock and no name.
> > > +      * If a parent has a clock-name called "mod" whereas the
> > > +      * current node is unnamed the clock reference will be
> > > +      * incorrectly obtained and will not go into this fallback.
> >
> > For me "old dtbs" suggests that today a device tree should have a "mod"
> > clock. Is this true also for machines other than H6? And I'd put the
> > comment before the acquisition of the "mod" clock. Something like:
> 
> Agree to remove the "old dtbs" but specifying the SoC instead
> of the reason is less clear for me.
> 
> I would prefer to have something like this:
> 
> A clock is explicitly called "mod" when several clocks are referenced.
> However, when only one clock is declared this one is unamed.
> So we request "mod" first (and ignore the corner case that a parent
> provides a "mod" clock)
> and if this is not found we fall back to the first clock of the PWM.

It gets better. What about also describing shortly the purpose of this
clock (assuming this is the source clock of the PWM that is then
divided):

	All hardware variants need a source clock that is divided and
	then feeds the counter that defines the output wave form. In the
	device tree this clock is either unnamed or called "mod".
	Some variants (e.g. H6) need another clock to access the
	hardware registers; this is called "bus".

	So we request "mod" first (and ignore the corner case that a
	parent provides a "mod" clock while the right one would be the
	unnamed one of the PWM device) and if this is not found we fall
	back to the first clock of the PWM.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

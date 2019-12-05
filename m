From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [GIT PULL] pwm: Changes for v5.5-rc1
Date: Thu, 5 Dec 2019 11:05:35 +0100
Message-ID: <20191205100535.y7avzoswkxe43py7@pengutronix.de>
References: <20191205061044.1006766-1-thierry.reding@gmail.com>
 <20191205075958.jrz3xuthyh7wv6uu@pengutronix.de>
 <20191205084102.GA1401169@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191205084102.GA1401169@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hello Thierry,

On Thu, Dec 05, 2019 at 09:41:02AM +0100, Thierry Reding wrote:
> On Thu, Dec 05, 2019 at 08:59:58AM +0100, Uwe Kleine-König wrote:
> > On Thu, Dec 05, 2019 at 07:10:44AM +0100, Thierry Reding wrote:
> > > The following changes since commit 40a6b9a00930fd6b59aa2eb6135abc2efe5440c3:
> > > 
> > >   Revert "pwm: Let pwm_get_state() return the last implemented state" (2019-10-21 16:48:52 +0200)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.5-rc1
> > > 
> > > for you to fetch changes up to f5ff2628867b9c7cb4abb6c6a5a7eea079dad4b6:
> > > 
> > >   pwm: imx27: Unconditionally write state to hardware (2019-10-21 16:58:09 +0200)
> > > 
> > > Thanks,
> > > Thierry
> > > 
> > > ----------------------------------------------------------------
> > > pwm: Changes for v5.5-rc1
> > > 
> > > Various changes and minor fixes across a couple of drivers.
> > > 
> > > ----------------------------------------------------------------
> > > Colin Ian King (1):
> > >       pwm: sun4i: Drop redundant assignment to variable pval
> > > 
> > > Fabrice Gasnier (3):
> > >       dt-bindings: pwm-stm32: Document pinctrl sleep state
> > >       pwm: stm32: Split breakinput apply routine to ease PM support
> > >       pwm: stm32: Add power management support
> > > 
> > > Ondrej Jirman (1):
> > >       pwm: sun4i: Fix incorrect calculation of duty_cycle/period
> > > 
> > > Rasmus Villemoes (1):
> > >       pwm: Update comment on struct pwm_ops::apply
> > > 
> > > Thierry Reding (8):
> > >       dt-bindings: pwm: mediatek: Remove gratuitous compatible string for MT7629
> > >       pwm: stm32: Validate breakinput data from DT
> > >       pwm: stm32: Remove clutter from ternary operator
> > >       pwm: stm32: Pass breakinput instead of its values
> > >       pwm: Read initial hardware state at request time
> > >       pwm: cros-ec: Cache duty cycle value
> > >       pwm: imx27: Cache duty cycle register value
> > >       pwm: imx27: Unconditionally write state to hardware
> > 
> > It's a bit of a surprise for me that you included the three last patches
> > as last minute changes. I'm not sure if I oppose them, but they were not
> > in next (as of next-20191205) and I would really like to have some time
> > for patches (that are not obvious fixes of course) there before they go
> > into a pull request. And if it's only to get some transparency.
> > (But in this case I had the impression that the discussion isn't over
> > yet, your last mail in the thread said: "I'm not sure yet about the
> > remainder of the series. Depending on what we decide to do about drivers
> > that can't (or don't want to) write all state through to the hardware,
> > patches 2-4 may become moot." in October which made me expect there is
> > still something to come, at least a statement before the fact. Still
> > more as also several further drivers are affected (according to my
> > research described in
> > https://patchwork.ozlabs.org/patch/1178351/#2282269).)
> 
> Yes, the last four patches weren't meant to be in this pull request.
> That's what I get for trying to squeeze this in before coffee.

Ah right, it's four patches, not three. (I thought I saw "pwm: Read
initial hardware state at request time" in next.)

> Please do ping me if I haven't reviewed or applied patches after a
> week or so to remind me. Sometimes my inbox fills up so quickly that
> some patches get lost.

ok.

> >  - The patch "pwm: implement tracing for .get_state() and
> >    .apply_state()" that got an review by Steven Rostedt.
> >    (https://patchwork.ozlabs.org/patch/1182679/)
> 
> Review for this came in after v5.4-rc7, so I didn't consider it for
> v5.5. I'll pick it up after v5.5-rc1.

I got Steven's mail on Oct 24 which is the week between -rc4 and -rc5,
but ok, I won't argue.
> 
> >  - The series starting with "pwm: omap-dmtimer: remove pwmchip in
> >    .remove before making it unfunctional" from November which IMHO is
> >    simple and contains two fixes
> >    (https://patchwork.ozlabs.org/project/linux-pwm/list/?series=142030)
> 
> Same here.

Does "after v5.5-rc1" mean "for v5.5" or "for v5.6-rc1". I agree that
the tracing stuff is merge window material (very useful though in my
eyes) while the omap-dmtimer series (at least the first 3 of 4 patches)
is about fixes.

> > And I'm still waiting for feedback on
> > 
> >  - "Documentation: pwm: rework documentation for the framework" (since
> >    January)
> 
> Please resend this, I can't find it in my inbox.

:-|, given that I sent this already twice, pinged several times
(https://patchwork.ozlabs.org/patch/1021566/,
https://patchwork.ozlabs.org/patch/1000709/) and also asked at least
once before in a mail where I pinged several patches using a list.

> >  - "pwm: add debug knob to help driver authors" (since August)
> 
> My recollection is that this flagged a bunch of issues right out of the
> box, so I'm hesitant to apply it without wider concensus that we want
> this, or some effort to address the issues that this flags.

I didn't want you to apply it. That it is not ready for that is out of
the question. I assume the patch doesn't apply anymore and needs work
for sure. The last mail in the respective thread had a single paragraph:

	do you consider the idea here worthwile? If so I'd update the
	patch to current mainline and address the feedback I got so far.

This is still interesting, as I don't want to spend my time working on
an idea that is then turned down in the end for conceptual reasons.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

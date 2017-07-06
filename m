From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: PWM backlight initial state assumptions, or how pwm_bl killed
 my (nyan) cat^W backlight support
Date: Thu, 06 Jul 2017 15:41:02 +0300
Message-ID: <1499344862.1379.19.camel@paulk.fr>
References: <1499199214.1347.8.camel@paulk.fr>
         <dea10517-11f7-0cca-fa2d-f7bc18501384@linaro.org>
         <1499251289.1394.3.camel@paulk.fr>
         <1499252873.8204.18.camel@pengutronix.de>
         <1499255225.1394.6.camel@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from gagarine.paulk.fr ([109.190.93.129]:49816 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbdGFMle (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Jul 2017 08:41:34 -0400
In-Reply-To: <1499255225.1394.6.camel@paulk.fr>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>

On Wed, 2017-07-05 at 14:47 +0300, Paul Kocialkowski wrote:
> Hi,
> 
> On Wed, 2017-07-05 at 13:07 +0200, Philipp Zabel wrote:
> > Hi Paul,
> > 
> > On Wed, 2017-07-05 at 13:41 +0300, Paul Kocialkowski wrote:
> > > Hey,
> > > 
> > > On Wed, 2017-07-05 at 11:24 +0100, Daniel Thompson wrote:
> > > > On 04/07/17 21:13, Paul Kocialkowski wrote:
> > > > > As I try to maintain support for ARM CrOS (read, ChromeOS/ChromiumOS)
> > > > > devices in
> > > > > upstream Linux on my spare time, I try to test out rc and stable
> > > > > versions as
> > > > > often as time allows. I have been rolling out 4.12 since Monday and
> > > > > noticed
> > > > > that
> > > > > the backlight on my tegra124 nyan big stayed dark for this release.
> > > > > 
> > > > > Not very cool, although I'm not blaming anyone else than myself on
> > > > > this,
> > > > > I should have just tested it and brought the issue up during the rc
> > > > > cycle.
> > > > > Still, let's try to move forward.
> > > > 
> > > > Personally I might be inclined to spread the blame a bit wider ;-).
> > > > 
> > > > Did you bisect it down to a specific patch? An SHA-1 would be something 
> > > > of a time saver here!
> > > 
> > > The offending commit here is d1b81294575098d989be1f2f6bb628091ceaa87b,
> > > that
> > > added a check on the intial PWM state.
> > > 
> > > The policy I'm describing was introduced with
> > > 3698d7e7d221a5c90d4b55e96d0c8f98a8b4d7df which did not break my use case
> > > at
> > > this
> > > point. It will still disable the driver if the regulator was not enabled
> > > already, which I think is not desirable. The policy on the initial GPIO
> > > state is
> > > also quite disputable.
> > 
> > Some panels have a documented powerup sequence, which usually ends with
> > the backlight being enabled to avoid showing garbage before the panel is
> > initialized completely.
> > The reason for 3698d7e7d221 was a device with the display disabled out
> > of the bootloader, where the backlight is controlled by the simple-panel
> > driver. Enabling the backlight from the backlight driver before the
> > panel driver requests the backlight to be enabled (before the panel is
> > powered) would result in a white flash during boot.
> > 
> > I tried to be careful to only let the backlight driver set the initial
> > state to disabled if a few conditions are met: the GPIO is already
> > configured as output and disabled, and the backlight device tree node
> > has a phandle pointing to it, so we can expect there to be some
> > controlling instance that will enable it when appropriate.
> > 
> > I wonder why in your case there is a phandle link to the backlight node
> > but nothing actually enables the backlight during boot. I would expect
> > that to be handled by the panel driver.
> 
> I had completely missed the fact that the panel driver is supposed to request
> backlight enable! With that in mind, this policy no longer concerns "the whole
> lifetime of the driver" but only the timeframe between backlight probe and
> panel
> probe. Thanks for clarifying this. I suppose I agree with this policy now.
> 
> So remains the question: why does the panel not enable backlight on my device?
> 
> I will investigate this later today. Hopefully, the probe defer logic should
> prevent a case where the panel is probed (to the end) before the backlight
> driver.

This is actually due to the tegra drm driver not probing. It is happening on my
setup (with a somewhat custom, out-of-tree config) on both jetson-tk1 and
nyan_big, but also on kernelci, running both tegra_defconfig and
multi_v7_defconfig.

Since this is no longer a concern related to the pwm backlight driver, I will
start a new thread with the relevant addresses in CC.

> > > > > After investigating, it appears that the pwm_bl driver is enforcing a
> > > > > policy
> > > > > on
> > > > > heavily relying on the backlight initial state
> > > > > (pwm_backlight_initial_power_state). To make it short, if backlight
> > > > > wasn't
> > > > > detected as already enabled by the bootloader, it's going to refuse to
> > > > > enable it
> > > > > during the whole lifetime of the driver.
> > > > > 
> > > > > This policy isn't exactly new (so I do realize that I'm a bit late to
> > > > > the
> > > > > party), but it went one step further this cycle by adding a check on
> > > > > the
> > > > > PWM
> > > > > state. This broke support for my nyan big, as the pwm driver does not
> > > > > check
> > > > > for
> > > > > the previous state at probe time and reports it as disabled initially.
> > > > > 
> > > > > One could say that the driver has to be fixed to report that state
> > > > > (and
> > > > > I
> > > > > agree
> > > > > it is a desirable thing to do), but I think it is a symptom of a
> > > > > broader
> > > > > issue.
> > > > > 
> > > > > Basically, do we really want pwm_bl to behave this way? What is the
> > > > > rationale
> > > > > behind this decision, other than "because we can"? A strong argument
> > > > > against
> > > > > it
> > > > > is that not all bootloaders have support for turning the backlight on
> > > > > (that
> > > > > is
> > > > > definitely not the case on the omap3 sniper and omap4 kc1 boards with
> > > > > upstream
> > > > > U-Boot, that I introduced to mainline Linux).
> > > > > 
> > > > > Also, we can still expect the gpio/regulator/pwm drivers to be reset
> > > > > at
> > > > > probe
> > > > > time (and I also agree it's not necessarily a good thing, especially
> > > > > as
> > > > > far
> > > > > as
> > > > > backlight is concerned, but that's the reality and dropping backlight
> > > > > support in
> > > > > those cases doesn't seem like an appropriate course of action). This
> > > > > will
> > > > > result
> > > > > in pwm_bl assuming that backlight was not enabled by the bootloader
> > > > > and
> > > > > thus
> > > > > refuse to enable it at all times.
> > > > > 
> > > > > Comments and reactions are welcome, as I'd really like to find a sane
> > > > > way to
> > > > > resolve this problem.
> > > > > 
> > > > > Cheers!
> > 
> > regards
> > Philipp
> > 
-- 
Paul Kocialkowski, developer of free digital technology and hardware support

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

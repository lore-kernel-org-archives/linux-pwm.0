From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: PWM backlight initial state assumptions, or how pwm_bl killed
 my (nyan) cat^W backlight support
Date: Thu, 06 Jul 2017 16:02:18 +0300
Message-ID: <1499346138.1379.21.camel@paulk.fr>
References: <1499199214.1347.8.camel@paulk.fr>
         <dea10517-11f7-0cca-fa2d-f7bc18501384@linaro.org>
         <1499251289.1394.3.camel@paulk.fr>
         <1499252873.8204.18.camel@pengutronix.de>
         <1499255225.1394.6.camel@paulk.fr> <1499344862.1379.19.camel@paulk.fr>
         <eb6b0abc-28a7-b7e2-0c25-8c7817a3321e@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <eb6b0abc-28a7-b7e2-0c25-8c7817a3321e@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Thu, 2017-07-06 at 13:57 +0100, Daniel Thompson wrote:
> On 06/07/17 13:41, Paul Kocialkowski wrote:
> > > > Some panels have a documented powerup sequence, which usually
> > > > ends with
> > > > the backlight being enabled to avoid showing garbage before the
> > > > panel is
> > > > initialized completely.
> > > > The reason for 3698d7e7d221 was a device with the display
> > > > disabled out
> > > > of the bootloader, where the backlight is controlled by the
> > > > simple-panel
> > > > driver. Enabling the backlight from the backlight driver before
> > > > the
> > > > panel driver requests the backlight to be enabled (before the
> > > > panel is
> > > > powered) would result in a white flash during boot.
> > > > 
> > > > I tried to be careful to only let the backlight driver set the
> > > > initial
> > > > state to disabled if a few conditions are met: the GPIO is
> > > > already
> > > > configured as output and disabled, and the backlight device tree
> > > > node
> > > > has a phandle pointing to it, so we can expect there to be some
> > > > controlling instance that will enable it when appropriate.
> > > > 
> > > > I wonder why in your case there is a phandle link to the
> > > > backlight node
> > > > but nothing actually enables the backlight during boot. I would
> > > > expect
> > > > that to be handled by the panel driver.
> > > 
> > > I had completely missed the fact that the panel driver is supposed
> > > to request
> > > backlight enable! With that in mind, this policy no longer
> > > concerns "the whole
> > > lifetime of the driver" but only the timeframe between backlight
> > > probe and
> > > panel
> > > probe. Thanks for clarifying this. I suppose I agree with this
> > > policy now.
> > > 
> > > So remains the question: why does the panel not enable backlight
> > > on my device?
> > > 
> > > I will investigate this later today. Hopefully, the probe defer
> > > logic should
> > > prevent a case where the panel is probed (to the end) before the
> > > backlight
> > > driver.
> > 
> > This is actually due to the tegra drm driver not probing. It is
> > happening on my
> > setup (with a somewhat custom, out-of-tree config) on both jetson-
> > tk1 and
> > nyan_big, but also on kernelci, running both tegra_defconfig and
> > multi_v7_defconfig.
> > 
> > Since this is no longer a concern related to the pwm backlight
> > driver, I will
> > start a new thread with the relevant addresses in CC.
> 
> Thanks for the update. Much appreciated!
> 
> BTW, I got the impression from your first mail that you are chasing a 
> regression between v4.11 and v4.12. If that's the case you should
> know 
> that the backlight changes we have been discussing landed in v4.11
> (so 
> if you do have a regression between these two releases then
> mentioning 
> backlight in the other thread may just be confusing).

That makes sense. The commit I had pointed out as offending was actually
not, this was just me hastily jumping to conclusions. I had just skipped
the fact that the display driver was supposed to re-enable backlight.

So this is definitely not backlight-related and I'm not going to mention
this in the follow-up discussion about the drm issue.

Cheers,

-- 
Paul Kocialkowski,

developer of free digital technology and hardware support

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

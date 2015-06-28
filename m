From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [Intel-gfx] [v3 0/7] Crystalcove (CRC) PMIC based panel and pwm
 control
Date: Sun, 28 Jun 2015 18:18:36 -0400
Message-ID: <20150628221836.GH4633@windriver.com>
References: <1435309330-50725-1-git-send-email-shobhit.kumar@intel.com>
 <20150626163137.GB30960@phenom.ffwll.local>
 <20150626174756.GC5176@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:58390 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbbF1WS6 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 28 Jun 2015 18:18:58 -0400
Content-Disposition: inline
In-Reply-To: <20150626174756.GC5176@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Shobhit Kumar <shobhit.kumar@intel.com>, linux-pwm <linux-pwm@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Paul Bolle <pebolle@tiscali.nl>, Samuel Ortiz <sameo@linux.intel.com>, Povilas Staniulis <wdmonster@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Linus Walleij <linus.walleij@linaro.org>, varkabhadram@gmail.com, bloften80@gmail.com, David Airlie <airlied@linux.ie>, Chih-Wei Huang <cwhuang@android-x86.org>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>

[Re: [Intel-gfx] [v3 0/7] Crystalcove (CRC) PMIC based panel and pwm co=
ntrol] On 26/06/2015 (Fri 20:47) Ville Syrj=E4l=E4 wrote:

> On Fri, Jun 26, 2015 at 06:31:37PM +0200, Daniel Vetter wrote:
> > On Fri, Jun 26, 2015 at 02:32:03PM +0530, Shobhit Kumar wrote:
> > > Hi,
> > > Next update of the series reviewed at=20
> > > https://lkml.org/lkml/2015/6/22/155
> > >=20
> > > Major changes are few review comments from Varka and Ville being =
addressed. Also except
> > > for intel-gfx patches, all patches reviesion history is moved out=
 of commit message.
> > >=20
> > > Hope this series finally finds its mark.
> > >=20
> > > Regards
> > > Shobhit
> > >=20
> > > Shobhit Kumar (7):
> > >   gpiolib: Add support for removing registered consumer lookup ta=
ble
> > >   mfd: intel_soc_pmic_core: Add lookup table for Panel Control as=
 GPIO
> > >     signal
> > >   mfd: intel_soc_pmic_crc: Add PWM cell device for Crystalcove PM=
IC
> > >   mfd: intel_soc_pmic_core: ADD PWM lookup table for CRC PMIC bas=
ed PWM
> > >   pwm: crc: Add Crystalcove (CRC) PWM driver
> > >   drm/i915: Use the CRC gpio for panel enable/disable
> > >   drm/i915: Backlight control using CRC PMIC based PWM driver
> >=20
> > I think we have r-b/acks on all the patches now. Ok if I pull this =
in
> > through drm-intel.git for 4.3? Or should I make a topic branch with=
 tag
> > and then send out pull requests to everyone? Or will each maintaine=
r merge
> > on their own since it's all only coupled at runtime anyway? Any of =
these
> > would suit me.
>=20
> I forgot to mention that I had a build failure due to
> builtin_platform_driver() when I tried this (just changed it to
> module_platform_driver() to get past it). So I'm not sure if this
> now depends on some tree which isn't included in -nightly...

builtin_platform_register does not yet exist in mainline; as Paul (the
other one) said earlier.  So you can either open-code what it does for
now, or use  module_platform_register.  If you do the latter, then
ensure you (temorarily) also include module.h or you risk additional
breakage in the future.

Paul.
--

>=20
> --=20
> Ville Syrj=E4l=E4
> Intel OTC
